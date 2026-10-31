#!/usr/bin/env python3
"""
Step 2 (Plumbing + Guardrails): Validate Layer 1 & Layer 2, then run Piper TTS + Whisper.cpp.
Validates:
- courses/<ID>/metadata.json (4-7 canonical sections, rich visual tools)
- courses/<ID>/narration.txt (clean spoken pedagogy, zero raw LaTeX/Markdown/YouTuber leaks, visual anchors)
Produces:
- courses/<ID>/narration.wav (22.05kHz PCM WAV)
- courses/<ID>/words.txt (monotonic <start>word<end> compact timeline)
- transcripts/processed/<ID>_words.txt
"""

import argparse
import io
import json
import re
import shutil
import sys
from pathlib import Path
from typing import List

if sys.platform == "win32":
    if isinstance(sys.stdout, io.TextIOWrapper):
        sys.stdout.reconfigure(encoding="utf-8")
    if isinstance(sys.stderr, io.TextIOWrapper):
        sys.stderr.reconfigure(encoding="utf-8")

PROJECT_ROOT = Path(__file__).resolve().parents[4]
CORPUS_DIR = PROJECT_ROOT / "corpus_illimmi_1000"
COURSES_DIR = CORPUS_DIR / "courses"
PROCESSED_DIR = CORPUS_DIR / "transcripts" / "processed"
AUDIO_MODELS_DIR = PROJECT_ROOT / "services" / "audio_service" / "speaker" / "piper" / "model"

if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))

from corpus_illimmi_1000.tools import acoustic_aligner  # noqa: E402


FORBIDDEN_NARRATION_PATTERNS = [
    (r"\$", "Raw '$' LaTeX delimiter detected in narration.txt (write math in spoken phonetics)"),
    (r"\\(frac|vec|overrightarrow|infty|mathbb|sqrt|le|leq|ge|geq|cap|cup|iff|implies|times|cdot)\b",
     "Raw LaTeX command detected in narration.txt"),
    (r"\b[a-zA-Z0-9]\^[0-9n]\b", "Raw caret exponent (e.g. x^2) detected in narration.txt (write 'x au carré')"),
    (r"\b[uv]_\{?[n01]", "Raw subscript (e.g. u_n) detected in narration.txt (write 'u indice n')"),
    (r"(\*\*|^#+\s|\[bold\]|\[color=)", "Markdown or BBCode formatting detected in narration.txt"),
    (r"\[(musique|applaudissements|rires)\]", "Raw YouTube caption tag detected in narration.txt"),
    (r"(?i)\b(yvan\s+monka|m@ths|maths\s+et\s+tiques|florence\s+raffin|romain\s+bourdel|paul\s+olivier|am[eé]lie\s+vioux|jaicompris|exo7|mmmenglish|english\s+with\s+lucy)\b",
     "Creator/channel name leak detected in narration.txt"),
    (r"(?i)\b(abonne[- ]toi|vous\s+abonner|pouce\s+bleu|active[rz]?\s+la\s+cloche|lien\s+(est\s+)?dans\s+la\s+description|dans\s+cette\s+vid[eé]o)\b",
     "YouTube platform noise ('vidéo', 'abonne-toi', 'pouce bleu', etc.) detected in narration.txt"),
]

VISUAL_ANCHOR_PATTERNS = [
    r"(?i)\b(tra[çc]ons|dessinons|pla[çc]ons|regardons|regarde|observons|observe|repr[eé]sentons|construisons|suivons|colorons|encadrons|notons|affichons|d[eé]pla[çc]ons|soulignons|relions|hachurons)\b",
    r"(?i)\b(sur\s+cet\s+axe|sur\s+le\s+tableau|sur\s+ce\s+rep[eè]re|[àa]\s+gauche|[àa]\s+droite|au\s+tableau|sur\s+la\s+figure|sur\s+le\s+graphique)\b",
    r"(?i)\b(let's\s+draw|let's\s+trace|look\s+at|on\s+the\s+board|notice\s+how|let's\s+plot|on\s+the\s+right|on\s+the\s+left)\b",
]


