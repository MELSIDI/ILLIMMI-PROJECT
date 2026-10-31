#!/usr/bin/env python3
"""
Export genuine Gemma SFT fine-tuning JSONL datasets from certified courses on disk.
Reads actual certified artifacts in corpus_illimmi_1000/courses/<ID>/ instead of synthetic specs.
"""

import argparse
import io
import json
import sys
from pathlib import Path
from typing import Any, Dict, List

if sys.platform == "win32":
    if isinstance(sys.stdout, io.TextIOWrapper):
        sys.stdout.reconfigure(encoding="utf-8")
    if isinstance(sys.stderr, io.TextIOWrapper):
        sys.stderr.reconfigure(encoding="utf-8")

PROJECT_ROOT = Path(__file__).resolve().parents[4]
CORPUS_DIR = PROJECT_ROOT / "corpus_illimmi_1000"
COURSES_DIR = CORPUS_DIR / "courses"
PROMPTS_DIR = PROJECT_ROOT / "services" / "generation_orchestrator" / "prompts"
OUT_DIR = CORPUS_DIR / "training_data"


def load_prompt(name: str, fallback: str) -> str:
    p = PROMPTS_DIR / name
    return p.read_text(encoding="utf-8").strip() if p.exists() else fallback


def main():
    parser = argparse.ArgumentParser(description="Export Gemma SFT JSONL datasets from certified ILLIMMI courses.")
    parser.add_argument("--out-dir", type=str, default=str(OUT_DIR), help="Target directory for JSONL files")
    args = parser.parse_args()

    out_dir = Path(args.out_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    p_l1 = load_prompt("layer1_planner_system.md", "Tu es ILLIMMI Layer 1, ingénieur pédagogique.")
    p_l2 = load_prompt("layer2_audio_system.md", "Tu es ILLIMMI Layer 2, professeur narrateur.")
    p_l3 = load_prompt("layer3_visuals_system.md", "Tu es ILLIMMI Layer 3, compositeur Hypercourse.")

    l1_rows: List[Dict[str, Any]] = []
    l2_rows: List[Dict[str, Any]] = []
    l3_rows: List[Dict[str, Any]] = []

    for cdir in sorted(COURSES_DIR.iterdir()):
        if not cdir.is_dir():
            continue
        req = [cdir / "user_prompt.txt", cdir / "metadata.json", cdir / "narration.txt", cdir / "words.txt", cdir / "course.hc"]
        if not all(p.exists() and p.stat().st_size > 0 for p in req):
            continue

        cid = cdir.name
        user_prompt = (cdir / "user_prompt.txt").read_text(encoding="utf-8").strip()
        meta = json.loads((cdir / "metadata.json").read_text(encoding="utf-8"))
        narration = (cdir / "narration.txt").read_text(encoding="utf-8").strip()
        words = (cdir / "words.txt").read_text(encoding="utf-8").strip()
        hc = (cdir / "course.hc").read_text(encoding="utf-8").strip()

        plan_only = {
            "course_id": cid,
            "title": meta.get("title", ""),
            "subject": meta.get("subject", ""),
            "level": meta.get("level", ""),
            "domain": meta.get("domain", ""),
            "duration_seconds": meta.get("duration_seconds", 0),
            "sections": meta.get("sections", []),
        }

        l1_rows.append({
            "id": f"{cid}_L1",
            "task": "layer1_planning",
            "messages": [
                {"role": "system", "content": p_l1},
                {"role": "user", "content": user_prompt},
                {"role": "assistant", "content": json.dumps(plan_only, ensure_ascii=False, indent=2)},
            ],
        })

        l2_rows.append({
            "id": f"{cid}_L2",
            "task": "layer2_narration",
            "messages": [
                {"role": "system", "content": p_l2},
                {"role": "user", "content": json.dumps(plan_only, ensure_ascii=False, indent=2)},
                {"role": "assistant", "content": narration},
            ],
        })

        l3_rows.append({
            "id": f"{cid}_L3",
            "task": "layer3_visuals",
            "messages": [
                {"role": "system", "content": p_l3},
                {"role": "user", "content": f"PLAN:\n{json.dumps(plan_only, ensure_ascii=False)}\n\nTIMELINE:\n{words}"},
                {"role": "assistant", "content": hc},
            ],
        })

    def dump_jsonl(path: Path, rows: list):
        with open(path, "w", encoding="utf-8") as f:
            for r in rows:
                f.write(json.dumps(r, ensure_ascii=False) + "\n")

    dump_jsonl(out_dir / "certified_gemma_layer1_planner.jsonl", l1_rows)
    dump_jsonl(out_dir / "certified_gemma_layer2_audio.jsonl", l2_rows)
    dump_jsonl(out_dir / "certified_gemma_layer3_visuals.jsonl", l3_rows)
    dump_jsonl(out_dir / "certified_gemma_complete.jsonl", l1_rows + l2_rows + l3_rows)

    print(json.dumps({
        "ok": True,
        "certified_courses_exported": len(l1_rows),
        "total_sft_samples": len(l1_rows) * 3,
        "output_dir": str(out_dir),
    }, indent=2, ensure_ascii=False))


if __name__ == "__main__":
    main()
