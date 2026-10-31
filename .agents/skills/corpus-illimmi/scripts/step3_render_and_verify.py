#!/usr/bin/env python3
"""
Step 3 (Plumbing + Deep Guardrails): Audit Hypercourse (.hc), run WorldModelVerifier,
and execute Headless Flutter Board Rendering to produce PNG captures for Argon visual inspection.

Catches subtle Dart HypercourseParser bugs automatically:
1. Duplicate element IDs across scenes (which silently overwrite earlier elements in Dart's globalRegistry).
2. Out-of-range IDs relative to `idgap` (text: 1..G, draw: G+1..2G, mouse: 3G+1..4G, erase: 4G+1..5G).
3. Accidental `''` inside LaTeX strings (e.g. `f''(x)` instead of `f^{\\prime\\prime}(x)`), closing strings early.
4. Raw `[` or `]` interval brackets outside `$...$` in BBCode strings.
5. Opaque white background cards or dark unreadable text colors on the green chalkboard.
6. Elements whose `start + duration` exceeds the next `erase` timestamp (breaking pre-erase PNG capture).
7. Mutated `start` timestamps during visual-correction iterations (violating Layer 3 Verifier Rule 17).
"""

import argparse
import io
import json
import re
import shutil
import subprocess
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

if sys.platform == "win32":
    if isinstance(sys.stdout, io.TextIOWrapper):
        sys.stdout.reconfigure(encoding="utf-8")
    if isinstance(sys.stderr, io.TextIOWrapper):
        sys.stderr.reconfigure(encoding="utf-8")

PROJECT_ROOT = Path(__file__).resolve().parents[4]
CORPUS_DIR = PROJECT_ROOT / "corpus_illimmi_1000"
COURSES_DIR = CORPUS_DIR / "courses"
ORCH_DIR = PROJECT_ROOT / "services" / "generation_orchestrator"

if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))

from corpus_illimmi_1000.tools.world_model_verifier import WorldModelVerifier  # noqa: E402


VALID_BBCODE_TAG_RE = re.compile(
    r"\[(?:/?bold|/?italic|color=#[0-9a-fA-F]{6}|/color|font=[a-zA-Z0-9 _-]+|/font)\]"
)
DARK_HEX_COLORS_RE = re.compile(
    r"\[color=#(0[0-9a-fA-F]{5}|1[0-9a-fA-F]{5}|2[0-4][0-9a-fA-F]{4})\]"
)


