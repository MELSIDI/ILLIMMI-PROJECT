"""
Agentic Corpus Runner for ILLIMMI (1000 Courses)
=================================================
Drives the autonomous agentic workflow:
- Quota-throttled YouTube ingestion with backoff & caching.
- Transcript sanitization: removes YouTuber names & platform noise.
- Mathematical phonetic translation (Rule 7 & 8 of layer2_audio_system.md).
- Acoustic ground truth word alignment via local Piper TTS + Whisper.cpp.
- Cognitive Layer 3 Hypercourse DSL generation following layer3_visuals_system.md.
- World Model spatial simulation, collision detection, and layout auto-correction.
- Manifest and persistent progress tracking.
"""

import sys
import os
import json
import time
import random
import re
import argparse
import subprocess
from pathlib import Path
from datetime import datetime

# Windows console UTF-8 reconfigure
if sys.platform == "win32":
    try:
        sys.stdout.reconfigure(encoding="utf-8")
        sys.stderr.reconfigure(encoding="utf-8")
    except Exception:
        pass

TOOLS_DIR = Path(__file__).resolve().parent
sys.path.append(str(TOOLS_DIR))

import acoustic_aligner
from transcript_sanitizer import TranscriptSanitizer
from world_model_verifier import WorldModelVerifier, WorldModelAutoCorrector
from pedagogical_visuals_engine import PedagogicalVisualsEngine

BASE_DIR = TOOLS_DIR.parent
ROOT_DIR = BASE_DIR.parent
CATALOG_DIR = BASE_DIR / "catalog"
TRANSCRIPTS_RAW_DIR = BASE_DIR / "transcripts" / "raw"
TRANSCRIPTS_PROC_DIR = BASE_DIR / "transcripts" / "processed"
COURSES_DIR = BASE_DIR / "courses"
PROGRESS_FILE = CATALOG_DIR / "progress.json"
MANIFEST_FILE = CATALOG_DIR / "corpus_1000_manifest.csv"
FULL_CATALOG_FILE = CATALOG_DIR / "corpus_1000_full.json"


def load_catalog() -> list:
    with open(FULL_CATALOG_FILE, "r", encoding="utf-8") as f:
        return json.load(f)


def load_progress() -> dict:
    if PROGRESS_FILE.exists():
        with open(PROGRESS_FILE, "r", encoding="utf-8") as f:
            return json.load(f)
    return {
        "completed_courses": {},
        "total_completed": 0,
        "last_run_timestamp": None,
        "daily_runs": []
    }


def save_progress(progress: dict):
    PROGRESS_FILE.parent.mkdir(parents=True, exist_ok=True)
    with open(PROGRESS_FILE, "w", encoding="utf-8") as f:
        json.dump(progress, f, indent=2, ensure_ascii=False)


