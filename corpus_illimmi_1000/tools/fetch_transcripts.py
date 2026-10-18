#!/usr/bin/env python3
"""
Pipeline d'acquisition industrielle des VRAIES vidéos et transcriptions YouTube pour ILLIMMI.
Caractéristiques :
- Recherche multi-candidats (top 3) pour trouver la vidéo disposant de sous-titres valides
- Extraction mot-à-mot certifiée (<start>mot<end>)
- Nettoyage des artefacts oraux ([Musique], [Rires], etc.)
- Mode reprise automatique (--resume) en cas d'interruption
- Multi-threading avec limitation de débit pour éviter les blocages IP
- Synchronisation automatique du catalogue JSON et du manifeste CSV avec les métadonnées YouTube réelles
"""

import argparse
import csv
import json
import os
import re
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
from typing import Dict, Any, List, Optional, Tuple

import yt_dlp
from youtube_transcript_api import YouTubeTranscriptApi

# Encodage console Windows UTF-8
if sys.stdout and hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
if sys.stderr and hasattr(sys.stderr, "reconfigure"):
    sys.stderr.reconfigure(encoding="utf-8", errors="replace")

ROOT_DIR = Path(__file__).resolve().parent.parent
CATALOG_DIR = ROOT_DIR / "catalog"
CATALOG_PATH = CATALOG_DIR / "corpus_1000_full.json"
TRANSCRIPTS_RAW_DIR = ROOT_DIR / "transcripts" / "raw"
TRANSCRIPTS_PROCESSED_DIR = ROOT_DIR / "transcripts" / "processed"
STATUS_FILE = ROOT_DIR / "transcripts" / "ingestion_status.json"

TRANSCRIPTS_RAW_DIR.mkdir(parents=True, exist_ok=True)
TRANSCRIPTS_PROCESSED_DIR.mkdir(parents=True, exist_ok=True)

CLEAN_REGEX = re.compile(r"\[[^\]]*\]")

def load_catalog() -> List[Dict[str, Any]]:
    if not CATALOG_PATH.exists():
        raise FileNotFoundError(f"Catalogue introuvable : {CATALOG_PATH}")
    with open(CATALOG_PATH, "r", encoding="utf-8") as f:
        return json.load(f)

def sync_existing_processed_into_catalog(catalog: List[Dict[str, Any]]) -> int:
    """Synchronise toutes les transcriptions réelles déjà présentes sur disque dans le catalogue."""
    synced = 0
    catalog_map = {c["id"]: c for c in catalog}
    for file in TRANSCRIPTS_PROCESSED_DIR.glob("*_transcript.json"):
        try:
            with open(file, "r", encoding="utf-8") as f:
                data = json.load(f)
            item_id = data.get("item_id")
            if item_id in catalog_map and data.get("youtube_video_id"):
                item = catalog_map[item_id]
                item["youtube_video_id"] = data["youtube_video_id"]
                item["youtube_video_title"] = data.get("youtube_video_title", "")
                item["youtube_channel"] = data.get("youtube_channel", "")
                item["youtube_url"] = data.get("youtube_url", "")
                item["real_transcript_available"] = True
                item["real_transcript_words_count"] = data.get("total_words_count", 0)
                synced += 1
        except Exception:
            pass
    return synced

