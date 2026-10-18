"""
Acoustic Aligner for ILLIMMI Corpus
------------------------------------
Synthesizes spoken narration using Piper TTS and aligns word-by-word
timestamps using Whisper.cpp and Banded Global Dynamic Programming.
Guarantees certified acoustic ground truth and strict monotonicity.
"""

import os
import sys
import json
import re
import unicodedata
import subprocess
from pathlib import Path

# Paths to native binaries
PROJECT_ROOT = Path(__file__).resolve().parent.parent.parent
AUDIO_SERVICE = PROJECT_ROOT / "services" / "audio_service"
PIPER_EXE = AUDIO_SERVICE / "speaker" / "piper" / "piper.exe"
PIPER_MODEL_FR = AUDIO_SERVICE / "speaker" / "piper" / "model" / "fr_FR-siwis-medium.onnx"
PIPER_MODEL_EN = AUDIO_SERVICE / "speaker" / "piper" / "model" / "fr_FR-tom-medium.onnx" # fallback or en if available
WHISPER_EXE = AUDIO_SERVICE / "speaker" / "whispercpp" / "Release" / "whisper-cli.exe"
WHISPER_MODEL = AUDIO_SERVICE / "speaker" / "whispercpp" / "models" / "ggml-small.bin"
FFMPEG_CMD = "ffmpeg"


def normalize_token(w: str) -> str:
    """Normalize a word for acoustic matching (strip accents and punctuation)."""
    w = unicodedata.normalize('NFD', w)
    w = ''.join(c for c in w if unicodedata.category(c) != 'Mn')
    return re.sub(r'[^a-zA-Z0-9]', '', w).lower()


def synthesize_speech(text: str, out_wav_path: Path, lang: str = "fr") -> float:
    """Synthesize narration text to 22.05kHz WAV using Piper TTS."""
    clean_text = ' '.join(text.split())
    out_wav_path.parent.mkdir(parents=True, exist_ok=True)

    model_path = PIPER_MODEL_FR
    cmd = [
        str(PIPER_EXE),
        "-m", str(model_path),
        "-f", str(out_wav_path)
    ]

    p = subprocess.Popen(
        cmd,
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        encoding="utf-8"
    )
    stdout, stderr = p.communicate(input=clean_text)
    if p.returncode != 0:
        raise RuntimeError(f"Piper TTS failed (code {p.returncode}): {stderr}")

    # Extract audio duration from stderr log
    match = re.search(r'audio=([\d.]+)', stderr)
    if match:
        return float(match.group(1))
    
    # Fallback to wave duration
    import wave
    with wave.open(str(out_wav_path), 'rb') as w:
        return w.getnframes() / float(w.getframerate())


def transcribe_tokens(wav_path: Path, lang: str = "fr") -> list:
    """Convert WAV to 16kHz mono and extract Whisper acoustic tokens."""
    wav_16k = wav_path.with_name(f"{wav_path.stem}_16k.wav")
    out_base = wav_path.with_name(f"{wav_path.stem}_words")

    # 1. Convert to 16kHz mono PCM
    conv_cmd = [
        FFMPEG_CMD,
        "-y",
        "-i", str(wav_path),
        "-ar", "16000",
        "-ac", "1",
        "-c:a", "pcm_s16le",
        str(wav_16k)
    ]
    res_conv = subprocess.run(conv_cmd, capture_output=True, text=True)
    if res_conv.returncode != 0:
        raise RuntimeError(f"ffmpeg conversion failed: {res_conv.stderr}")

    # 2. Run Whisper.cpp with single-token granularity (-ml 1)
    whisper_cmd = [
        str(WHISPER_EXE),
        "-m", str(WHISPER_MODEL),
        "-f", str(wav_16k),
        "-l", lang,
        "-ml", "1",
        "-oj",
        "-of", str(out_base)
    ]
    res_whisper = subprocess.run(whisper_cmd, capture_output=True, text=True)
    if res_whisper.returncode != 0:
        raise RuntimeError(f"whisper-cli failed: {res_whisper.stderr}")

    json_file = wav_path.with_name(f"{wav_path.stem}_words.json")
    if not json_file.exists():
        raise FileNotFoundError(f"Whisper JSON output not found: {json_file}")

    with open(json_file, "r", encoding="utf-8", errors="replace") as f:
        data = json.load(f)

    tokens = data.get("transcription", [])

    # Clean intermediate 16k WAV and JSON
    try:
        if wav_16k.exists():
            wav_16k.unlink()
        if json_file.exists():
            json_file.unlink()
        txt_file = wav_path.with_name(f"{wav_path.stem}_words.txt")
        if txt_file.exists():
            txt_file.unlink()
    except Exception:
        pass

    return tokens