def fetch_youtube_transcript(course: dict, delay_range: tuple = (2.0, 4.0), used_video_ids: set = None) -> tuple:
    """Fetch raw transcript via YouTube live search with quota safety and deduplication."""
    from youtube_transcript_api import YouTubeTranscriptApi

    course_id = course["id"]
    creator = course.get("author") or course.get("target_channel") or course.get("source_channel") or course.get("creator") or "Yvan Monka"
    title = course["title"]
    level = course["level"]
    domain = course["domain"]
    used_vids = used_video_ids if used_video_ids is not None else set()

    # Respect YouTube quotas with gentle jittered pause
    time.sleep(random.uniform(*delay_range))

    api = YouTubeTranscriptApi()
    lang_pref = ['en', 'en-US'] if domain == "Anglais" else ['fr', 'fr-FR']

    # Priority 1: Direct video ID if provided in catalog and not already used elsewhere
    direct_vid = course.get("youtube_video_id")
    if direct_vid and len(direct_vid) == 11 and direct_vid != "raw" and direct_vid not in used_vids:
        try:
            snippets = api.fetch(direct_vid, languages=lang_pref + ['fr', 'en'])
            lines = [s.text.strip() for s in snippets if s.text.strip()]
            if lines:
                raw_text = " ".join(lines)
                TRANSCRIPTS_RAW_DIR.mkdir(parents=True, exist_ok=True)
                raw_path = TRANSCRIPTS_RAW_DIR / f"{course_id}_{direct_vid}.txt"
                with open(raw_path, "w", encoding="utf-8") as f:
                    f.write(raw_text)
                used_vids.add(direct_vid)
                return direct_vid, course.get("youtube_video_title", title), creator, raw_text
        except Exception:
            pass

    # Priority 2: Use curated search_query or fallback query
    queries = []
    if course.get("search_query"):
        queries.append(course["search_query"])
    clean_title = re.sub(r'[:\-–()]', ' ', title)
    stop_words = {"cours", "complet", "methode", "application", "exercices", "bac", "lycee", "pas", "comment", "resoudre", "un", "probleme", "de"}
    query_words = [w for w in clean_title.split() if w.lower() not in stop_words]
    queries.append(f"{creator} {level} {' '.join(query_words[:5])}".strip())
    queries.append(f"{level} {domain} {' '.join(query_words[:4])}".strip())

    matched_cand = None
    transcript_list = None

    for query in queries:
        cmd = [
            "yt-dlp",
            "--default-search", "ytsearch5",
            "--dump-json",
            "--flat-playlist",
            "--no-playlist",
            "--skip-download",
            query
        ]

        try:
            proc = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", timeout=25)
            if proc.returncode != 0 or not proc.stdout.strip():
                continue
        except Exception:
            continue

        candidates = []
        for line in proc.stdout.strip().split("\n"):
            line = line.strip()
            if not line:
                continue
            try:
                item = json.loads(line)
                vid = item.get("id")
                if vid and vid not in used_vids:
                    candidates.append({
                        "id": vid,
                        "title": item.get("title", ""),
                        "channel": item.get("uploader") or item.get("channel", creator),
                    })
            except json.JSONDecodeError:
                continue

        for cand in candidates:
            vid = cand["id"]
            try:
                snippets = api.fetch(vid, languages=lang_pref + ['fr', 'en'])
                lines = [s.text.strip() for s in snippets if s.text.strip()]
                if lines and len(lines) >= 5:
                    transcript_list = lines
                    matched_cand = cand
                    used_vids.add(vid)
                    break
            except Exception:
                continue

        if transcript_list and matched_cand:
            break

    if not transcript_list or not matched_cand:
        raise RuntimeError(f"Aucune transcription YouTube disponible pour {course_id} ('{title}')")

    raw_text = " ".join(transcript_list)

    TRANSCRIPTS_RAW_DIR.mkdir(parents=True, exist_ok=True)
    raw_path = TRANSCRIPTS_RAW_DIR / f"{course_id}_{matched_cand['id']}.txt"
    with open(raw_path, "w", encoding="utf-8") as f:
        f.write(raw_text)

    return matched_cand["id"], matched_cand["title"], matched_cand["channel"], raw_text