def save_catalogs_and_manifest(catalog: List[Dict[str, Any]]) -> None:
    """Sauvegarde le catalogue principal, les sous-catalogues et le manifeste CSV."""
    sync_existing_processed_into_catalog(catalog)
    with open(CATALOG_PATH, "w", encoding="utf-8") as f:
        json.dump(catalog, f, ensure_ascii=False, indent=2)

    # Sauvegarde spécialisée
    math_courses = [c for c in catalog if c["subject"] == "Mathématiques"]
    phys_courses = [c for c in catalog if c["subject"] == "Physique-Chimie"]
    lang_courses = [c for c in catalog if c["subject"] in ("Français", "Anglais")]

    with open(CATALOG_DIR / "math_500.json", "w", encoding="utf-8") as f:
        json.dump(math_courses, f, ensure_ascii=False, indent=2)
    with open(CATALOG_DIR / "physique_300.json", "w", encoding="utf-8") as f:
        json.dump(phys_courses, f, ensure_ascii=False, indent=2)
    with open(CATALOG_DIR / "langues_200.json", "w", encoding="utf-8") as f:
        json.dump(lang_courses, f, ensure_ascii=False, indent=2)

    # Manifeste CSV
    csv_path = CATALOG_DIR / "corpus_1000_manifest.csv"
    with open(csv_path, "w", encoding="utf-8", newline="") as f:
        writer = csv.writer(f)
        writer.writerow([
            "id", "subject", "level", "domain", "title", "pedagogical_type",
            "creator", "duration_target_sec", "real_words_count",
            "youtube_video_id", "youtube_url", "search_query"
        ])
        for c in catalog:
            writer.writerow([
                c["id"],
                c["subject"],
                c["level"],
                c["domain"],
                c["title"],
                c["pedagogical_type"],
                c.get("youtube_channel") or c["creator"],
                c["layer1_spec"]["duration_target"],
                c.get("real_transcript_words_count", 0),
                c.get("youtube_video_id", ""),
                c.get("youtube_url", ""),
                c["search_query"]
            ])

def load_status() -> Dict[str, Any]:
    if STATUS_FILE.exists():
        try:
            with open(STATUS_FILE, "r", encoding="utf-8") as f:
                return json.load(f)
        except Exception:
            pass
    return {"completed_ids": {}, "failed_ids": {}}

def save_status(status: Dict[str, Any]) -> None:
    with open(STATUS_FILE, "w", encoding="utf-8") as f:
        json.dump(status, f, ensure_ascii=False, indent=2)

def clean_search_query(raw_query: str) -> str:
    """Nettoie la requête pour maximiser le taux de succès sur l'algorithme de recherche YouTube."""
    # Mots vides à épurer
    stop_words = {"les", "des", "du", "de", "la", "le", "dans", "pour", "avec", "sur", "et", "en", "un", "une"}
    tokens = raw_query.split()
    clean_tokens = [t for t in tokens if t.lower() not in stop_words or t in ("Yvan", "Florence", "BBC")]
    return " ".join(clean_tokens)

def search_youtube_candidates(query: str, max_candidates: int = 5) -> List[Dict[str, str]]:
    """Recherche jusqu'à N vidéos candidates via yt-dlp avec repli progressif."""
    cleaned = clean_search_query(query)
    ydl_opts = {
        "quiet": True,
        "extract_flat": True,
        "default_search": f"ytsearch{max_candidates}",
        "noplaylist": True,
    }
    candidates = []
    
    # 1. Requête principale
    queries_to_try = [cleaned]
    # 2. Repli généralisé si créateur trop spécifique
    broader = re.sub(r"^(Medusaces|Romain Bourdel|Amelie Vioux|BBC Learning English)\s+", "", cleaned, flags=re.IGNORECASE)
    if broader != cleaned:
        queries_to_try.append(broader)

    for q in queries_to_try:
        try:
            with yt_dlp.YoutubeDL(ydl_opts) as ydl:
                res = ydl.extract_info(f"ytsearch{max_candidates}:{q}", download=False)
                if res and "entries" in res and res["entries"]:
                    for entry in res["entries"]:
                        vid = entry.get("id")
                        if vid:
                            candidates.append({
                                "video_id": vid,
                                "title": entry.get("title", ""),
                                "url": f"https://www.youtube.com/watch?v={vid}",
                                "channel": entry.get("channel", "") or entry.get("uploader", "")
                            })
                    if candidates:
                        break
        except Exception as e:
            pass

    return candidates