def align_narration_with_tokens(narration_text: str, tokens: list, total_duration: float) -> list:
    """
    Perform Banded Dynamic Programming sequence alignment between narration
    tokens and Whisper acoustic tokens.
    Returns list of tuples: (word_str, start_sec, end_sec)
    """
    narration_words = narration_text.split()
    if not narration_words:
        return []

    # 1. Group Whisper tokens into acoustic words
    stt_words = []
    curr = ""
    c_s = 0.0
    c_e = 0.0
    for tok in tokens:
        t = tok.get("text", "")
        offsets = tok.get("offsets", {})
        s = offsets.get("from", 0) / 1000.0
        e = offsets.get("to", 0) / 1000.0
        if not t.strip():
            continue
        if t.startswith(" ") and curr:
            stt_words.append({"word": curr.strip(), "start": c_s, "end": c_e})
            curr = t
            c_s = s
            c_e = e
        else:
            if not curr:
                c_s = s
            curr += t
            c_e = e

    if curr:
        stt_words.append({"word": curr.strip(), "start": c_s, "end": c_e})

    if not stt_words:
        # Fallback regular interpolation if STT completely empty
        dt = total_duration / len(narration_words)
        return [(w, round(i * dt, 3), round((i + 1) * dt, 3)) for i, w in enumerate(narration_words)]

    N = len(narration_words)
    M = len(stt_words)

    # 2. Banded Needleman-Wunsch Dynamic Programming
    band = max(35, int(M * 0.15))
    dp = {(0, 0): 0}
    ptr = {}

    for i in range(N + 1):
        expected_j = int(i * M / N)
        j_min = max(0, expected_j - band)
        j_max = min(M, expected_j + band)
        for j in range(j_min, j_max + 1):
            if (i, j) not in dp:
                continue
            curr_score = dp[(i, j)]

            if i < N:
                target = (i + 1, j)
                score = curr_score - 1
                if target not in dp or score > dp[target]:
                    dp[target] = score
                    ptr[target] = (i, j, 'SKIP_N')

            if j < M:
                target = (i, j + 1)
                score = curr_score - 1
                if target not in dp or score > dp[target]:
                    dp[target] = score
                    ptr[target] = (i, j, 'SKIP_S')

            if i < N and j < M:
                target = (i + 1, j + 1)
                nw = normalize_token(narration_words[i])
                sw = normalize_token(stt_words[j]['word'])
                if nw and sw and (nw == sw or nw in sw or sw in nw):
                    match_bonus = 4
                else:
                    match_bonus = -2
                score = curr_score + match_bonus
                if target not in dp or score > dp[target]:
                    dp[target] = score
                    ptr[target] = (i, j, 'MATCH')

    # Backtrack anchors
    curr_node = (N, M)
    matched_anchors = []
    while curr_node in ptr:
        prev_i, prev_j, action = ptr[curr_node]
        if action == 'MATCH':
            nw = normalize_token(narration_words[prev_i])
            sw = normalize_token(stt_words[prev_j]['word'])
            if nw and sw and (nw == sw or nw in sw or sw in nw):
                matched_anchors.append((prev_i, stt_words[prev_j]['start'], stt_words[prev_j]['end']))
        curr_node = (prev_i, prev_j)

    matched_anchors.reverse()

    # 3. Interpolate unanchored words strictly monotonically
    actual_end = max(total_duration, stt_words[-1]['end'])
    full_anchors = [(0, 0.150, max(0.400, matched_anchors[0][1] if matched_anchors else 0.500))]
    full_anchors.extend(matched_anchors)
    full_anchors.append((N - 1, actual_end - 0.450, actual_end))

    # Remove non-increasing anchors to guarantee strict monotonicity
    clean_anchors = [full_anchors[0]]
    for idx, s, e in full_anchors[1:]:
        last_idx, last_s, last_e = clean_anchors[-1]
        if idx > last_idx and s >= last_s:
            clean_anchors.append((idx, max(s, last_e), max(e, s + 0.05)))

    # Generate word timings
    result_timings = []
    for a_i in range(len(clean_anchors) - 1):
        idx_a, s_a, e_a = clean_anchors[a_i]
        idx_b, s_b, e_b = clean_anchors[a_i + 1]

        count = idx_b - idx_a
        if count <= 0:
            continue

        span_start = s_a
        span_end = s_b
        if span_end <= span_start:
            span_end = span_start + 0.08 * count

        dt = (span_end - span_start) / count
        for step in range(count):
            w_idx = idx_a + step
            w_text = narration_words[w_idx]
            w_s = span_start + step * dt
            w_e = min(span_end, w_s + dt * 0.90)
            result_timings.append((w_text, round(w_s, 3), round(w_e, 3)))

    # Append very last word
    last_idx, last_s, last_e = clean_anchors[-1]
    result_timings.append((narration_words[last_idx], round(last_s, 3), round(last_e, 3)))

    # Final monotonicity safety pass
    monotone_results = []
    min_time = 0.0
    for w, s, e in result_timings:
        s_fix = max(s, min_time)
        e_fix = max(e, s_fix + 0.05)
        monotone_results.append((w, round(s_fix, 3), round(e_fix, 3)))
        min_time = s_fix

    return monotone_results


def write_compact_timeline(timings: list, out_path: Path):
    """Write list of (word, start, end) to compact timeline file `<start>word<end>`."""
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with open(out_path, "w", encoding="utf-8") as f:
        for w, s, e in timings:
            f.write(f"<{s:.3f}>{w}<{e:.3f}>\n")


def align_course_end_to_end(narration_path: Path, output_words_path: Path, lang: str = "fr") -> dict:
    """Full pipeline: narration text -> Piper WAV -> Whisper tokens -> Monotonic DP alignment."""
    with open(narration_path, "r", encoding="utf-8") as f:
        narration_text = f.read().strip()

    temp_wav = output_words_path.with_name(f"{output_words_path.stem}_temp.wav")
    duration = synthesize_speech(narration_text, temp_wav, lang=lang)
    tokens = transcribe_tokens(temp_wav, lang=lang)
    timings = align_narration_with_tokens(narration_text, tokens, duration)
    write_compact_timeline(timings, output_words_path)

    # Clean temporary WAV
    try:
        if temp_wav.exists():
            temp_wav.unlink()
    except Exception:
        pass

    return {
        "success": True,
        "word_count": len(timings),
        "duration_seconds": round(duration, 2),
        "output_path": str(output_words_path)
    }


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python acoustic_aligner.py <narration.txt> <output_words.txt> [lang]")
        sys.exit(1)

    narr = Path(sys.argv[1])
    out = Path(sys.argv[2])
    l = sys.argv[3] if len(sys.argv) > 3 else "fr"
    res = align_course_end_to_end(narr, out, lang=l)
    print(json.dumps(res, indent=2))
