#!/usr/bin/env python3
"""
Step 4 (Certification Gate): Finalize and certify a course in the ILLIMMI 1,000-course corpus.
Atomically updates:
- corpus_illimmi_1000/courses/<ID>/metadata.json
- corpus_illimmi_1000/catalog/progress.json
- corpus_illimmi_1000/catalog/corpus_1000_full.json
- corpus_illimmi_1000/catalog/corpus_1000_manifest.csv
"""

import argparse
import csv
import io
import json
import os
import shutil
import sys
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, List

if sys.platform == "win32":
    if isinstance(sys.stdout, io.TextIOWrapper):
        sys.stdout.reconfigure(encoding="utf-8")
    if isinstance(sys.stderr, io.TextIOWrapper):
        sys.stderr.reconfigure(encoding="utf-8")

THIS_DIR = Path(__file__).resolve().parent
PROJECT_ROOT = THIS_DIR.parents[3]
CORPUS_DIR = PROJECT_ROOT / "corpus_illimmi_1000"
COURSES_DIR = CORPUS_DIR / "courses"
CATALOG_DIR = CORPUS_DIR / "catalog"
CATALOG_FILE = CATALOG_DIR / "corpus_1000_full.json"
PROGRESS_FILE = CATALOG_DIR / "progress.json"
MANIFEST_FILE = CATALOG_DIR / "corpus_1000_manifest.csv"

if str(THIS_DIR) not in sys.path:
    sys.path.insert(0, str(THIS_DIR))
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))

from corpus_illimmi_1000.tools.world_model_verifier import WorldModelVerifier  # noqa: E402
from step2_align_audio import validate_layer1_and_layer2  # noqa: E402
from step3_render_and_verify import deep_audit_hc  # noqa: E402
from file_lock import InterprocessLock, atomic_write_json  # noqa: E402