def validate_layer1_and_layer2(course_dir: Path, allow_condensed: bool = False) -> List[str]:
    errors: List[str] = []
    meta_path = course_dir / "metadata.json"
    narr_path = course_dir / "narration.txt"
    raw_path = course_dir / "raw_transcript.txt"
    is_already_completed = False

    if not meta_path.exists():
        errors.append(f"Missing Layer 1 file: {meta_path}")
    else:
        try:
            meta = json.loads(meta_path.read_text(encoding="utf-8"))
            is_already_completed = str(meta.get("status", "")).upper() == "COMPLETED"
            sections = meta.get("sections", [])
            if not isinstance(sections, list) or len(sections) < 3:
                errors.append(f"metadata.json must have at least 3 pedagogical sections (found {len(sections) if isinstance(sections, list) else 'invalid'}; no upper limit).")
            else:
                text_only_count = 0
                for idx, sec in enumerate(sections, 1):
                    for key in ("section_id", "title", "summary", "support_visuel_suggere"):
                        if not sec.get(key):
                            errors.append(f"Section {idx} in metadata.json is missing required field '{key}'.")
                    vis = str(sec.get("support_visuel_suggere", "")).strip().lower()
                    if vis == "text":
                        text_only_count += 1
                if sections and text_only_count > len(sections) // 2:
                    errors.append(
                        f"Too many 'text'-only sections in metadata.json ({text_only_count}/{len(sections)}). "
                        "Use geometric/graphical visual tools (draw 2drep, draw line, draw arrow, draw circle, draw polygone, etc.)."
                    )
        except Exception as e:
            errors.append(f"Invalid JSON in metadata.json: {e}")

    if not narr_path.exists():
        errors.append(f"Missing Layer 2 file: {narr_path}")
    else:
        narration = narr_path.read_text(encoding="utf-8").strip()
        words = narration.split()
        if len(words) < 40:
            errors.append(f"narration.txt is empty or broken ({len(words)} words).")

        # Guard against accidental LLM summarization of long transcripts (zero upper cap on words!)
        if raw_path.exists() and not allow_condensed and not is_already_completed:
            raw_words = len(raw_path.read_text(encoding="utf-8").split())
            if raw_words >= 700 and len(words) < int(raw_words * 0.55):
                errors.append(
                    f"TRUNCATION/SUMMARIZATION DETECTED: raw_transcript.txt has {raw_words} words, "
                    f"but narration.txt only has {len(words)} words! NEVER cap or condense the course: "
                    "keep the ENTIRE pedagogical content, examples, and calculations of the cleaned transcript "
                    "(pass --allow-condensed ONLY if >45% of raw_transcript.txt was non-course YouTube chatter)."
                )

        for pat, msg in FORBIDDEN_NARRATION_PATTERNS:
            m = re.search(pat, narration, flags=re.MULTILINE | re.IGNORECASE)
            if m:
                snippet = narration[max(0, m.start() - 25): min(len(narration), m.end() + 25)].replace("\n", " ")
                errors.append(f"{msg} -> '...{snippet}...'")

        anchor_hits = sum(len(re.findall(p, narration)) for p in VISUAL_ANCHOR_PATTERNS)
        if anchor_hits < 2:
            errors.append(
                f"narration.txt has only {anchor_hits} spoken visual guidance anchors. "
                "Include at least 3 explicit visual action phrases ('traçons...', 'plaçons sur cet axe...', 'regarde à droite...', etc.)."
            )

    return errors


def detect_audio_lang(course_dir: Path) -> str:
    """
    Use English Whisper/Piper only if an English Piper ONNX model is installed AND narration is English.
    Otherwise use French ('fr'), which works seamlessly for French lessons and French-explained English courses.
    """
    en_models = list(AUDIO_MODELS_DIR.glob("en_*.onnx")) if AUDIO_MODELS_DIR.exists() else []
    meta_path = course_dir / "metadata.json"
    if meta_path.exists() and en_models:
        try:
            meta = json.loads(meta_path.read_text(encoding="utf-8"))
            if str(meta.get("subject", "")).lower() == "anglais":
                acoustic_aligner.PIPER_MODEL_FR = en_models[0]
                return "en"
        except Exception:
            pass
    return "fr"


def main():
    parser = argparse.ArgumentParser(description="Step 2: Validate Layer 1/2 and run Piper TTS + Whisper.cpp alignment (no word/duration cap).")
    parser.add_argument("--course-id", required=True, help="Target course ID (e.g. MATH_003)")
    parser.add_argument("--allow-condensed", action="store_true", help="Only set if >45%% of raw_transcript.txt was non-course YouTube promo/chatter")
    args = parser.parse_args()

    course_id = args.course_id.strip()
    course_dir = COURSES_DIR / course_id
    if not course_dir.exists():
        print(json.dumps({"ok": False, "error": f"Course directory does not exist: {course_dir}"}))
        sys.exit(1)

    errors = validate_layer1_and_layer2(course_dir, allow_condensed=args.allow_condensed)
    if errors:
        print(json.dumps({
            "ok": False,
            "course_id": course_id,
            "stage": "layer1_layer2_validation",
            "errors": errors,
        }, indent=2, ensure_ascii=False))
        sys.exit(2)

    narr_path = course_dir / "narration.txt"
    words_path = course_dir / "words.txt"
    wav_path = course_dir / "narration.wav"
    lang = detect_audio_lang(course_dir)

    align_res = acoustic_aligner.align_course_end_to_end(
        narration_path=narr_path,
        output_words_path=words_path,
        output_wav_path=wav_path,
        lang=lang,
    )

    PROCESSED_DIR.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(words_path, PROCESSED_DIR / f"{course_id}_words.txt")

    # Reset any previous visual lock file because a brand-new audio timeline was synthesized
    lock_file = course_dir / "renders" / "initial_starts.json"
    if lock_file.exists():
        lock_file.unlink()

    # Update duration_seconds and word_count in metadata.json
    meta_path = course_dir / "metadata.json"
    meta = json.loads(meta_path.read_text(encoding="utf-8"))
    meta["duration_seconds"] = round(float(align_res["duration_seconds"]), 2)
    meta["word_count"] = int(align_res["word_count"])
    if (course_dir / "raw_source.json").exists():
        src = json.loads((course_dir / "raw_source.json").read_text(encoding="utf-8"))
        meta["source_video"] = {
            "video_id": src.get("video_id", ""),
            "title": src.get("title", ""),
            "channel": src.get("channel", ""),
            "youtube_url": src.get("youtube_url", ""),
        }
    with open(meta_path, "w", encoding="utf-8") as f:
        json.dump(meta, f, indent=2, ensure_ascii=False)

    print(json.dumps({
        "ok": True,
        "course_id": course_id,
        "duration_seconds": meta["duration_seconds"],
        "word_count": meta["word_count"],
        "audio_path": str(wav_path),
        "words_path": str(words_path),
        "next_step": "Read words.txt (<start>word<end>) and author courses/<ID>/course.hc synchronized to exact word timestamps, then run step3_render_and_verify.py.",
    }, indent=2, ensure_ascii=False))


if __name__ == "__main__":
    main()