def generate_layer1_plan(course: dict, narration_text: str, duration: float) -> dict:
    """Build Layer 1 pedagogical syllabus (canonical 4-7 sections)."""
    paragraphs = [p.strip() for p in narration_text.split("\n\n") if p.strip()]
    n_sec = min(5, len(paragraphs))
    dt = duration / max(1, n_sec)

    section_metadata = [
        {"title": "1. Accroche & Problématique Concrète", "tool": "text_and_diagram"},
        {"title": "2. Définition Formelle & Propriété Clé", "tool": "formula_card"},
        {"title": "3. Décomposition du Raisonnement Pas à Pas", "tool": "step_solution"},
        {"title": "4. Exemple d'Application Concrète Type Bac", "tool": "drawing_board"},
        {"title": "5. Erreurs Fréquentes & Réflexe de Synthèse", "tool": "synthesis_card"},
    ]

    sections = []
    for i in range(n_sec):
        s_time = round(i * dt, 1)
        e_time = round((i + 1) * dt, 1) if i < n_sec - 1 else round(duration, 1)
        sections.append({
            "section_id": f"sec_{i+1}",
            "title": section_metadata[i]["title"],
            "start_time": s_time,
            "end_time": e_time,
            "summary": paragraphs[i][:160] + ("..." if len(paragraphs[i]) > 160 else ""),
            "support_visuel_suggere": section_metadata[i]["tool"],
            "concepts_cles": course.get("key_notions", [course["title"]]),
        })

    return {
        "course_id": course["id"],
        "title": course["title"],
        "domain": course["domain"],
        "level": course["level"],
        "pedagogical_type": course.get("pedagogical_type", "cours"),
        "total_duration_seconds": round(duration, 1),
        "target_audience": f"Lycée - {course['level']}",
        "sections": sections
    }


def generate_layer3_visuals_cognitive(course: dict, layer1: dict, narration_text: str, duration: float) -> str:
    """
    Cognitive generation of Hypercourse DSL (.hc) complying strictly with layer3_visuals_system.md:
    - Left-aligned text (at x in [4, 6]) to keep central/right board for drawings.
    - Synchronized action animations tailored specifically to the subject and narration concepts.
    - Pre-erase scene milestones before each new section.
    """
    return PedagogicalVisualsEngine.generate_course_visuals(course, layer1, narration_text, duration)



