---
name: corpus-illimmi
description: Generate and visually certify ILLIMMI's 1,000-course Lycée corpus using the active Antigravity model (Argon), Piper+Whisper word alignment, and PNG World Model inspection. Ideal with /goal.
---

# ILLIMMI Cognitive Corpus Generator (`corpus-illimmi`)

Use this skill whenever the user invokes `/corpus-illimmi`, mentions `corpus-illimmi`, or asks to continue generating courses for the **ILLIMMI 1,000-course Lycée dataset** (especially in combination with `/goal`).

---

## Hard Architectural Guardrails (NON-NEGOTIABLE)

1. **FORBIDDEN Legacy Scripts**:
   - **NEVER** run `corpus_illimmi_1000/tools/generate_corpus.py` (it wipes discovered YouTube IDs in `corpus_1000_full.json`).
   - **NEVER** run `build_daily_batch.bat`, `agentic_corpus_runner.py`, `daily_corpus_builder.py`, or `PedagogicalVisualsEngine` to generate courses (they use hardcoded regex/templates instead of Argon).
2. **100% Active Model Inheritance (Argon Guarantee)**:
   - Every subagent invoked via `invoke_subagent` **MUST** set `Model="inherit"` (never `"flash"` or `"flash_lite"`), guaranteeing every single course is planned, written, coded in `.hc`, and visually inspected by the user's active model (**Argon**).
3. **Subagent-Per-Course Context Isolation (for `/goal` Scalability)**:
   - When generating **2 or more courses** (e.g. a batch of 5, 10, or 25 under `/goal`), the main agent acts as a **lightweight Batch Orchestrator** and delegates **one course at a time** (or at most 2 sequentially respecting YouTube rate limits) to a fresh subagent (`TypeName="self"`, `Model="inherit"`) so the main conversation context never bloats!
   - When generating **1 single course**, you may either execute the 5-step pipeline directly or via a subagent with `Model="inherit"`.
4. **ZERO Limit on Words, Audio Duration, Sections, or Scenes (100% Transcript-Driven)**:
   - **NEVER impose any cap on word count, audio length, section count, or scene count!**
   - The ONLY upstream duration rule is at **Step 1 (YouTube selection)**: the source YouTube video must be **`<= 1 hour` (`<= 3600s`)** (enforced automatically by `step1_ingest_youtube.py`).
   - Once `raw_transcript.txt` is ingested, **NEVER summarize, condense, or truncate the course**: if cleaning `raw_transcript.txt` yields `500` words, `3,000` words, or `10,000` words, write the **entire** `500`, `3,000`, or `10,000` words in `narration.txt`, synthesize the full `narration.wav` audio without limit, and create as many board scenes (`erase` transitions: `5`, `15`, `40+` scenes, scaling `idgap` to `200`, `500`, `1000+` as needed) as required to illustrate every step cleanly!

---

## Batch Orchestrator Workflow (Main Agent)

### 1. Select the Pending Batch
Determine requested batch size from the user's prompt (default: `10` if unspecified; max `25` per daily YouTube-safe batch unless requested otherwise) or specific `--course-id`, then run:

```powershell
python ".agents/skills/corpus-illimmi/scripts/select_batch.py" --batch-size 10
```
*(Optional flags: `--course-id MATH_003`, `--subject "Mathématiques"`, `--start-index 3`.)*

### 2. Loop Over Selected Courses
For each course `<COURSE_ID>` in `courses`:
- Launch a dedicated fresh-context subagent with **exact model inheritance**:
  - `TypeName`: `"self"` (or `"illimmi-course-agent"`)
  - `Model`: `"inherit"` *(MANDATORY — guarantees Argon)*
  - `Role`: `"ILLIMMI Course Author (<COURSE_ID>)"`
  - `Prompt`: Tell the subagent to read `.agents/skills/corpus-illimmi/SKILL.md` (Section *"Single-Course 5-Step Execution Protocol"*) and `.agents/skills/corpus-illimmi/references/course_authoring_rules.md`, then execute Steps 1 -> 5 end-to-end for `<COURSE_ID>` and return the JSON certification output from `step4_certify_course.py`.
- Wait for the subagent to complete (do not poll; reactive wakeup notifies you automatically).
- Verify in the subagent's report (or `catalog/progress.json`) that `<COURSE_ID>` has `"status": "COMPLETED"`. If a course fails due to transient YouTube caption unavailability after retries, log it clearly and proceed to the next course until the target count of certified courses is met.

### 3. Optional Training JSONL Refresh & Final Summary
At the end of the batch, refresh the real Gemma SFT JSONL exports from all certified courses:

```powershell
python ".agents/skills/corpus-illimmi/scripts/export_certified_jsonl.py"
```

Report the batch table (`Course ID`, `Title`, `Duration`, `Words`, `Scenes`, `World Model Score`), updated total (`X / 1000`), and next pending course ID. (If `/goal` is active, include `<!-- GOAL_COMPLETE -->` only once the entire requested batch is certified!)

---

## Single-Course 5-Step Execution Protocol (Course Author Agent)

First read [references/course_authoring_rules.md](references/course_authoring_rules.md) in full. Then execute these 5 steps in strict order for `<COURSE_ID>`:

### Step 1 — Quota-Safe YouTube Transcript Ingestion
```powershell
python ".agents/skills/corpus-illimmi/scripts/step1_ingest_youtube.py" --course-id <COURSE_ID>
```
Then read `corpus_illimmi_1000/courses/<COURSE_ID>/raw_transcript.txt` using `read_file`.