def tokenize_hc_statements(script: str) -> Tuple[Dict[str, Any], List[Dict[str, Any]], List[str]]:
    """
    Faithful mirror of Dart's Tokenizer + statement splitter so we detect syntax,
    early-closed '' strings, duplicate IDs, and idgap violations before Dart runs.
    """
    errors: List[str] = []
    n = len(script)
    pos = 0
    tokens: List[Tuple[str, str, int]] = []  # (kind, value, line_no)
    line_no = 1

    while pos < n:
        ch = script[pos]
        if ch in " \t\r\n":
            if ch == "\n":
                line_no += 1
            pos += 1
        elif ch == "#":
            while pos < n and script[pos] != "\n":
                pos += 1
        elif ch == '"':
            start_line = line_no
            pos += 1
            buf = []
            while pos < n and script[pos] != '"':
                if script[pos] == "\n":
                    line_no += 1
                buf.append(script[pos])
                pos += 1
            if pos >= n:
                errors.append(f"Line {start_line}: Unclosed double-quoted string.")
                break
            pos += 1
            tokens.append(("DQ_STR", "".join(buf), start_line))
        elif ch == "'":
            start_line = line_no
            if pos + 1 >= n or script[pos + 1] != "'":
                snippet = script[max(0, pos - 15): min(n, pos + 25)].replace("\n", " ")
                errors.append(
                    f"Line {start_line}: Stray single quote outside ''...'' string (did f''(x) close ''...'' early? "
                    f"Use f^{{\\prime\\prime}}(x) for second derivatives!): ...{snippet}..."
                )
                pos += 1
                continue
            pos += 2
            buf = []
            closed = False
            while pos < n:
                if script[pos] == "'" and pos + 1 < n and script[pos + 1] == "'":
                    pos += 2
                    closed = True
                    break
                if script[pos] == "\n":
                    line_no += 1
                buf.append(script[pos])
                pos += 1
            if not closed:
                errors.append(f"Line {start_line}: Unclosed ''...'' text string.")
                break
            tokens.append(("SQ_STR", "".join(buf), start_line))
        elif ch.isdigit() or ((ch in "+-") and pos + 1 < n and script[pos + 1].isdigit()):
            # Check identifier starting with digit like 2drep / 2dfunc
            look = pos
            if script[look] in "+-":
                look += 1
            while look < n and (script[look].isdigit() or script[look] == "."):
                look += 1
            is_ident = False
            if ch.isdigit() and look < n and script[look].isalpha():
                rem = script[look:]
                if not (rem.startswith("ms") or rem.startswith("min") or (rem[0] in "smh" and (len(rem) == 1 or not rem[1].isalnum()))):
                    is_ident = True
            if is_ident:
                buf = []
                while pos < n and (script[pos].isalnum() or script[pos] == "_"):
                    buf.append(script[pos])
                    pos += 1
                tokens.append(("IDENT", "".join(buf), line_no))
            else:
                buf = [script[pos]]
                pos += 1
                while pos < n and (script[pos].isdigit() or script[pos] == "."):
                    buf.append(script[pos])
                    pos += 1
                tokens.append(("NUM", "".join(buf), line_no))
        elif ch.isalpha() or ch == "_":
            buf = []
            while pos < n and (script[pos].isalnum() or script[pos] == "_"):
                buf.append(script[pos])
                pos += 1
            tokens.append(("IDENT", "".join(buf), line_no))
        else:
            tokens.append(("PUNCT", ch, line_no))
            pos += 1

    # Parse header before '{'
    header: Dict[str, Any] = {"title": "", "id": 1, "idgap": 100, "duration": 0.0, "audio": ""}
    idx = 0
    while idx < len(tokens) and not (tokens[idx][0] == "PUNCT" and tokens[idx][1] == "{"):
        kind, val, _ = tokens[idx]
        if kind == "IDENT" and val == "id" and idx + 1 < len(tokens) and tokens[idx + 1][0] == "NUM":
            header["id"] = int(float(tokens[idx + 1][1]))
            idx += 2
            continue
        if kind == "IDENT" and val == "idgap" and idx + 1 < len(tokens) and tokens[idx + 1][0] == "NUM":
            header["idgap"] = int(float(tokens[idx + 1][1]))
            idx += 2
            continue
        if kind == "IDENT" and val == "for" and idx + 1 < len(tokens) and tokens[idx + 1][0] == "NUM":
            header["duration"] = float(tokens[idx + 1][1])
            idx += 2
            continue
        if kind == "IDENT" and val == "audio" and idx + 1 < len(tokens) and tokens[idx + 1][0] == "DQ_STR":
            header["audio"] = tokens[idx + 1][1]
            idx += 2
            continue
        if kind == "DQ_STR" and not header["title"]:
            header["title"] = val
        idx += 1

    if idx >= len(tokens):
        errors.append("Missing opening '{' in course block.")
        return header, [], errors

    idx += 1  # skip '{'
    statements: List[Dict[str, Any]] = []
    curr_tokens: List[Tuple[str, str, int]] = []

    while idx < len(tokens):
        t = tokens[idx]
        if t[0] == "PUNCT" and t[1] == "}" and not curr_tokens:
            break
        if t[0] == "PUNCT" and t[1] == ";":
            if curr_tokens:
                cmd = curr_tokens[0][1]
                cmd_line = curr_tokens[0][2]
                subcmd = curr_tokens[1][1] if len(curr_tokens) > 1 and curr_tokens[1][0] == "IDENT" else ""
                elem_id: Optional[int] = None
                start_t: Optional[float] = None
                dur_t: float = 0.0
                sq_strings: List[str] = [tk[1] for tk in curr_tokens if tk[0] == "SQ_STR"]

                for k_i in range(len(curr_tokens) - 1):
                    if curr_tokens[k_i][0] == "IDENT" and curr_tokens[k_i][1] == "id" and curr_tokens[k_i + 1][0] == "NUM":
                        elem_id = int(float(curr_tokens[k_i + 1][1]))
                    elif curr_tokens[k_i][0] == "IDENT" and curr_tokens[k_i][1] == "start" and curr_tokens[k_i + 1][0] == "NUM":
                        start_t = float(curr_tokens[k_i + 1][1])
                    elif curr_tokens[k_i][0] == "IDENT" and curr_tokens[k_i][1] == "for" and curr_tokens[k_i + 1][0] == "NUM":
                        dur_t = float(curr_tokens[k_i + 1][1])

                statements.append({
                    "cmd": cmd,
                    "subcmd": subcmd,
                    "line": cmd_line,
                    "id": elem_id,
                    "start": start_t,
                    "duration": dur_t,
                    "strings": sq_strings,
                })
                curr_tokens = []
        else:
            curr_tokens.append(t)
        idx += 1

    return header, statements, errors


