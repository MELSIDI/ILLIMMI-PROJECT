#!/usr/bin/env python3
"""
Step 1 (Plumbing): Quota-Safe YouTube Transcript Discovery & Deduplicated Ingestion.
Fetches a genuine, unique teacher transcript for a given course ID and writes:
- corpus_illimmi_1000/courses/<ID>/user_prompt.txt
- corpus_illimmi_1000/courses/<ID>/raw_transcript.txt
- corpus_illimmi_1000/courses/<ID>/raw_source.json
- corpus_illimmi_1000/transcripts/raw/<ID>_<VIDEO_ID>.txt
"""

import argparse
import io
import json
import random
import re
import subprocess
import sys
import time
from pathlib import Path
from typing import Any, Dict, List, Optional, Set, Tuple

if sys.platform == "win32":
    if isinstance(sys.stdout, io.TextIOWrapper):
        sys.stdout.reconfigure(encoding="utf-8")
    if isinstance(sys.stderr, io.TextIOWrapper):
        sys.stderr.reconfigure(encoding="utf-8")

MAX_VIDEO_DURATION_SECONDS = 3600  # Hard upstream filter: YouTube source video must be <= 1 hour

PROJECT_ROOT = Path(__file__).resolve().parents[4]
CORPUS_DIR = PROJECT_ROOT / "corpus_illimmi_1000"
CATALOG_FILE = CORPUS_DIR / "catalog" / "corpus_1000_full.json"
PROGRESS_FILE = CORPUS_DIR / "catalog" / "progress.json"
COURSES_DIR = CORPUS_DIR / "courses"
RAW_DIR = CORPUS_DIR / "transcripts" / "raw"
CLAIMS_DIR = RAW_DIR / ".claims" 


def collect_used_video_ids(exclude_course_id: str) -> Set[str]:
    used: Set[str] = set()

    if CATALOG_FILE.exists():
        with open(CATALOG_FILE, "r", encoding="utf-8") as f:
            for item in json.load(f):
                if item.get("id") != exclude_course_id and item.get("youtube_video_id"):
                    used.add(item["youtube_video_id"])

    if PROGRESS_FILE.exists():
        with open(PROGRESS_FILE, "r", encoding="utf-8") as f:
            prog = json.load(f)
            for cid, info in prog.get("completed_courses", {}).items():
                if cid != exclude_course_id and isinstance(info, dict) and info.get("video_id"):
                    used.add(info["video_id"])

    if COURSES_DIR.exists():
        for cdir in COURSES_DIR.iterdir():
            if not cdir.is_dir() or cdir.name == exclude_course_id:
                continue
            for meta_name in ("raw_source.json", "metadata.json"):
                mp = cdir / meta_name
                if mp.exists():
                    try:
                        with open(mp, "r", encoding="utf-8") as mf:
                            data = json.load(mf)
                        vid = data.get("video_id") or data.get("source_video", {}).get("video_id")
                        if vid:
                            used.add(vid)
                    except Exception:
                        pass

    if RAW_DIR.exists():
        for tf in RAW_DIR.glob("*.txt"):
            # Pattern: <COURSE_ID>_<11CHAR_VID>.txt
            stem = tf.stem
            if not stem.startswith(f"{exclude_course_id}_"):
                parts = stem.rsplit("_", 1)
                if len(parts) == 2 and len(parts[1]) == 11:
                    used.add(parts[1])

    if CLAIMS_DIR.exists():
        for cf in CLAIMS_DIR.glob("*.claim"):
            used.add(cf.stem)

    return used


def fetch_video_metadata(video_id: str) -> Dict[str, Any]:
    """Fetch exact duration, title, and channel for a single YouTube video via yt-dlp."""
    cmd = [
        "yt-dlp",
        "--dump-json",
        "--no-playlist",
        "--skip-download",
        f"https://www.youtube.com/watch?v={video_id}",
    ]
    proc = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace", timeout=30)
    if proc.returncode != 0 or not proc.stdout.strip():
        return {}
    try:
        item = json.loads(proc.stdout.strip().splitlines()[0])
        return {
            "id": video_id,
            "title": item.get("title", ""),
            "channel": item.get("uploader") or item.get("channel") or "",
            "duration": float(item.get("duration") or 0.0),
        }
    except Exception:
        return {}