### Step 2 — Cognitive Authoring of Layer 1 (`metadata.json`) & Layer 2 (`narration.txt`)
Using your own pedagogical reasoning (never regex scripts!):
1. Write `corpus_illimmi_1000/courses/<COURSE_ID>/metadata.json` with as many structured pedagogical sections as the cleaned transcript requires (no upper limit: `accroche`, `prerequis`, `exemple_concret`, `definition_formelle`, repeatable `decomposition`, `erreur_frequente`, `synthese`) and rich visual tools (`draw 2drep`, `draw arrow`, `draw line`, `draw path`, `draw circle`, `draw polygone`, etc.).
2. Write `corpus_illimmi_1000/courses/<COURSE_ID>/narration.txt` **faithfully preserving 100% of the pedagogical content of `raw_transcript.txt` (ZERO word limit — never summarize or condense!)**:
   - Clean oral hesitations, creator names, and YouTube noise (*« dans ce cours »*, never *« dans cette vidéo »*), and rewrite into fluid, warm spoken French (tutoiement bienveillant) keeping **every** explanation, proof, example, and step-by-step calculation from the source transcript — if the cleaned transcript is `10,000` words, `narration.txt` is `10,000` words!
   - **Zero** raw LaTeX/Markdown (`$` or `^2` forbidden — write spoken phonetics like *« x au carré »*, *« l'intervalle fermé 2 point-virgule 4 »*).
   - Include **explicit spoken visual anchors throughout every section** (*« Traçons à droite un axe gradué... »*, *« Plaçons les bornes... »*, *« Regarde sur le repère... »*).

### Step 3 — Local Piper TTS Synthesis & Whisper.cpp Word Alignment
```powershell
python ".agents/skills/corpus-illimmi/scripts/step2_align_audio.py" --course-id <COURSE_ID>
```
- Synthesizes full-length `narration.wav` and aligns every word in `words.txt` with **zero audio duration limit**.
- If validation errors are reported on `metadata.json` or `narration.txt`, fix them and re-run `step2_align_audio.py`.
- Once it succeeds, read `corpus_illimmi_1000/courses/<COURSE_ID>/words.txt` (`<start>word<end>`) in full using `read_file` (use `StartLine`/`EndLine` chunks if >800 lines).

### Step 4 — Bespoke Layer 3 Hypercourse Authoring (`course.hc`) + Render & Multimodal Audit
1. Write `corpus_illimmi_1000/courses/<COURSE_ID>/course.hc` **tailor-made** for this exact lesson and synchronized to the exact `<start>` word timestamps in `words.txt`:
   - **Unlimited scene count (`erase`)**: Never cap scene count! Insert as many `erase` transitions as needed across the entire timeline so no single chalkboard ever gets crowded (`5`, `15`, `40+` scenes — whatever the transcript length requires).
   - Every `id` strictly unique across the entire `.hc` file!
   - Scale `idgap` freely in the header (`idgap 100`, `idgap 500`, `idgap 1000`, etc.) so all elements fit cleanly in their namespace buckets (`text`: `1..G`, `draw`: `G+1..2G`, `mouse`: `3G+1..4G`, `erase`: `4G+1..5G`).
   - Left column (`x` in `[3, 6]`) for concise explanations & KaTeX formulas; right column (`x` in `[92, 173]`) for rich geometric drawings, axes, plots, and diagrams.
   - **Single Action at a Time & Progressive Chalk Handwriting**:
     - **One Action Rule**: A teacher has only one hand. Two visual elements must NEVER animate simultaneously ($T_i + D_i \le T_{i+1} - 0.2s$).
     - **Instant reveal when time is short**: If $\Delta T = T_{i+1} - T_i < 1.2s$ (or for rapid series of items), OMIT `for` (instant display).
     - **Progressive writing when time allows**: If $\Delta T \ge 1.5s$, assign `for <D>s` ($2.0s$ to $4.5s$, capped by $\Delta T - 0.2s$) on sentences, definitions, and formulas so `LatexWidget` and `SmartMathClipper` animate chalk handwriting character-by-character with a blinking cursor!
   - Wrap all math brackets `[a ; b]` or `]2 ; 4]` inside `$...$` and draw axis brackets geometrically with `draw path`. Never write `f''(x)` inside `''...''` (use `f^{\prime\prime}(x)`).
2. Run the structural audit, `WorldModelVerifier`, and headless Flutter board renderer:
   ```powershell
   python ".agents/skills/corpus-illimmi/scripts/step3_render_and_verify.py" --course-id <COURSE_ID>
   ```
3. **MANDATORY MULTIMODAL VISUAL CHECK**:
   - Call `read_file` on **every single `scene_*.png` path** returned in `scene_png_paths`!
   - Inspect every chalkboard screenshot visually for collisions, clipped text/formulas, missing symbols, arrow precision, and contrast.
   - If **any** visual defect appears in any `scene_*.png`: edit `course.hc` (**WITHOUT modifying any existing `start` timestamp!** Only adjust positions, widths, scales, colors, or wording), re-run `step3_render_and_verify.py`, and re-inspect the updated `scene_*.png` files with `read_file` until every scene is visually crisp and collision-free.

### Step 5 — Final Certification & Atomic Progress Sync
```powershell
python ".agents/skills/corpus-illimmi/scripts/step4_certify_course.py" --course-id <COURSE_ID> --visual-audit-notes "<concise summary of what you verified visually across scene_0..scene_N.png>"
```
Confirm `"certified": true` before finishing the course!

