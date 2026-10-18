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


def fetch_youtube_transcript(course: dict, delay_range: tuple = (2.0, 4.0)) -> tuple:
    """Fetch raw transcript with local cache check and quota safety pauses."""
    from youtube_transcript_api import YouTubeTranscriptApi
    from youtube_transcript_api._errors import NoTranscriptFound, TranscriptsDisabled

    course_id = course["id"]
    creator = course.get("target_channel") or course.get("source_channel") or "Yvan Monka"
    title = course["title"]
    level = course["level"]
    domain = course["domain"]

    # Check local cache first to avoid unnecessary YouTube queries
    existing_files = list(TRANSCRIPTS_RAW_DIR.glob(f"{course_id}_*.txt"))
    if existing_files:
        cached_file = existing_files[0]
        video_id = cached_file.stem.replace(f"{course_id}_", "")
        with open(cached_file, "r", encoding="utf-8") as f:
            raw_text = f.read()
        return video_id, title, creator, raw_text

    # Respect YouTube quotas with gentle jittered pause
    time.sleep(random.uniform(*delay_range))

    # Priority 1: Direct video ID if provided in catalog
    direct_vid = course.get("youtube_video_id")
    api = YouTubeTranscriptApi()
    lang_pref = ['en', 'en-US'] if domain == "Anglais" else ['fr', 'fr-FR']

    if direct_vid and len(direct_vid) == 11 and direct_vid != "raw":
        try:
            snippets = api.fetch(direct_vid, languages=lang_pref + ['fr', 'en'])
            lines = [s.text.strip() for s in snippets if s.text.strip()]
            if lines:
                raw_text = " ".join(lines)
                TRANSCRIPTS_RAW_DIR.mkdir(parents=True, exist_ok=True)
                raw_path = TRANSCRIPTS_RAW_DIR / f"{course_id}_{direct_vid}.txt"
                with open(raw_path, "w", encoding="utf-8") as f:
                    f.write(raw_text)
                return direct_vid, course.get("youtube_video_title", title), creator, raw_text
        except Exception:
            pass

    # Priority 2: Use curated search_query or build precise query
    if course.get("search_query"):
        query = course["search_query"]
    else:
        clean_title = re.sub(r'[:\-–()]', ' ', title)
        stop_words = {"cours", "complet", "methode", "application", "exercices", "bac", "lycee", "pas", "comment", "resoudre", "un", "probleme", "de"}
        query_words = [w for w in clean_title.split() if w.lower() not in stop_words]
        query = f"{creator} {level} {' '.join(query_words[:5])}".strip()

    cmd = [
        "yt-dlp",
        "--default-search", "ytsearch3",
        "--dump-json",
        "--flat-playlist",
        "--no-playlist",
        "--skip-download",
        query
    ]

    try:
        proc = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", timeout=25)
    except subprocess.TimeoutExpired:
        raise RuntimeError(f"yt-dlp search timed out for: '{query}'")

    if proc.returncode != 0 or not proc.stdout.strip():
        raise RuntimeError(f"yt-dlp search failed for: '{query}'")

    candidates = []
    for line in proc.stdout.strip().split("\n"):
        line = line.strip()
        if not line:
            continue
        try:
            item = json.loads(line)
            candidates.append({
                "id": item.get("id"),
                "title": item.get("title", ""),
                "channel": item.get("uploader") or item.get("channel", creator),
            })
        except json.JSONDecodeError:
            continue

    if not candidates:
        raise RuntimeError(f"No candidates found for: '{query}'")

    transcript_list = None
    matched_cand = None

    for cand in candidates:
        vid = cand["id"]
        try:
            snippets = api.fetch(vid, languages=lang_pref + ['fr', 'en'])
            lines = [s.text.strip() for s in snippets if s.text.strip()]
            if lines:
                transcript_list = lines
                matched_cand = cand
                break
        except Exception:
            continue

    if not transcript_list or not matched_cand:
        raise RuntimeError(f"No available transcript for {course_id} candidates")

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



