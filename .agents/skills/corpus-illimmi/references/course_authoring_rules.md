# ILLIMMI Course Authoring & Hypercourse DSL Rules (Argon Reference)

Read this reference before authoring `metadata.json` (Layer 1), `narration.txt` (Layer 2), and `course.hc` (Layer 3).

---

## 1. Layer 1 — Pedagogical Plan (`courses/<ID>/metadata.json`)

Follow `services/generation_orchestrator/prompts/layer1_planner_system.md`:
- Structure the lesson into **as many pedagogical sections as the cleaned transcript requires** (minimum 3, **ZERO upper limit**):
  1. `accroche` — concrete motivation / real problem to solve
  2. `prerequis` *(optional)* — brief recall of needed foundations
  3. `exemple_concret` — concrete simple case **before** formal generalization (repeatable)
  4. `definition_formelle` — rigorous statement grounded in the example (repeatable)
  5. `decomposition` — step-by-step calculation, proof, or method (repeatable across as many sub-parts/questions as present in the transcript)
  6. `erreur_frequente` — classic exam trap explicitly named and debunked
  7. `synthese` — exam reflex & takeaway
- Every section **must** specify:
  - `section_id`: `"sec_1"`, `"sec_2"`, ...
  - `title`: numbered pedagogical title (e.g. `"1. Accroche & Cas Concret"`)
  - `summary`: 1–2 sentences summarizing what is taught and drawn
  - `support_visuel_suggere`: concrete visual primitive (`"draw 2drep + draw 2dfunc"`, `"draw arrow + axis"`, `"draw polygone + draw arrow"`, `"draw circle"`, `"step_solution + draw line"`, etc.) — **never** >50% `"text"`!
  - `concepts_cles`: list of short concept names (not full sentences).

---

## 2. Layer 2 — Oral Pedagogical Narration (`courses/<ID>/narration.txt`)

Follow `services/generation_orchestrator/prompts/layer2_audio_system.md`:
- **Source of inspiration, never raw copy-paste**: Use `raw_transcript.txt` for genuine teacher pedagogy, examples, and rigor, **rewritten** into clean, grammatical, natural spoken French (or French-guided English for `LANG_EN_*` if only French Piper voices are installed).
- **ZERO Limit on Word Count, Audio Duration, or Scene Count (100% Driven by Cleaned Transcript)**:
  - **NEVER summarize, condense, or cap `narration.txt`!**
  - The word count comes strictly from cleaning `raw_transcript.txt` (sourced from a YouTube video `<= 1 hour`): strip only YouTube noise, creator names, and oral stumbles while preserving **100% of the teacher's explanations, examples, derivations, and remarks**.
  - If the cleaned transcript yields `500` words, `3,000` words, or `10,000` words, write all `500`, `3,000`, or `10,000` words in `narration.txt`, generate the full-length audio, and create **as many board scenes (`erase` transitions) as needed** (`5`, `15`, `40+` scenes) so every single board state remains clean and readable! Scale `idgap` (`100`, `500`, `1000`, `2000`) accordingly whenever total elements exceed `100`.
- **Strict Anonymization & Zero Platform Noise**:
  - Purge ALL creator names (*Yvan Monka, M@ths et Tiques, Florence Raffin, Romain Bourdel, Paul Olivier, Amélie Vioux, jaicompris, Exo7, BBC, mmmEnglish...*).
  - Purge ALL YouTube noise (*« dans cette vidéo »* -> *« dans ce cours »*, *« abonne-toi »*, *« pouce bleu »*, *« cloche »*, *« lien en description »*, `[Musique]`, *« euh »*).
- **Zero Raw LaTeX / Markdown / Symbols**:
  - Never write `$`, `\frac`, `\vec`, `^2`, `u_n`, `**`, `#`, `[bold]` in `narration.txt`.
  - Write everything phonetically as spoken aloud:
    - `$x^2$` -> `x au carré`, `$\sqrt{x}$` -> `racine carrée de x`
    - `$u_{n+1}$` -> `u indice n plus 1`, `$f'(x)$` -> `f prime de x`, `$f''(x)$` -> `f seconde de x`
    - `$\overrightarrow{AB}$` -> `vecteur A B`, `$[2 ; 4]$` -> `l'intervalle fermé 2 point-virgule 4`
    - `$x \in ]-\infty ; 3[$` -> `x appartient à l'intervalle ouvert moins l'infini point-virgule 3`
