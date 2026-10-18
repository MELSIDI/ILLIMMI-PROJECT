---
description: Build the 1,000-course Lycée corpus for ILLIMMI iteratively across daily quota-aware batches with Piper+Whisper alignment and World Model verified visuals.
---

Parse the following from $ARGUMENTS:
1. `--batch-size N` — (optional, default 25) Number of courses to compile in this daily run (within YouTube quotas).
2. `--start-index N` — (optional) Resume from specific course numeric index.
3. `--verify-only` — (optional) Run World Model visual audit on already compiled courses without downloading new ones.

# ILLIMMI Daily Agentic Corpus Workflow

This workflow executes the autonomous pedagogical pipeline to build the **1,000 Lycée courses** for ILLIMMI (500 Math, 300 Physics, 200 Languages).
It uses Antigravity as the internal cognitive engine (replacing external APIs) and runs locally with Piper TTS and Whisper.cpp.

## Execution Steps

### 1. Pre-flight & Progress Check
Run the Python orchestrator to check current progress and select the daily quota-safe batch:
```bash
python corpus_illimmi_1000/tools/agentic_corpus_runner.py --batch-size 25
```

### 2. Five-Phase Pipeline Per Course
For each course in the batch, the agent executes:
1. **YouTube Ingestion & Quota Safety**:
   - Queries YouTube with rate-limiting pauses (2.5s–4.0s jitter) to protect the user's IP.
   - Checks local cache in `transcripts/raw/` first.
2. **Transcript Purification & Math Phonetics**:
   - Strips all YouTuber identities (*Yvan Monka, Florence Raffin, Romain Bourdel, Paul Olivier, Amélie Vioux*, etc.).
   - Purges channel noise (*« abonne-toi », « active la cloche », « lien en description »*, sponsors).
   - Converts mathematical formulas to oral spoken phonetics (Rule 7 & 8 of `layer2_audio_system.md`).
3. **Layer 1 Pedagogical Structuration**:
   - Generates 4 to 7 canonical progression sections with exact visual tool assignments.
4. **Layer 2 Audio & Acoustic Ground Truth Alignment**:
   - Runs local **Piper TTS** (`fr_FR-siwis-medium.onnx`) and **Whisper.cpp** (`whisper-cli.exe -ml 1`).
   - Uses Banded Global Dynamic Programming sequence alignment to produce certified monotonic `<start>word<end>` timestamps.
5. **Layer 3 Cognitive Visuals & World Model Verification**:
   - Generates Hypercourse DSL (`.hc`) with left-aligned text ($x \in [2, 6]$), visual action anchors, and 16:9 vector boards.
   - Runs `WorldModelVerifier` to detect bounding overflows and text-on-figure collisions.
   - Applies `WorldModelAutoCorrector` coordinate refactoring until score is $\ge 8.0/10$.

### 3. Artifact Archival & Progress Sync
Each completed course is archived with all 5 core artifacts:
- `courses/{id}/raw_transcript.txt`
- `courses/{id}/metadata_layer1.json`
- `courses/{id}/narration_layer2.txt`
- `courses/{id}/timeline_words_layer2.txt`
- `courses/{id}/course_layer3.hc`
And synchronizes `corpus_1000_manifest.csv` and `catalog/progress.json`.

### 4. Daily Report
Outputs the completed courses count, words aligned, audio duration, and the next course ID to resume tomorrow.