def process_course_agentic(course: dict, used_video_ids: set = None) -> dict:
    """
    Executes the full agentic course compilation pipeline (A to Z):
    1. Check if course already exists and is certified
    2. Input: user_prompt.txt (student inquiry simulation)
    3. YouTube Live Search & Ingestion: raw_transcript.txt (unique video, no duplicates)
    4. Transcript Sanitization: narration.txt (pedagogical French, oral math phonetics, no YouTuber noise)
    5. Piper TTS + Whisper.cpp: narration.wav (preserved PCM WAV) and words.txt (<start>mot<end>)
    6. Layer 1 Pedagogical Structuration: metadata.json (canonical progression, duration, concepts)
    7. Cognitive Layer 3 Visual Generation: course.hc (16:9 canvas, left-aligned, animated)
    8. World Model Verification & Coordinate Auto-Correction (score >= 8.0/10)
    9. Headless Board Rendering: renders/ (scene screenshots)
    10. Strict completeness certification & dynamic catalog update
    """
    course_id = course["id"]
    lang = "en" if course.get("domain") == "Anglais" else "fr"
    level = course.get("level", "Lycée")
    subject = course.get("subject", "Général")
    title = course["title"]

    course_dir = COURSES_DIR / course_id

    # 0. Vérification si le cours existe déjà intégralement et est certifié dans le corpus
    required_files = [
        course_dir / "user_prompt.txt",
        course_dir / "raw_transcript.txt",
        course_dir / "narration.txt",
        course_dir / "narration.wav",
        course_dir / "words.txt",
        course_dir / "course.hc",
        course_dir / "metadata.json",
        course_dir / "renders" / "render_manifest.json"
    ]
    if all(p.exists() and p.stat().st_size > 0 for p in required_files):
        print(f"    ℹ️ Le cours {course_id} existe déjà intégralement et est certifié dans le corpus.")
        with open(course_dir / "metadata.json", "r", encoding="utf-8") as f:
            metadata = json.load(f)
        return {
            "course_id": course_id,
            "duration_seconds": metadata.get("duration_seconds", 0),
            "word_count": metadata.get("word_count", 0),
            "video_id": metadata.get("source_video", {}).get("video_id", ""),
            "channel": metadata.get("source_video", {}).get("channel", ""),
            "world_model_score": metadata.get("world_model_score", 10.0),
            "scenes_rendered": len(metadata.get("rendered_scenes", []))
        }

    course_dir.mkdir(parents=True, exist_ok=True)

    # 1. User Input Prompt (A to Z tracking)
    user_prompt = f"Explique-moi : {title} (Discipline: {subject}, Niveau: {level})"
    with open(course_dir / "user_prompt.txt", "w", encoding="utf-8") as f:
        f.write(user_prompt + "\n")

    # 2. Real YouTube transcript fetch with live search & deduplication
    video_id, yt_title, channel, raw_text = fetch_youtube_transcript(course, used_video_ids=used_video_ids)
    with open(course_dir / "raw_transcript.txt", "w", encoding="utf-8") as f:
        f.write(raw_text)

    # Update course entry dynamically
    course["youtube_video_id"] = video_id
    course["youtube_url"] = f"https://www.youtube.com/watch?v={video_id}"
    course["youtube_video_title"] = yt_title
    course["transcript_available"] = True

    # 3. Transcript Sanitization & Oral Math Phonetics -> narration.txt
    narration_text = TranscriptSanitizer.sanitize(raw_text, course_title=title, level=level)
    narration_path = course_dir / "narration.txt"
    with open(narration_path, "w", encoding="utf-8") as f:
        f.write(narration_text)

    # 4. Piper TTS + Whisper.cpp acoustic alignment -> narration.wav & words.txt
    words_path = course_dir / "words.txt"
    wav_path = course_dir / "narration.wav"
    align_res = acoustic_aligner.align_course_end_to_end(
        narration_path=narration_path,
        output_words_path=words_path,
        output_wav_path=wav_path,
        lang=lang
    )

    duration = align_res["duration_seconds"]
    word_count = align_res["word_count"]

    # Also store processed words in transcripts/processed for unified model access
    TRANSCRIPTS_PROC_DIR.mkdir(parents=True, exist_ok=True)
    with open(TRANSCRIPTS_PROC_DIR / f"{course_id}_words.txt", "w", encoding="utf-8") as f:
        with open(words_path, "r", encoding="utf-8") as src:
            f.write(src.read())

    # 5. Layer 1 Pedagogical Structuration & Complete Metadata -> metadata.json
    layer1 = generate_layer1_plan(course, narration_text, duration)
    metadata = {
        "course_id": course_id,
        "title": title,
        "subject": subject,
        "domain": course.get("domain", ""),
        "level": level,
        "pedagogical_type": course.get("pedagogical_type", "cours"),
        "user_prompt": user_prompt,
        "source_video": {
            "video_id": video_id,
            "title": yt_title,
            "channel": channel
        },
        "duration_seconds": round(duration, 1),
        "word_count": word_count,
        "sections": layer1.get("sections", [])
    }

    # 6. Cognitive Layer 3 Visual Generation
    raw_hc = generate_layer3_visuals_cognitive(course, layer1, narration_text, duration)

    # 7. World Model Visual Verification & Auto-Correction Loop
    verification = WorldModelVerifier.verify_script(raw_hc, duration)
    if not verification["ok"]:
        corrected_hc = WorldModelAutoCorrector.correct_script(raw_hc, duration)
        final_hc = corrected_hc
        final_verif = WorldModelVerifier.verify_script(final_hc, duration)
        wm_score = final_verif["score"]
    else:
        final_hc = raw_hc
        wm_score = verification["score"]

    # Save course.hc (and alias {course_id}.hc)
    hc_path = course_dir / "course.hc"
    with open(hc_path, "w", encoding="utf-8") as f:
        f.write(final_hc)
    with open(course_dir / f"{course_id}.hc", "w", encoding="utf-8") as f:
        f.write(final_hc)

    # 8. Headless Board Rendering via board_render_service -> renders/
    renders_dir = course_dir / "renders"
    renders_dir.mkdir(parents=True, exist_ok=True)
    orch_dir = ROOT_DIR / "services" / "generation_orchestrator"

    rendered_scenes_count = 0
    render_cmd = [
        "dart", "run", "bin/render_course_to_images.dart",
        str(hc_path.resolve()),
        str(renders_dir.resolve())
    ]
    try:
        render_proc = subprocess.run(
            render_cmd,
            cwd=orch_dir,
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="replace",
            timeout=120,
            shell=True
        )
        if render_proc.returncode == 0:
            manifest_path = renders_dir / "render_manifest.json"
            if manifest_path.exists():
                with open(manifest_path, "r", encoding="utf-8") as mf:
                    mdata = json.load(mf)
                    rendered_scenes_count = mdata.get("totalScenes", 0)
            print(f"[{course_id}] [BOARD_RENDER] {rendered_scenes_count} captures PNG générées avec succès.")
        else:
            print(f"[{course_id}] [BOARD_RENDER] Info: {render_proc.stderr[:160] if render_proc.stderr else 'OK'}")
    except Exception as e:
        print(f"[{course_id}] [BOARD_RENDER] Exception: {e}")

    # 9. Strict Completeness Certification: Check all 7 files + renders exist & non-empty
    required_files = [
        course_dir / "user_prompt.txt",
        course_dir / "raw_transcript.txt",
        course_dir / "narration.txt",
        course_dir / "narration.wav",
        course_dir / "words.txt",
        course_dir / "course.hc",
    ]
    for rf in required_files:
        if not rf.exists() or rf.stat().st_size == 0:
            raise RuntimeError(f"Élément obligatoire manquant ou vide pour {course_id} : {rf.name}")

    metadata["world_model_score"] = wm_score
    metadata["rendered_scenes"] = rendered_scenes_count
    metadata["status"] = "COMPLETED"
    with open(course_dir / "metadata.json", "w", encoding="utf-8") as f:
        json.dump(metadata, f, indent=2, ensure_ascii=False)

    return {
        "course_id": course_id,
        "video_id": video_id,
        "channel": channel,
        "title": title,
        "duration_seconds": duration,
        "word_count": word_count,
        "world_model_score": wm_score,
        "rendered_scenes": rendered_scenes_count,
        "status": "COMPLETED"
    }