def check_text_bbcode_and_colors(stmt: Dict[str, Any]) -> List[str]:
    errs: List[str] = []
    for s in stmt["strings"]:
        if "\\'" in s:
            errs.append(f"Line {stmt['line']} (id {stmt['id']}): Do not escape apostrophes as \\' inside ''...'' (write plain ').")
        if DARK_HEX_COLORS_RE.search(s):
            errs.append(
                f"Line {stmt['line']} (id {stmt['id']}): Dark hex color detected on green chalkboard. "
                "Use bright chalk colors (#F8FAFC, #38BDF8, #34D399, #FBBF24, #F87171, #C084FC)."
            )
        # Strip $$...$$ and $...$ math regions before checking for stray BBCode brackets
        no_math = re.sub(r"\$\$.*?\$\$", "", s, flags=re.DOTALL)
        no_math = re.sub(r"\$.*?\$", "", no_math, flags=re.DOTALL)
        no_tags = VALID_BBCODE_TAG_RE.sub("", no_math)
        if "[" in no_tags or "]" in no_tags:
            errs.append(
                f"Line {stmt['line']} (id {stmt['id']}): Raw '[' or ']' outside LaTeX $...$ in text string ('{no_tags.strip()[:45]}'). "
                "Wrap interval brackets in $...$ (e.g. $[2 ; 4]$ or $]2 ; 4]$) or draw brackets geometrically with `draw path` so BBCode rendering never drops them!"
            )
    return errs