def fetch_captions_for_video(video_id: str, lang_pref: List[str]) -> Tuple[str, float]:
    from youtube_transcript_api import YouTubeTranscriptApi

    langs = lang_pref + ["fr", "fr-FR", "en", "en-US", "en-GB"]
    # Support both youtube-transcript-api >= 1.0 (.fetch) and 0.6.x (.get_transcript)
    try:
        api = YouTubeTranscriptApi()
        if hasattr(api, "fetch"):
            snippets = list(api.fetch(video_id, languages=langs))
            lines = [s.text.strip() for s in snippets if getattr(s, "text", "").strip()]
            span_end = 0.0
            if snippets:
                last = snippets[-1]
                span_end = float(getattr(last, "start", 0.0) or 0.0) + float(getattr(last, "duration", 0.0) or 0.0)
            return " ".join(lines), span_end
    except Exception:
        pass

    get_fn = getattr(YouTubeTranscriptApi, "get_transcript", None)
    if callable(get_fn):
        items = get_fn(video_id, languages=langs)
        if isinstance(items, list):
            lines = [
                str(it.get("text", "")).strip()
                for it in items
                if isinstance(it, dict) and str(it.get("text", "")).strip()
            ]
            span_end = 0.0
            if items and isinstance(items[-1], dict):
                span_end = float(items[-1].get("start", 0.0) or 0.0) + float(items[-1].get("duration", 0.0) or 0.0)
            return " ".join(lines), span_end

    raise RuntimeError(f"Unable to fetch transcript for video {video_id}")


def search_youtube_candidates(query: str, used_vids: Set[str], max_results: int = 8) -> List[Dict[str, Any]]:
    cmd = [
        "yt-dlp",
        "--default-search", f"ytsearch{max_results}",
        "--dump-json",
        "--flat-playlist",
        "--no-playlist",
        "--skip-download",
        query,
    ]
    proc = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8", errors="replace", timeout=35)
    if proc.returncode != 0 or not proc.stdout.strip():
        return []

    candidates: List[Dict[str, Any]] = []
    for line in proc.stdout.strip().splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            item = json.loads(line)
            vid = item.get("id")
            raw_dur = item.get("duration")
            dur = float(raw_dur) if isinstance(raw_dur, (int, float)) else 0.0
            if dur > MAX_VIDEO_DURATION_SECONDS:
                continue
            if vid and len(vid) == 11 and vid not in used_vids:
                candidates.append({
                    "id": vid,
                    "title": item.get("title", ""),
                    "channel": item.get("uploader") or item.get("channel") or "",
                    "duration": dur,
                })
        except json.JSONDecodeError:
            continue
    return candidates