def sync_manifest_csv(progress: Dict[str, Any], catalog: List[Dict[str, Any]]) -> None:
    completed_map = progress.get("completed_courses", {})
    rows: List[Dict[str, Any]] = []
    for item in catalog:
        c_id = item["id"]
        info = completed_map.get(c_id, {})
        v_id = info.get("video_id") or item.get("youtube_video_id", "")
        v_url = f"https://www.youtube.com/watch?v={v_id}" if v_id else item.get("youtube_url", "")
        author = item.get("author") or info.get("channel") or ""
        has_transcript = (c_id in completed_map) or bool(item.get("transcript_available", False))
        rows.append({
            "id": c_id,
            "subject": item.get("subject", ""),
            "level": item.get("level", ""),
            "domain": item.get("domain", ""),
            "title": item.get("title", ""),
            "author": author,
            "youtube_video_id": v_id,
            "youtube_url": v_url,
            "transcript_available": has_transcript,
        })

    fieldnames = [
        "id", "subject", "level", "domain", "title",
        "author", "youtube_video_id", "youtube_url", "transcript_available",
    ]
    import time
    tmp_csv = MANIFEST_FILE.with_name(f"{MANIFEST_FILE.stem}_{os.getpid()}_{time.time_ns()}.tmp")
    with open(tmp_csv, "w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)
    for attempt in range(12):
        try:
            os.replace(tmp_csv, MANIFEST_FILE)
            break
        except OSError:
            if attempt == 11:
                try:
                    if MANIFEST_FILE.exists():
                        MANIFEST_FILE.unlink()
                    os.replace(tmp_csv, MANIFEST_FILE)
                except Exception:
                    raise
            time.sleep(0.05 * (attempt + 1))


def main():
    parser = argparse.ArgumentParser(description="Step 4: Certify completed course and sync ILLIMMI corpus catalog.")
    parser.add_argument("--course-id", required=True, help="Target course ID (e.g. MATH_003)")
    parser.add_argument(
        "--visual-audit-notes",
        required=True,
        help="Concise visual inspection report after viewing every renders/scene_*.png via read_file.",
    )
    args = parser.parse_args()

    course_id = args.course_id.strip()
    audit_notes = args.visual_audit_notes.strip()
    if len(audit_notes) < 20:
        print(json.dumps({
            "ok": False,
            "error": "--visual-audit-notes must describe the visual check of rendered scene_*.png images (min 20 chars).",
        }))
        sys.exit(1)

    course_dir = COURSES_DIR / course_id
    renders_dir = course_dir / "renders"

    required_files = [
        course_dir / "user_prompt.txt",
        course_dir / "raw_transcript.txt",
        course_dir / "narration.txt",
        course_dir / "narration.wav",
        course_dir / "words.txt",
        course_dir / "course.hc",
        course_dir / "metadata.json",
        renders_dir / "render_manifest.json",
    ]
    missing = [str(p.name) for p in required_files if not p.exists() or p.stat().st_size == 0]
    if missing:
        print(json.dumps({
            "ok": False,
            "course_id": course_id,
            "error": f"Missing or empty required artifacts: {missing}",
        }))
        sys.exit(2)

    # Check PNG freshness relative to course.hc
    hc_path = course_dir / "course.hc"
    manifest_path = renders_dir / "render_manifest.json"
    if manifest_path.stat().st_mtime + 2.0 < hc_path.stat().st_mtime:
        print(json.dumps({
            "ok": False,
            "course_id": course_id,
            "error": "course.hc was modified AFTER renders/render_manifest.json! Re-run step3_render_and_verify.py and inspect the updated PNGs before certifying.",
        }))
        sys.exit(3)

    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    scene_entries = manifest.get("scenes", [])
    if len(scene_entries) < 2:
        print(json.dumps({
            "ok": False,
            "course_id": course_id,
            "error": f"Too few rendered scenes ({len(scene_entries)}). Expected at least 3 scenes (min 2 erase transitions).",
        }))
        sys.exit(4)

    for s in scene_entries:
        p = renders_dir / s["file"]
        if not p.exists() or p.stat().st_size == 0:
            print(json.dumps({"ok": False, "course_id": course_id, "error": f"Missing rendered PNG: {p}"}))
            sys.exit(4)

    # Validate Layer 1 & Layer 2
    l12_errors = validate_layer1_and_layer2(course_dir)
    if l12_errors:
        print(json.dumps({"ok": False, "course_id": course_id, "stage": "layer1_layer2", "errors": l12_errors}, indent=2, ensure_ascii=False))
        sys.exit(5)

    # Validate Layer 3 & WorldModel
    meta = json.loads((course_dir / "metadata.json").read_text(encoding="utf-8"))
    duration = float(meta.get("duration_seconds", 120.0))
    hc_text = hc_path.read_text(encoding="utf-8")
    shutil.copyfile(hc_path, course_dir / f"{course_id}.hc")

    hc_errors, _, _ = deep_audit_hc(
        hc_text,
        expected_audio_duration=duration,
        lock_starts_path=renders_dir / "initial_starts.json",
        unlock_starts=False,
    )
    wm_res = WorldModelVerifier.verify_script(hc_text, duration)
    if hc_errors or wm_res["score"] < 8.0:
        print(json.dumps({
            "ok": False,
            "course_id": course_id,
            "stage": "layer3_audit",
            "hc_errors": hc_errors,
            "world_model": wm_res,
        }, indent=2, ensure_ascii=False))
        sys.exit(6)

    word_count = sum(1 for line in (course_dir / "words.txt").read_text(encoding="utf-8").splitlines() if line.strip())
    now_iso = datetime.now().isoformat()

    # Synchronize shared catalog, progress, and manifest under exclusive lock (multi-subagent safe)
    catalog_lock_path = CATALOG_DIR / ".catalog_lock"
    with InterprocessLock(catalog_lock_path, timeout_sec=120.0):
        # Read FRESH catalog directly from disk inside the lock
        catalog = json.loads(CATALOG_FILE.read_text(encoding="utf-8"))
        cat_entry = next((c for c in catalog if c["id"] == course_id), None)
        if not cat_entry:
            print(json.dumps({"ok": False, "error": f"{course_id} not found in catalog"}))
            sys.exit(7)

        src_video = meta.get("source_video", {})
        if (course_dir / "raw_source.json").exists():
            raw_src = json.loads((course_dir / "raw_source.json").read_text(encoding="utf-8"))
            src_video = {
                "video_id": raw_src.get("video_id", src_video.get("video_id", "")),
                "title": raw_src.get("title", src_video.get("title", "")),
                "channel": raw_src.get("channel", src_video.get("channel", cat_entry.get("author", ""))),
                "youtube_url": raw_src.get("youtube_url", ""),
            }

        meta["course_id"] = course_id
        meta["title"] = cat_entry["title"]
        meta["subject"] = cat_entry.get("subject", meta.get("subject", ""))
        meta["domain"] = cat_entry.get("domain", meta.get("domain", ""))
        meta["level"] = cat_entry.get("level", meta.get("level", ""))
        meta["source_video"] = src_video
        meta["duration_seconds"] = round(duration, 2)
        meta["word_count"] = word_count
        meta["world_model_score"] = wm_res["score"]
        meta["rendered_scenes"] = len(scene_entries)
        meta["visual_audit_notes"] = audit_notes
        meta["certified_by"] = "antigravity-argon"
        meta["certified_at"] = now_iso
        meta["status"] = "COMPLETED"
        atomic_write_json(course_dir / "metadata.json", meta)

        # Update catalog item
        vid = src_video.get("video_id", "")
        if vid:
            cat_entry["youtube_video_id"] = vid
            cat_entry["youtube_url"] = f"https://www.youtube.com/watch?v={vid}"
            cat_entry["youtube_video_title"] = src_video.get("title", "")
        cat_entry["transcript_available"] = True
        cat_entry["transcript_words_count"] = word_count
        atomic_write_json(CATALOG_FILE, catalog)

        # Read FRESH progress.json directly from disk inside the lock
        progress: Dict[str, Any] = {"completed_courses": {}, "total_completed": 0, "last_run_timestamp": None, "daily_runs": []}
        if PROGRESS_FILE.exists():
            progress = json.loads(PROGRESS_FILE.read_text(encoding="utf-8"))

        progress.setdefault("completed_courses", {})[course_id] = {
            "course_id": course_id,
            "video_id": vid,
            "channel": src_video.get("channel", cat_entry.get("author", "")),
            "title": cat_entry["title"],
            "duration_seconds": round(duration, 2),
            "word_count": word_count,
            "world_model_score": wm_res["score"],
            "rendered_scenes": len(scene_entries),
            "certified_by": "antigravity-argon",
            "certified_at": now_iso,
            "status": "COMPLETED",
        }
        progress["total_completed"] = len(progress["completed_courses"])
        progress["last_run_timestamp"] = now_iso
        atomic_write_json(PROGRESS_FILE, progress)

        sync_manifest_csv(progress, catalog)

    print(json.dumps({
        "ok": True,
        "certified": True,
        "course_id": course_id,
        "title": cat_entry["title"],
        "duration_seconds": round(duration, 2),
        "word_count": word_count,
        "world_model_score": wm_res["score"],
        "rendered_scenes": len(scene_entries),
        "total_completed": progress["total_completed"],
        "remaining": len(catalog) - progress["total_completed"],
    }, indent=2, ensure_ascii=False))


if __name__ == "__main__":
    main()

