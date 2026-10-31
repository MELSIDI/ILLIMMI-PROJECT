#!/usr/bin/env python3
"""
Select the next pending batch of courses for the ILLIMMI 1,000-course corpus.
Reads catalog/corpus_1000_full.json and catalog/progress.json without mutating state.
"""

import argparse
import io
import json
import re
import sys
from pathlib import Path
from typing import Any, Dict

if sys.platform == "win32":
    if isinstance(sys.stdout, io.TextIOWrapper):
        sys.stdout.reconfigure(encoding="utf-8")
    if isinstance(sys.stderr, io.TextIOWrapper):
        sys.stderr.reconfigure(encoding="utf-8")

PROJECT_ROOT = Path(__file__).resolve().parents[4]
CORPUS_DIR = PROJECT_ROOT / "corpus_illimmi_1000"
CATALOG_FILE = CORPUS_DIR / "catalog" / "corpus_1000_full.json"
PROGRESS_FILE = CORPUS_DIR / "catalog" / "progress.json"
COURSES_DIR = CORPUS_DIR / "courses"


def is_course_certified_on_disk(course_id: str) -> bool:
    cdir = COURSES_DIR / course_id
    required = [
        cdir / "user_prompt.txt",
        cdir / "raw_transcript.txt",
        cdir / "narration.txt",
        cdir / "narration.wav",
        cdir / "words.txt",
        cdir / "course.hc",
        cdir / "metadata.json",
        cdir / "renders" / "render_manifest.json",
    ]
    return all(p.exists() and p.stat().st_size > 0 for p in required)


def main():
    parser = argparse.ArgumentParser(description="Select next pending courses for ILLIMMI corpus generation.")
    parser.add_argument("--batch-size", type=int, default=10, help="Number of courses to select (default: 10)")
    parser.add_argument("--course-id", type=str, default=None, help="Specific course ID or comma-separated IDs (e.g. MATH_003)")
    parser.add_argument("--subject", type=str, default=None, help="Filter by subject (Mathématiques, Physique-Chimie, Français, Anglais)")
    parser.add_argument("--start-index", type=int, default=None, help="Minimum numeric suffix to start from")
    parser.add_argument("--include-completed", action="store_true", help="Allow re-selecting already completed courses")
    args = parser.parse_args()

    if not CATALOG_FILE.exists():
        print(json.dumps({"ok": False, "error": f"Catalog file missing: {CATALOG_FILE}"}), file=sys.stderr)
        sys.exit(1)

    with open(CATALOG_FILE, "r", encoding="utf-8") as f:
        catalog = json.load(f)

    progress: Dict[str, Any] = {"completed_courses": {}}
    if PROGRESS_FILE.exists():
        with open(PROGRESS_FILE, "r", encoding="utf-8") as f:
            progress = json.load(f)

    completed_ids = set(progress.get("completed_courses", {}).keys())
    disk_certified_ids = {c["id"] for c in catalog if is_course_certified_on_disk(c["id"])}
    effective_completed = completed_ids | disk_certified_ids

    candidates = catalog

    if args.course_id:
        requested = {cid.strip() for cid in args.course_id.split(",") if cid.strip()}
        candidates = [c for c in candidates if c["id"] in requested]
    else:
        if not args.include_completed:
            candidates = [c for c in candidates if c["id"] not in effective_completed]
        if args.subject:
            subj_norm = args.subject.strip().lower()
            candidates = [c for c in candidates if subj_norm in c.get("subject", "").lower()]
        if args.start_index is not None:
            candidates = [
                c for c in candidates
                if int(re.sub(r"[^0-9]", "", c["id"]) or "0") >= args.start_index
            ]

    selected = candidates[: max(1, args.batch_size)] if not args.course_id else candidates

    summary = {
        "ok": True,
        "total_catalog": len(catalog),
        "completed_in_progress_json": len(completed_ids),
        "certified_on_disk": len(disk_certified_ids),
        "remaining_pending": len(catalog) - len(effective_completed),
        "selected_count": len(selected),
        "courses": [
            {
                "id": c["id"],
                "subject": c.get("subject", ""),
                "level": c.get("level", ""),
                "domain": c.get("domain", ""),
                "title": c.get("title", ""),
                "author": c.get("author", ""),
                "search_query": c.get("search_query", ""),
            }
            for c in selected
        ],
    }
    print(json.dumps(summary, indent=2, ensure_ascii=False))


if __name__ == "__main__":
    main()