- **Mandatory Visual Action Anchors (at least 4 per course)**:
  - Explicitly verbalize board actions so Layer 3 knows **when** and **what** to draw:
    - *« Traçons à droite un axe gradué... »*
    - *« Plaçons les bornes moins 2 et 5 sur cet axe... »*
    - *« Regarde la courbe que nous dessinons dans ce repère... »*
    - *« Suivons le déplacement de ce point... »*

---

## 3. Layer 3 — Hypercourse DSL (`courses/<ID>/course.hc`)

Follow `services/generation_orchestrator/prompts/layer3_visuals_system.md` and `hypercourse_dsl.md`:

### 3.1 Course Wrapper & Canvas
```hypercourse
course "Titre du cours" id <INT> idgap 100 for <DURATION>s audio "narration.wav" {
    # commands here
}
```
- **16:9 Coordinate Space**: $X \in [0, 177.78]$, $Y \in [0, 100]$, center $(88.89, 50)$.
- **Split-Board Layout**:
  - **Header**: Section title at `(4.0, 7.5)` + horizontal separator `draw line` at `[(4, 13.5), (173, 13.5)]`.
  - **Left Column ($x \in [3, 6]$, width up to $x \approx 82$)**: Explanations, step-by-step derivations, KaTeX equations (`y` spaced by at least `13–16` units, e.g. `y = 24, 39, 55, 72` so formulas never collide!).
  - **Right Column ($x \in [92, 173]$, $y \in [20, 90]$)**: Geometric figures, number lines, Cartesian `2drep` + `2dfunc` plots, force vectors, syntax trees, or visual synthesis diagrams.

### 3.2 Critical Dart Parser & Renderer Rules (DO NOT VIOLATE!)
1. **STRICT GLOBAL ID UNIQUENESS**:
   Every single command across the **entire** `.hc` file MUST have a **globally unique integer `id`**. Never reuse `text id 6` in Scene 2 if `text id 6` was used in Scene 1 (`HypercourseParser` stores all elements in `Map<int, HyperElement>`, so duplicate IDs overwrite earlier scenes!).
2. **`idgap` Namespace Ranges** (for `idgap 100`; use `idgap 200` if >100 elements needed):
   - `text`: `1 .. 100`
   - `draw`: `101 .. 200`
   - `mouse`: `301 .. 400`
   - `erase`: `401 .. 500`
   - **Forbidden**: NEVER use `speech` or `plot`.
3. **Strings & Apostrophes (`''...''`)**:
   - `text` strings are delimited by double single-quotes `''...''`.
   - Single French apostrophes inside `''...''` are valid as-is (`''L'intervalle d'étude''`) — **NEVER** write `\'`.
   - **NEVER** put two consecutive single-quotes `''` inside a string! For second derivatives in LaTeX, write `f^{\prime\prime}(x)` (**never** `f''(x)`, which prematurely closes `''...''`!).
4. **Brackets `[` and `]` inside `text` Strings**:
   - Outside `$...$`, `[` and `]` are parsed as BBCode tags (`[bold]`, `[/bold]`, `[italic]`, `[/italic]`, `[color=#HEX]`, `[/color]`).
   - **ALWAYS** wrap mathematical interval brackets inside `$...$` or `$$...$$`: e.g. `''[color=#38BDF8]$\mathbf{I = ]2 ; 4]}$[/color]''` (never raw `''[bold]]2 ; 4][/bold]''`!).
   - On number lines, draw crisp geometric interval brackets using `draw path` (e.g. `draw path id 112 start ... width 2.5 at [(123, 52), (120, 52), (120, 60), (123, 60)] ;`) — they look razor-sharp and never conflict with BBCode!
5. **Green Chalkboard Palette (High Contrast Only)**:
   - Text hex colors: `#F8FAFC` (chalk white), `#38BDF8` (sky cyan), `#34D399` (emerald), `#FBBF24` (amber), `#F87171` (coral red), `#C084FC` (lavender).
   - Draw RGBA colors: `(248, 250, 252, 0.95)`, `(56, 189, 248, 1)`, `(52, 211, 153, 1)`, `(251, 191, 36, 1)`, `(248, 113, 113, 1)`, `(192, 132, 252, 1)`.
   - Polygon/circle fills: translucent only (`alpha` between `0.12` and `0.25`), **NEVER** opaque white `(255, 255, 255, 0.95)` or dark navy `#1E3A8A`.