def deep_audit_hc(
    script: str,
    expected_audio_duration: float,
    lock_starts_path: Path,
    unlock_starts: bool,
) -> Tuple[List[str], List[str], Dict[str, Any]]:
    errors: List[str] = []
    warnings: List[str] = []

    header, statements, tok_errors = tokenize_hc_statements(script)
    errors.extend(tok_errors)
    if errors:
        return errors, warnings, {}

    idgap = int(header["idgap"])
    header_duration = float(header["duration"])
    if header["audio"] != "narration.wav":
        errors.append(f'Course header audio must be "narration.wav" (found "{header["audio"]}").')

    if expected_audio_duration > 0 and abs(header_duration - expected_audio_duration) > 3.0:
        warnings.append(
            f"Course header duration ({header_duration}s) differs from narration.wav ({expected_audio_duration}s)."
        )

    # Check opaque white fills
    if re.search(r"fillcolor\s*\(\s*2[45]\d\s*,\s*2[45]\d\s*,\s*2[45]\d\s*,\s*0\.[789]", script):
        errors.append("Opaque white fillcolor detected on green chalkboard. Use translucent chalk fills (alpha 0.12 - 0.25) or none.")

    seen_ids: Dict[int, int] = {}
    current_starts: Dict[str, float] = {}
    erase_times: List[float] = []
    draw_or_mouse_count = 0

    for st in statements:
        cmd = st["cmd"]
        eid = st["id"]
        line = st["line"]
        s_time = st["start"]

        if cmd in ("speech", "plot"):
            errors.append(f"Line {line}: Forbidden legacy command '{cmd}'. Use only text, draw, mouse, erase.")
            continue
        if cmd not in ("text", "draw", "mouse", "erase"):
            errors.append(f"Line {line}: Unknown command '{cmd}'.")
            continue

        if eid is None:
            errors.append(f"Line {line}: Command '{cmd}' is missing 'id <N>'.")
            continue
        if s_time is None:
            errors.append(f"Line {line} (id {eid}): Command '{cmd}' is missing 'start <T>s'.")
            continue

        # 1. Global ID uniqueness check
        if eid in seen_ids:
            errors.append(
                f"Line {line}: DUPLICATE ID {eid} (already used on line {seen_ids[eid]})! "
                "Dart's HypercourseParser overwrites duplicate IDs across the whole course. Every element must have a unique ID!"
            )
        else:
            seen_ids[eid] = line

        # 2. idgap namespace bucket check
        idgap_hint = f" (increase `idgap` in course header, e.g. `idgap 500` or `idgap 1000`, if your course has >{idgap} elements)"
        if cmd == "text" and not (1 <= eid <= idgap):
            errors.append(f"Line {line}: `text id {eid}` out of range [1, {idgap}] for idgap={idgap}{idgap_hint}.")
        elif cmd == "draw" and not (idgap + 1 <= eid <= 2 * idgap):
            errors.append(f"Line {line}: `draw id {eid}` out of range [{idgap + 1}, {2 * idgap}] for idgap={idgap}{idgap_hint}.")
        elif cmd == "mouse" and not (3 * idgap + 1 <= eid <= 4 * idgap):
            errors.append(f"Line {line}: `mouse id {eid}` out of range [{3 * idgap + 1}, {4 * idgap}] for idgap={idgap}{idgap_hint}.")
        elif cmd == "erase" and not (4 * idgap + 1 <= eid <= 5 * idgap):
            errors.append(f"Line {line}: `erase id {eid}` out of range [{4 * idgap + 1}, {5 * idgap}] for idgap={idgap}{idgap_hint}.")

        if cmd in ("draw", "mouse"):
            draw_or_mouse_count += 1
            if cmd == "mouse" and st["duration"] <= 0:
                errors.append(f"Line {line} (mouse id {eid}): `mouse move` requires an explicit `for <DURATION>s` > 0.")

        if cmd == "text":
            errors.extend(check_text_bbcode_and_colors(st))

        if cmd == "erase":
            erase_times.append(s_time)
        else:
            current_starts[str(eid)] = round(s_time, 3)

    if draw_or_mouse_count < 3:
        errors.append(
            f"Only {draw_or_mouse_count} `draw`/`mouse` commands found in course.hc. "
            "A genuine ILLIMMI course must visually draw axes, curves, vectors, figures, or diagrams alongside text!"
        )

    erase_times_sorted = sorted(set(erase_times))
    if expected_audio_duration > 60.0 and len(erase_times_sorted) < 2:
        errors.append(
            f"Course duration is {expected_audio_duration:.1f}s but only {len(erase_times_sorted)} `erase` transition(s) found (minimum 2 `erase` -> at least 3 scenes)."
        )

    # 3. Pre-erase capture window check
    scene_bounds: List[float] = [0.0] + erase_times_sorted + [max(expected_audio_duration, header_duration) + 5.0]
    for st in statements:
        if st["cmd"] == "erase" or st["start"] is None:
            continue
        s_t = float(st["start"])
        e_t = s_t + float(st["duration"])
        # Find which scene [b_start, b_end) this element belongs to
        for b_i in range(len(scene_bounds) - 1):
            b_start, b_end = scene_bounds[b_i], scene_bounds[b_i + 1]
            if b_start <= s_t < b_end:
                if b_i < len(scene_bounds) - 2 and e_t >= b_end - 0.04:
                    errors.append(
                        f"Line {st['line']} (id {st['id']}): start({s_t}s) + for({st['duration']}s) = {e_t:.2f}s "
                        f"reaches/exceeds next erase at {b_end}s! Keep `for` animation short (e.g. 0.4s-1.5s, or omit `for` on `text`) "
                        f"so pre-erase scene capture happens strictly before {b_end}s."
                    )
                break

    # 4. Immutable start timestamp check on visual-fix iterations
    if not unlock_starts and lock_starts_path.exists():
        try:
            locked = json.loads(lock_starts_path.read_text(encoding="utf-8"))
            for eid_str, old_start in locked.items():
                if eid_str in current_starts and abs(current_starts[eid_str] - old_start) > 0.015:
                    errors.append(
                        f"TIMING LOCK VIOLATION on element id {eid_str}: `start` changed from {old_start}s to {current_starts[eid_str]}s! "
                        "Per layer3_visual_verifier_system.md Rule 17, NEVER alter `start` timestamps during visual layout correction."
                    )
        except Exception:
            pass

    meta_info = {
        "idgap": idgap,
        "statement_count": len(statements),
        "draw_or_mouse_count": draw_or_mouse_count,
        "erase_count": len(erase_times_sorted),
        "erase_times": erase_times_sorted,
        "current_starts": current_starts,
    }
    return errors, warnings, meta_info