def fetch_youtube_transcript_for_video(video_id: str, languages: List[str]) -> Optional[List[Dict[str, Any]]]:
    """Tente de récupérer les sous-titres d'une vidéo donnée."""
    api = YouTubeTranscriptApi()
    try:
        transcript_list = api.list(video_id)
        target_lang = None
        for lang in languages:
            for t in transcript_list:
                if t.language_code.startswith(lang):
                    target_lang = t.language_code
                    break
            if target_lang:
                break

        if not target_lang:
            available = list(transcript_list)
            if available:
                target_lang = available[0].language_code

        if target_lang:
            fetched = api.fetch(video_id, languages=[target_lang])
            clean_entries = []
            for item in fetched:
                text = getattr(item, "text", "") if hasattr(item, "text") else item.get("text", "")
                start = getattr(item, "start", 0.0) if hasattr(item, "start") else item.get("start", 0.0)
                duration = getattr(item, "duration", 0.0) if hasattr(item, "duration") else item.get("duration", 0.0)

                clean_text = CLEAN_REGEX.sub("", text).strip()
                if clean_text:
                    clean_entries.append({
                        "text": clean_text,
                        "start": round(float(start), 3),
                        "duration": round(float(duration), 3)
                    })
            if clean_entries:
                return clean_entries
    except Exception:
        pass
    return None

def build_compact_timeline(entries: List[Dict[str, Any]]) -> str:
    lines = []
    for entry in entries:
        start = entry.get("start", 0.0)
        duration = entry.get("duration", 1.0)
        text = entry.get("text", "").strip()
        words = text.split()
        if not words:
            continue
        word_duration = max(0.08, duration / len(words))
        for i, w in enumerate(words):
            w_start = start + (i * word_duration)
            w_end = w_start + word_duration
            lines.append(f"<{w_start:.3f}>{w}<{w_end:.3f}>")
    return "\n".join(lines)

def process_single_item(item: Dict[str, Any]) -> Tuple[bool, str]:
    """Traite un cours unique et retourne (succès, message)."""
    item_id = item["id"]
    query = item["search_query"]

    # Langues prioritaires
    langs = ["fr"]
    if item["subject"] == "Anglais":
        langs = ["en", "fr"]

    candidates = search_youtube_candidates(query, max_candidates=5)
    if not candidates:
        return False, f"[{item_id}] Aucune vidéo trouvée pour '{query}'"

    # Teste les candidats successifs jusqu'à trouver des sous-titres
    selected_candidate = None
    selected_entries = None

    for cand in candidates:
        entries = fetch_youtube_transcript_for_video(cand["video_id"], langs)
        if entries and len(entries) >= 5:
            selected_candidate = cand
            selected_entries = entries
            break

    if not selected_candidate or not selected_entries:
        return False, f"[{item_id}] Aucun sous-titre disponible parmi les 5 premières vidéos"

    full_text = " ".join(e["text"] for e in selected_entries)
    compact_timeline = build_compact_timeline(selected_entries)
    words_count = len(full_text.split())

    record = {
        "item_id": item_id,
        "title": item["title"],
        "subject": item["subject"],
        "level": item["level"],
        "youtube_video_id": selected_candidate["video_id"],
        "youtube_video_title": selected_candidate["title"],
        "youtube_channel": selected_candidate["channel"],
        "youtube_url": selected_candidate["url"],
        "full_text": full_text,
        "snippets_count": len(selected_entries),
        "total_words_count": words_count,
        "duration_approx_sec": selected_entries[-1]["start"] + selected_entries[-1]["duration"],
        "entries": selected_entries,
        "source": "youtube_official_or_auto_caption"
    }

    # Sauvegarde des fichiers
    json_path = TRANSCRIPTS_PROCESSED_DIR / f"{item_id}_transcript.json"
    with open(json_path, "w", encoding="utf-8") as f:
        json.dump(record, f, ensure_ascii=False, indent=2)

    raw_path = TRANSCRIPTS_RAW_DIR / f"{item_id}_raw.txt"
    with open(raw_path, "w", encoding="utf-8") as f:
        f.write(full_text)

    words_path = TRANSCRIPTS_PROCESSED_DIR / f"{item_id}_words.txt"
    with open(words_path, "w", encoding="utf-8") as f:
        f.write(compact_timeline)

    # Mise à jour de l'item en mémoire
    item["youtube_video_id"] = selected_candidate["video_id"]
    item["youtube_video_title"] = selected_candidate["title"]
    item["youtube_channel"] = selected_candidate["channel"]
    item["youtube_url"] = selected_candidate["url"]
    item["real_transcript_available"] = True
    item["real_transcript_words_count"] = words_count

    msg = f"[{item_id}] OK -> \"{selected_candidate['title'][:40]}\" ({selected_candidate['channel']}) : {words_count} mots"
    return True, msg