6. **Progressive Chalk Handwriting & Animation Duration (`for <D>s`)**:
   - Elements automatically stay visible on the board until the next `erase` (or end of course).
   - **`for` on `text` (Progressive Chalkboard Handwriting — ESSENTIAL)**:
     `LatexWidget` and `SmartMathClipper` simulate progressive left-to-right character-by-character chalk handwriting with an active blinking chalk cursor! When `for` is omitted, text pops up instantly like a PowerPoint slide — a real teacher writes on the board while speaking!
     - **Full sentences, definitions, theorems, explanations**: ALWAYS assign `for <D>s` where `<D>` is proportional to the spoken delivery in `words.txt` (typically `2.5s` to `5.5s`, matching vocal sentence delivery).
     - **Calculations & KaTeX display formulas**: Assign `for 2.0s` to `4.5s` as the teacher progressively writes out the formula or derivation step.
     - **Section titles & headers**: Assign `for 1.5s` to `2.5s` for a dignified chalkboard title reveal.
     - **Single numbers, short labels, axis ticks** (e.g. `$0$`, `$1$`, `$I$`, `$\mathbb{R}$`): Keep `for` short (`0.3s` to `0.8s`) or omit if instantaneous notation is preferred.
   - **`for` on `draw` / `mouse`**: Keep between `0.5s` and `2.0s` depending on the complexity of the geometric path.
   - **Pre-erase safety rule**: ALWAYS ensure `start + for < next_erase_start - 0.1s` for every element in a scene so the writing animation finishes before the board is erased, ensuring clean captures and zero truncated text.
7. **Exact Word-Timestamp Synchronization**:
   - Read `words.txt` (`<start>word<end>`) and trigger every `text`, `draw`, `mouse move`, and `erase` at the **actual timestamp** where the corresponding sentence/concept/action verb is spoken!

### 3.3 Supported Commands Quick Syntax
- `text id <1..100> start <T>s [for <D>s] at (<X>, <Y>) ''<BBCODE_OR_LATEX>'' ;` *(use `for 2.5s-5.5s` for progressive chalk handwriting while speaking!)*
- `draw line id <101..200> start <T>s for <D>s color (r, g, b, a) width <W> at [(x1, y1), (x2, y2)] ;`
- `draw arrow id <101..200> start <T>s for <D>s color (r, g, b, a) width <W> at [(x1, y1), (x2, y2)] ;`
- `draw path id <101..200> start <T>s for <D>s color (r, g, b, a) width <W> at [(x1, y1), (x2, y2), (x3, y3)] ;`
- `draw curve id <101..200> start <T>s for <D>s color (r, g, b, a) width <W> smooth at [(x1, y1), (x2, y2), (x3, y3)] [with +arrow at end] ;`
- `draw circle id <101..200> start <T>s for <D>s color (r, g, b, a) width <W> [fillcolor (r, g, b, a)] radius <R> at (cx, cy) ;`
- `draw polygone id <101..200> start <T>s for <D>s color (r, g, b, a) width <W> [fillcolor (r, g, b, a)] at [(x1, y1), (x2, y2), ...] ;`
- `draw 2drep id <101..200> start <T>s for <D>s at (cx, cy) color (248, 250, 252, 0.9) width 1.5 scale = <S> x_range = [xmin, xmax] y_range = [ymin, ymax] ;`
- `draw 2dfunc id <101..200> start <T>s for <D>s color (r, g, b, a) width 2.5 at <REP_ID> y = <EXPR_IN_x> ;` *(ops: `+ - * / ^`, funcs: `sin cos tan exp log sqrt abs`, consts: `pi e`)*
- `mouse move id <301..400> start <T>s for <D>s at [(x1, y1), (x2, y2)] ;`
- `erase id <401..500> start <T>s ;` *(clears all active elements cleanly between major sections)*

---

## 4. Multimodal World Model Visual Inspection (`scene_*.png`)

Follow `services/generation_orchestrator/prompts/layer3_visual_verifier_system.md`:
1. After `step3_render_and_verify.py` succeeds, **you MUST call `read_file` on EVERY `renders/scene_*.png` image**.
2. Inspect each rendered image with your own vision for:
   - Missing labels, broken KaTeX formulas, or clipped right/bottom margins;
   - Overlapping text lines or text colliding with axes/arrows/curves;
   - Misaligned ticks, pointers, or arrows not touching their target;
   - Readability on the dark green chalkboard.
3. **IMMUTABLE `start` RULE WHEN FIXING VISUALS**:
   When editing `course.hc` to fix a visual defect spotted in `scene_*.png`, **NEVER modify the `start` timestamp of existing elements** (because `start` is locked to Whisper's acoustic ground truth!). Only adjust coordinates `at (...)`, `width`, `radius`, `scale`, `color`, `fillcolor`, or concise text/line-breaks, then re-run `step3_render_and_verify.py` and re-view the updated PNGs before running `step4_certify_course.py`.