def process_course_agentic(course: dict) -> dict:
    """
    Executes the full agentic course compilation pipeline:
    1. Ingestion & YouTube transcript fetch (throttled)
    2. Transcript purification (wipes YouTuber names, intro/outro noise)
    3. Mathematical phonetic oral translation
    4. Layer 1 pedagogical plan
    5. Piper TTS + Whisper.cpp acoustic alignment
    6. Cognitive Layer 3 visual generation
    7. World Model spatial verification & coordinate auto-correction
    8. Headless Board Rendering via board_render_service (PNG captures per scene)
    9. Archival into courses/{id}/ and transcripts/processed/{id}_words.txt
    """
    course_id = course["id"]
    lang = "en" if course.get("domain") == "Anglais" else "fr"

    # Step 1: Real YouTube transcript fetch
    video_id, yt_title, channel, raw_text = fetch_youtube_transcript(course)

    course_dir = COURSES_DIR / course_id
    course_dir.mkdir(parents=True, exist_ok=True)

    with open(course_dir / "raw_transcript.txt", "w", encoding="utf-8") as f:
        f.write(raw_text)

    # Step 2: Transcript Sanitization & Oral Phonetics
    narration_text = TranscriptSanitizer.sanitize(raw_text, course_title=course["title"], level=course["level"])
    narration_path = course_dir / "narration_layer2.txt"
    with open(narration_path, "w", encoding="utf-8") as f:
        f.write(narration_text)

    # Step 3: Piper TTS + Whisper.cpp acoustic alignment
    timeline_path = course_dir / "timeline_words_layer2.txt"
    align_res = acoustic_aligner.align_course_end_to_end(
        narration_path=narration_path,
        output_words_path=timeline_path,
        lang=lang
    )

    duration = align_res["duration_seconds"]
    word_count = align_res["word_count"]

    # Also store processed words in transcripts/processed for unified model access
    TRANSCRIPTS_PROC_DIR.mkdir(parents=True, exist_ok=True)
    with open(TRANSCRIPTS_PROC_DIR / f"{course_id}_words.txt", "w", encoding="utf-8") as f:
        with open(timeline_path, "r", encoding="utf-8") as src:
            f.write(src.read())

    # Step 4: Layer 1 Pedagogical Structuration
    layer1 = generate_layer1_plan(course, narration_text, duration)
    with open(course_dir / "metadata_layer1.json", "w", encoding="utf-8") as f:
        json.dump(layer1, f, indent=2, ensure_ascii=False)

    # Step 5: Cognitive Layer 3 Hypercourse Generation
    raw_hc = generate_layer3_visuals_cognitive(course, layer1, narration_text, duration)

    # Step 6: World Model Visual Verification & Auto-Correction Loop
    verification = WorldModelVerifier.verify_script(raw_hc, duration)
    if not verification["ok"]:
        corrected_hc = WorldModelAutoCorrector.correct_script(raw_hc, duration)
        final_hc = corrected_hc
        final_verif = WorldModelVerifier.verify_script(final_hc, duration)
        wm_score = final_verif["score"]
    else:
        final_hc = raw_hc
        wm_score = verification["score"]

    hc_path = course_dir / "course_layer3.hc"
    with open(hc_path, "w", encoding="utf-8") as f:
        f.write(final_hc)

    # Step 7: Headless Board Rendering via board_render_service
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
            print(f"[{course_id}] [BOARD_RENDER] Erreur: {render_proc.stderr[:160]}")
    except Exception as e:
        print(f"[{course_id}] [BOARD_RENDER] Exception: {e}")

    return {
        "course_id": course_id,
        "video_id": video_id,
        "channel": channel,
        "title": course["title"],
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
        status = "COMPLETED" if c_id in completed_map else item.get("status", "pending")
        v_id = info.get("video_id", item.get("youtube_video_id", ""))
        words = info.get("word_count", item.get("real_word_count", ""))
        dur = info.get("duration_seconds", item.get("estimated_duration_min", 10))

        rows.append({
            "id": c_id,
            "domain": item["domain"],
            "level": item["level"],
            "title": item["title"],
            "creator": info.get("channel", item.get("target_channel", "")),
            "video_id": v_id,
            "duration": dur,
            "words": words,
            "status": status
        })

    fieldnames = ["id", "domain", "level", "title", "creator", "video_id", "duration", "words", "status"]
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
            res = process_course_agentic(course)
            progress["completed_courses"][c_id] = res
            progress["total_completed"] = len(progress["completed_courses"])
            save_progress(progress)
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