def main():
    parser = argparse.ArgumentParser(description="Step 1: Quota-safe YouTube transcript ingestion.")
    parser.add_argument("--course-id", required=True, help="Target course ID (e.g. MATH_003)")
    parser.add_argument("--video-id", default=None, help="Optional explicit 11-char YouTube video ID")
    parser.add_argument("--force", action="store_true", help="Re-fetch even if cached raw_transcript.txt exists")
    args = parser.parse_args()

    course_id = args.course_id.strip()

    with open(CATALOG_FILE, "r", encoding="utf-8") as f:
        catalog = json.load(f)

    course = next((c for c in catalog if c["id"] == course_id), None)
    if not course:
        print(json.dumps({"ok": False, "error": f"Course ID '{course_id}' not found in catalog."}))
        sys.exit(1)

    course_dir = COURSES_DIR / course_id
    course_dir.mkdir(parents=True, exist_ok=True)
    RAW_DIR.mkdir(parents=True, exist_ok=True)

    user_prompt = f"Explique-moi : {course['title']} (Discipline: {course.get('subject', '')}, Niveau: {course.get('level', '')})"
    user_prompt_path = course_dir / "user_prompt.txt"
    with open(user_prompt_path, "w", encoding="utf-8") as f:
        f.write(user_prompt + "\n")

    raw_txt_path = course_dir / "raw_transcript.txt"
    raw_src_path = course_dir / "raw_source.json"

    # Reuse existing cached raw transcript for this course unless --force (if video duration <= 1h)
    if not args.force and raw_txt_path.exists() and raw_txt_path.stat().st_size > 200:
        raw_text = raw_txt_path.read_text(encoding="utf-8").strip()
        src_info: Dict[str, Any] = {}
        if raw_src_path.exists():
            src_info = json.loads(raw_src_path.read_text(encoding="utf-8"))
        elif (course_dir / "metadata.json").exists():
            meta = json.loads((course_dir / "metadata.json").read_text(encoding="utf-8"))
            src_info = meta.get("source_video", {})
        cached_dur = float(src_info.get("duration_seconds") or 0.0)
        if cached_dur <= MAX_VIDEO_DURATION_SECONDS:
            print(json.dumps({
                "ok": True,
                "cached": True,
                "course_id": course_id,
                "course": course,
                "source_video": src_info,
                "raw_word_count": len(raw_text.split()),
                "raw_transcript_path": str(raw_txt_path),
                "user_prompt_path": str(user_prompt_path),
                "next_step": "Clean and structure the ENTIRE raw_transcript.txt into metadata.json (Layer 1) and narration.txt (Layer 2) WITHOUT summarizing or truncating it, then run step2_align_audio.py.",
            }, indent=2, ensure_ascii=False))
            return

    # Multi-subagent jittered stagger: spread YouTube discovery across concurrent agents
    num_match = re.search(r'\d+', course_id)
    course_num = int(num_match.group(0)) if num_match else 0
    stagger_sec = ((course_num % 5) * 1.8) + random.uniform(1.0, 2.5)
    time.sleep(stagger_sec)

    used_vids = collect_used_video_ids(exclude_course_id=course_id)
    is_english = course.get("subject", "").lower() == "anglais" or "anglais" in course.get("domain", "").lower()
    lang_pref = ["en", "en-US", "en-GB"] if is_english else ["fr", "fr-FR"]

    matched_vid: Optional[str] = None
    matched_title = ""
    matched_channel = course.get("author", "")
    matched_duration = 0.0
    raw_text = ""

    # Priority 1: Explicit --video-id or catalog direct video_id (must be <= 3600s)
    direct_vid = args.video_id or course.get("youtube_video_id")
    if direct_vid and len(direct_vid) == 11 and direct_vid not in used_vids:
        try:
            vmeta = fetch_video_metadata(direct_vid)
            vdur = float(vmeta.get("duration") or 0.0)
            if vdur <= MAX_VIDEO_DURATION_SECONDS:
                candidate_txt, span_end = fetch_captions_for_video(direct_vid, lang_pref)
                effective_dur = max(vdur, span_end)
                if effective_dur <= MAX_VIDEO_DURATION_SECONDS and len(candidate_txt.split()) >= 60:
                    matched_vid = direct_vid
                    matched_title = vmeta.get("title") or course.get("youtube_video_title") or course["title"]
                    matched_channel = vmeta.get("channel") or matched_channel
                    matched_duration = round(effective_dur, 1)
                    raw_text = candidate_txt
        except Exception:
            pass

    # Priority 2: Curated search queries (strictly filtered to duration <= 3600s)
    if not matched_vid:
        author = course.get("author", "")
        level = course.get("level", "")
        domain = course.get("domain", "")
        clean_title = re.sub(r"[:\-–()—]", " ", course["title"])
        stop_words = {
            "cours", "fondamental", "definitions", "définitions", "methode", "méthode",
            "pas", "comment", "resoudre", "résoudre", "un", "probleme", "problème", "de",
            "exemple", "guide", "guidé", "calcul", "detaille", "détaillé", "en", "pratique",
            "correction", "exercice", "classique", "entrainement", "entraînement", "lycee", "lycée",
            "type", "bac", "raisonnement", "plusieurs", "etapes", "étapes", "revision", "révision",
            "express", "fiche", "synthese", "synthèse", "tout", "retenir", "sur"
        }
        core_words = [w for w in clean_title.split() if w.lower() not in stop_words]

        queries: List[str] = []
        if course.get("search_query"):
            queries.append(course["search_query"])
        queries.append(f"{author} {level} {' '.join(core_words[:6])}".strip())
        queries.append(f"{level} {domain} {' '.join(core_words[:5])}".strip())
        queries.append(f"cours {course.get('subject', '')} {' '.join(core_words[:5])}".strip())

        for q in queries:
            if not q:
                continue
            cands = search_youtube_candidates(q, used_vids, max_results=8)
            for cand in cands:
                try:
                    cand_dur = float(cand.get("duration") or 0.0)
                    if cand_dur > MAX_VIDEO_DURATION_SECONDS:
                        continue
                    if cand_dur <= 0.0:
                        vmeta = fetch_video_metadata(cand["id"])
                        cand_dur = float(vmeta.get("duration") or 0.0)
                        if cand_dur > MAX_VIDEO_DURATION_SECONDS:
                            continue
                    time.sleep(random.uniform(0.8, 1.6))
                    txt, span_end = fetch_captions_for_video(cand["id"], lang_pref)
                    effective_dur = max(cand_dur, span_end)
                    if effective_dur <= MAX_VIDEO_DURATION_SECONDS and len(txt.split()) >= 80:
                        matched_vid = cand["id"]
                        matched_title = cand["title"]
                        matched_channel = cand["channel"] or author
                        matched_duration = round(effective_dur, 1)
                        raw_text = txt
                        break
                except Exception:
                    continue
            if matched_vid:
                break

    if not matched_vid or not raw_text:
        print(json.dumps({
            "ok": False,
            "course_id": course_id,
            "error": f"Could not retrieve a valid unique YouTube transcript (<= 1h) for {course_id} ('{course['title']}').",
        }, ensure_ascii=False))
        sys.exit(2)

    # Reserve claim for multi-subagent coordination
    CLAIMS_DIR.mkdir(parents=True, exist_ok=True)
    claim_path = CLAIMS_DIR / f"{matched_vid}.claim"
    try:
        with open(claim_path, "w", encoding="utf-8") as cf:
            json.dump({"course_id": course_id, "timestamp": time.time(), "video_id": matched_vid}, cf)
    except Exception:
        pass

    with open(raw_txt_path, "w", encoding="utf-8") as f:
        f.write(raw_text + "\n")

    archive_raw_path = RAW_DIR / f"{course_id}_{matched_vid}.txt"
    with open(archive_raw_path, "w", encoding="utf-8") as f:
        f.write(raw_text + "\n")

    src_payload = {
        "course_id": course_id,
        "video_id": matched_vid,
        "youtube_url": f"https://www.youtube.com/watch?v={matched_vid}",
        "title": matched_title,
        "channel": matched_channel,
        "duration_seconds": matched_duration,
        "raw_word_count": len(raw_text.split()),
    }
    with open(raw_src_path, "w", encoding="utf-8") as f:
        json.dump(src_payload, f, indent=2, ensure_ascii=False)

    print(json.dumps({
        "ok": True,
        "cached": False,
        "course_id": course_id,
        "course": course,
        "source_video": src_payload,
        "raw_transcript_path": str(raw_txt_path),
        "user_prompt_path": str(user_prompt_path),
        "next_step": "Read raw_transcript.txt in full, then author metadata.json (Layer 1) and narration.txt (Layer 2) preserving the ENTIRE cleaned pedagogical content (never summarize or cap word/scene counts!), and run step2_align_audio.py.",
    }, indent=2, ensure_ascii=False))


if __name__ == "__main__":
    main()