def main():
    parser = argparse.ArgumentParser(description="Step 3: Audit .hc, run WorldModelVerifier, and render PNG scenes.")
    parser.add_argument("--course-id", required=True, help="Target course ID (e.g. MATH_003)")
    parser.add_argument("--audit-only", action="store_true", help="Run static + WorldModel audits without headless Flutter PNG rendering")
    parser.add_argument("--unlock-starts", action="store_true", help="Reset locked `start` timestamps (only when rewriting Layer 3 from scratch)")
    args = parser.parse_args()

    course_id = args.course_id.strip()
    course_dir = COURSES_DIR / course_id
    hc_path = course_dir / "course.hc"
    meta_path = course_dir / "metadata.json"
    renders_dir = course_dir / "renders"
    lock_starts_path = renders_dir / "initial_starts.json"

    if not hc_path.exists():
        print(json.dumps({"ok": False, "error": f"Missing Hypercourse file: {hc_path}"}))
        sys.exit(1)

    expected_dur = 120.0
    if meta_path.exists():
        try:
            expected_dur = float(json.loads(meta_path.read_text(encoding="utf-8")).get("duration_seconds", 120.0))
        except Exception:
            pass

    hc_text = hc_path.read_text(encoding="utf-8")

    audit_errors, audit_warnings, hc_info = deep_audit_hc(
        hc_text,
        expected_audio_duration=expected_dur,
        lock_starts_path=lock_starts_path,
        unlock_starts=args.unlock_starts,
    )

    wm_res = WorldModelVerifier.verify_script(hc_text, expected_dur)
    if audit_errors:
        print(json.dumps({
            "ok": False,
            "course_id": course_id,
            "stage": "hc_deep_audit",
            "audit_errors": audit_errors,
            "audit_warnings": audit_warnings,
            "world_model": wm_res,
        }, indent=2, ensure_ascii=False))
        sys.exit(2)

    if args.audit_only:
        print(json.dumps({
            "ok": wm_res["score"] >= 8.0 and not audit_errors,
            "course_id": course_id,
            "mode": "audit_only",
            "hc_info": hc_info,
            "audit_warnings": audit_warnings,
            "world_model": wm_res,
        }, indent=2, ensure_ascii=False))
        sys.exit(0 if wm_res["score"] >= 8.0 else 3)

    renders_dir.mkdir(parents=True, exist_ok=True)
    # Sync alias <ID>.hc
    shutil.copyfile(hc_path, course_dir / f"{course_id}.hc")

    # Save initial_starts.json lock on first clean structural pass (or when unlocked)
    if args.unlock_starts or not lock_starts_path.exists():
        with open(lock_starts_path, "w", encoding="utf-8") as f:
            json.dump(hc_info["current_starts"], f, indent=2)

    # Clean stale PNGs before rendering fresh captures
    for old_png in renders_dir.glob("scene_*.png"):
        old_png.unlink()
    manifest_path = renders_dir / "render_manifest.json"
    if manifest_path.exists():
        manifest_path.unlink()

    render_cmd = [
        "dart", "run", "bin/render_course_to_images.dart",
        str(hc_path.resolve()),
        str(renders_dir.resolve()),
    ]
    proc = subprocess.run(
        render_cmd,
        cwd=ORCH_DIR,
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
        timeout=None,
        shell=(sys.platform == "win32"),
    )

    if proc.returncode != 0 or not manifest_path.exists():
        print(json.dumps({
            "ok": False,
            "course_id": course_id,
            "stage": "board_render",
            "return_code": proc.returncode,
            "stdout_tail": proc.stdout[-1200:] if proc.stdout else "",
            "stderr_tail": proc.stderr[-1200:] if proc.stderr else "",
        }, indent=2, ensure_ascii=False))
        sys.exit(4)

    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    png_paths = [str((renders_dir / s["file"]).resolve()) for s in manifest.get("scenes", [])]

    print(json.dumps({
        "ok": True,
        "course_id": course_id,
        "world_model_score": wm_res["score"],
        "world_model_issues": wm_res["issues"],
        "audit_warnings": audit_warnings,
        "total_scenes_rendered": manifest.get("totalScenes", len(png_paths)),
        "scene_png_paths": png_paths,
        "mandatory_next_step": (
            "CALL `read_file` ON EVERY PNG IN `scene_png_paths` NOW! Visually inspect chalk readability, "
            "KaTeX formulas, zero text/diagram overlap, accurate arrows/axes, and 16:9 framing. "
            "If ANY visual defect exists, edit `course.hc` (WITHOUT changing `start` timestamps!) and re-run `step3_render_and_verify.py`."
        ),
    }, indent=2, ensure_ascii=False))


if __name__ == "__main__":
    main()