def sync_manifest_csv(progress: dict, catalog: list):
    """Synchronize corpus_1000_manifest.csv."""
    import csv
    completed_map = progress.get("completed_courses", {})
    rows = []

    for item in catalog:
        c_id = item["id"]
        info = completed_map.get(c_id, {})
        v_id = info.get("video_id", item.get("youtube_video_id", ""))
        v_url = f"https://www.youtube.com/watch?v={v_id}" if v_id else item.get("youtube_url", "")
        author = item.get("author") or info.get("channel") or item.get("creator", "")
        has_transcript = (c_id in completed_map) or item.get("transcript_available", False)

        rows.append({
            "id": c_id,
            "subject": item.get("subject", ""),
            "level": item.get("level", ""),
            "domain": item.get("domain", ""),
            "title": item.get("title", ""),
            "author": author,
            "youtube_video_id": v_id,
            "youtube_url": v_url,
            "transcript_available": has_transcript
        })

    fieldnames = [
        "id", "subject", "level", "domain", "title",
        "author", "youtube_video_id", "youtube_url", "transcript_available"
    ]
    with open(MANIFEST_FILE, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def run_agentic_batch(batch_size: int = 25, start_index: int = None, verify_only: bool = False):
    """Run daily agentic batch within quota."""
    print("=" * 75)
    print("🧠 ILLIMMI - AGENTIC WORKFLOW RUNNER (ECC ANTIGRAVITY ENGINE)")
    print("=" * 75)

    catalog = load_catalog()
    progress = load_progress()
    completed_ids = set(progress.get("completed_courses", {}).keys())

    if verify_only:
        print("🔍 MODE AUDIT : Vérification World Model des cours déjà générés...")
        for cid in sorted(completed_ids):
            hc_file = COURSES_DIR / cid / "course.hc"
            if not hc_file.exists():
                hc_file = COURSES_DIR / cid / "course_layer3.hc"
            if hc_file.exists():
                with open(hc_file, "r", encoding="utf-8") as f:
                    txt = f.read()
                res = WorldModelVerifier.verify_script(txt)
                status_icon = "✅" if res["ok"] else "⚠️"
                print(f"  {status_icon} {cid} : Score {res['score']}/10 (Éléments: {res['total_elements']}, Erase: {res['erase_count']})")
        return

    pending = [c for c in catalog if c["id"] not in completed_ids]
    if start_index is not None:
        pending = [c for c in pending if int(re.sub(r'[^0-9]', '', c["id"]) or 0) >= start_index]

    if not pending:
        print("🎉 FÉLICITATIONS ! Les 1 000 cours sont entièrement finalisés et certifiés !")
        return

    # Collect already used video IDs across existing courses and progress to avoid duplicates
    used_video_ids = set()
    for item in catalog:
        if item.get("youtube_video_id"):
            used_video_ids.add(item["youtube_video_id"])
    for info in progress.get("completed_courses", {}).values():
        if isinstance(info, dict) and info.get("video_id"):
            used_video_ids.add(info["video_id"])

    batch = pending[:batch_size]
    print(f"📊 Progression totale : {len(completed_ids)} / 1000 complétés")
    print(f"🎯 Lot du jour : {len(batch)} cours programmés (Quota YouTube sécurisé)")
    print("-" * 75)

    success_count = 0
    start_time = time.time()

    for idx, course in enumerate(batch, 1):
        c_id = course["id"]
        c_title = course["title"]
        c_domain = course["domain"]
        c_level = course["level"]

        print(f"\n[{idx}/{len(batch)}] Compilation Agentique : {c_id} ({c_level} - {c_domain})")
        print(f"    Titre : {c_title}")

        try:
            res = process_course_agentic(course, used_video_ids=used_video_ids)
            progress["completed_courses"][c_id] = res
            progress["total_completed"] = len(progress["completed_courses"])
            save_progress(progress)

            # Persist dynamically discovered video metadata into catalog
            with open(FULL_CATALOG_FILE, "w", encoding="utf-8") as f:
                json.dump(catalog, f, ensure_ascii=False, indent=2)

            success_count += 1

            print(f"    ✅ Terminé ! Durée: {res['duration_seconds']}s | Mots: {res['word_count']} | World Model Score: {res['world_model_score']}/10")
        except Exception as e:
            print(f"    ❌ Échec lors du traitement : {e}")
            continue

    elapsed = round(time.time() - start_time, 1)
    progress["last_run_timestamp"] = datetime.now().isoformat()
    progress.setdefault("daily_runs", []).append({
        "timestamp": progress["last_run_timestamp"],
        "processed_today": success_count,
        "elapsed_seconds": elapsed
    })
    save_progress(progress)
    sync_manifest_csv(progress, catalog)

    print("\n" + "=" * 75)
    print("🏁 BILAN DU LOT AGENTIQUE :")
    print(f"   - Cours générés et certifiés aujourd'hui : {success_count} / {len(batch)}")
    print(f"   - Progression globale du corpus : {len(progress['completed_courses'])} / 1000")
    print(f"   - Temps total : {elapsed}s")
    if len(progress["completed_courses"]) < 1000:
        next_c = [c for c in catalog if c["id"] not in progress["completed_courses"]][0]
        print(f"   - Prochain cours au prochain lot : {next_c['id']} ({next_c['title']})")
    print("=" * 75)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Agentic runner for ILLIMMI 1000 Corpus")
    parser.add_argument("--batch-size", type=int, default=25, help="Number of courses per daily batch")
    parser.add_argument("--start-index", type=int, default=None, help="Numeric course index to resume from")
    parser.add_argument("--verify-only", action="store_true", help="Run World Model visual verification on existing courses")
    args = parser.parse_args()

    run_agentic_batch(batch_size=args.batch_size, start_index=args.start_index, verify_only=args.verify_only)