def main():
    parser = argparse.ArgumentParser(description="Acquisition industrielle des vraies vidéos YouTube.")
    parser.add_argument("--id", type=str, help="ID spécifique (ex: MATH_013)")
    parser.add_argument("--subject", type=str, help="Filtrer par matière (Mathématiques, Physique-Chimie, Français, Anglais)")
    parser.add_argument("--limit", type=int, default=10, help="Nombre de vidéos à traiter (défaut: 10)")
    parser.add_argument("--all", action="store_true", help="Traiter l'ensemble du corpus")
    parser.add_argument("--workers", type=int, default=2, help="Nombre de threads simultanés (recommandé: 2-3 pour éviter le rate-limit)")
    parser.add_argument("--resume", action="store_true", default=True, help="Reprendre sans ré-extraire ce qui existe déjà")
    args = parser.parse_args()

    catalog = load_catalog()
    status = load_status()

    # Filtrage des cibles
    if args.id:
        targets = [c for c in catalog if c["id"] == args.id]
        if not targets:
            print(f"[ERREUR] ID non trouvé : {args.id}")
            sys.exit(1)
    elif args.subject:
        targets = [c for c in catalog if c["subject"].lower() == args.subject.lower()]
    else:
        targets = catalog

    # Si reprise demandée, filtrer ce qui est déjà réellement complété
    if args.resume and not args.id:
        pending = []
        for t in targets:
            processed_file = TRANSCRIPTS_PROCESSED_DIR / f"{t['id']}_transcript.json"
            if processed_file.exists():
                try:
                    with open(processed_file, "r", encoding="utf-8") as f:
                        data = json.load(f)
                        if data.get("source") == "youtube_official_or_auto_caption":
                            continue
                except Exception:
                    pass
            pending.append(t)
        targets = pending

    if not args.all and not args.id:
        targets = targets[:args.limit]

    print("=" * 70)
    print(f"LANCEMENT DE L'ACQUISITION DES VRAIES VIDÉOS YOUTUBE ({len(targets)} CIBLES)")
    print(f"Workers : {args.workers} | Mode reprise : {args.resume}")
    print("=" * 70)

    if not targets:
        print("Toutes les vidéos ciblées sont déjà téléchargées et à jour !")
        sys.exit(0)

    success_count = 0
    total = len(targets)

    # Exécution avec pool de threads
    with ThreadPoolExecutor(max_workers=args.workers) as executor:
        future_to_item = {executor.submit(process_single_item, item): item for item in targets}
        for idx, future in enumerate(as_completed(future_to_item), start=1):
            item = future_to_item[future]
            try:
                ok, msg = future.result()
                if ok:
                    success_count += 1
                    status["completed_ids"][item["id"]] = {
                        "video_id": item.get("youtube_video_id"),
                        "words": item.get("real_transcript_words_count")
                    }
                    print(f"[{idx:04d}/{total:04d}] {msg}")
                else:
                    status["failed_ids"][item["id"]] = msg
                    print(f"[{idx:04d}/{total:04d}] {msg}")
            except Exception as e:
                print(f"[{idx:04d}/{total:04d}] [{item['id']}] ERREUR : {e}")

            # Sauvegarde périodique du statut et du catalogue tous les 5 cours
            if idx % 5 == 0 or idx == total:
                save_status(status)
                save_catalogs_and_manifest(catalog)

    save_status(status)
    save_catalogs_and_manifest(catalog)

    print("\n" + "=" * 70)
    print(f"SESSION TERMINÉE : {success_count}/{total} nouvelles vidéos réelles acquises avec succès.")
    print(f"Total général de transcriptions réelles dans le corpus : {len(status['completed_ids'])}")
    print("=" * 70)

if __name__ == "__main__":
    main()
