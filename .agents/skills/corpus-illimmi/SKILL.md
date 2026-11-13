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
3. **Configurable Parallel Multi-Subagent Architecture (1 to 5 Concurrent Subagents, Default: 5)**:
   - When generating **multiple courses** (e.g. under `/goal` or `/corpus-illimmi`), the main agent acts as an **Asynchronous Parallel Batch Orchestrator** and launches **configurable parallel subagents** :
     * **Nombre réglable de sous-agents** : l'utilisateur peut choisir d'exécuter `1`, `2`, `3`, `4` ou `5` sous-agents simultanément en parallèle (via `--workers 1..5`, `--concurrency 1..5`, `-w 1..5`, ou en langage naturel).
     * **Par défaut si non précisé : 5 sous-agents en parallèle** pour une accélération maximale (~5h de travail compressées en **~1h**).
     * **Mode unitaire / séquentiel** : si l'utilisateur demande explicitement 1 sous-agent (`--workers 1`), les cours sont traités un par un.
   - Every subagent invoked via `invoke_subagent` **MUST** set `Model="inherit"` (Argon active model).
   - **Zero Collision Guarantee**: Each course has its own directory `courses/<COURSE_ID>/`. Shared catalog files (`progress.json`, `corpus_1000_full.json`, and `manifest.csv`) are protected by exclusive `InterprocessLock` and atomic file writes, while YouTube video claims are reserved in `transcripts/raw/.claims/`.
4. **ZERO Limit on Words, Audio Duration, Sections, or Scenes (100% Transcript-Driven)**:
   - **NEVER impose any cap on word count, audio length, section count, or scene count!**
   - The ONLY upstream duration rule is at **Step 1 (YouTube selection)**: the source YouTube video must be **`<= 1 hour` (`<= 3600s`)** (enforced automatically by `step1_ingest_youtube.py`).
   - Once `raw_transcript.txt` is ingested, **NEVER summarize, condense, or truncate the course**: if cleaning `raw_transcript.txt` yields `500` words, `3,000` words, or `10,000` words, write the **entire** `500`, `3,000`, or `10,000` words in `narration.txt`, synthesize the full `narration.wav` audio without limit, and create as many board scenes (`erase` transitions: `5`, `15`, `40+` scenes, scaling `idgap` to `200`, `500`, `1000+` as needed) as required to illustrate every step cleanly!

---

## Batch Orchestrator Workflow (Main Agent)

### 1. Parse Concurrency & Select the Pending Batch
1. **Détection du nombre de sous-agents (`workers` / `concurrency`)** :
   - L'utilisateur peut régler le nombre de sous-agents dans sa commande ou son prompt (ex: `/corpus-illimmi --workers 2`, `--concurrency 3`, `-w 4`, ou en langage naturel "avec 2 sous-agents", "génère 10 cours avec 3 agents").
   - **Valeurs autorisées : 1, 2, 3, 4 ou 5**.
   - **Valeur par défaut si non précisé : 5 sous-agents**.
2. **Déterminer la taille du lot** (défaut : `10` ; max recommandé : `25` par jour pour YouTube) ou l'identifiant spécifique, puis exécuter :

```powershell
python ".agents/skills/corpus-illimmi/scripts/select_batch.py" --batch-size 10 --workers <WORKERS_1_TO_5>
```
*(Optionnel : `--course-id MATH_021`, `--subject "Mathématiques"`, `--start-index 21`.)*

### 2. Launch Parallel Subagents (Sliding Window de W Workers)
Pour un lot de $N$ cours avec une concurrence configurée à $W \in \{1, 2, 3, 4, 5\}$ (**défaut : 5**) :
- Lancer immédiatement les $\min(W, N)$ premiers sous-agents simultanément dans le premier tour (`invoke_subagent`).

```python
# Launch initial batch of W subagents (W in [1..5], default: 5):
initial_count = min(workers, len(selected_courses))
for c in selected_courses[:initial_count]:
    invoke_subagent(
        TypeName="illimmi-course-agent",
        Role=f"ILLIMMI Course Author ({c['id']})",
        Model="inherit", # MANDATORY: guarantees Argon active model
        Prompt=(
            f"Read .agents/skills/corpus-illimmi/SKILL.md (Section 'Single-Course 5-Step Execution Protocol') "
            f"and .agents/skills/corpus-illimmi/references/course_authoring_rules.md. "
            f"Execute Steps 1 -> 5 end-to-end for {c['id']} ('{c['title']}'). "
            f"Certify with step4_certify_course.py and return the JSON certification summary."
        )
    )
```

#### Pool Glissant Continu (Sliding Window de W Workers) :
- **Remplissage initial** : L'agent maître lance $\min(W, N)$ cours en parallèle.
- **Remplacement continu sans temps mort (Reactive Wakeup)** :
  Dès qu'un sous-agent termine son cours, le système réveille l'agent maître via **reactive wakeup** (zéro polling). L'agent maître enregistre la certification et **lance immédiatement le cours suivant** de la file.
- **Maintien de la saturation** : À chaque instant, il y a toujours au maximum $W$ sous-agents actifs en parallèle, jusqu'à épuisement complet de la liste demandée.
- **Dimensionnement selon $W$** :
  - **$W = 1$** : Exécution séquentielle simple (idéale pour tester ou déboguer un cours isolé).
  - **$W = 2$ ou $3$** : Concurrence modérée (très économe en ressources système).
  - **$W = 4$ ou $5$ (défaut: 5)** : Vitesse maximale (génère 5 cours en ~1h au lieu de 5h).

### 3. Reactive Wakeup & Completion Monitoring (Zero-Polling Sliding Window)
- Après avoir saturé les $W$ slots de workers, terminer votre tour sans appeler d'autre outil.
- **NE PAS SCRUTER EN BOUCLE (Zero Polling)** : Le système Antigravity réveille automatiquement l'agent maître dès qu'un sous-agent notifie sa complétion.
- À chaque réveil :
  1. Vérifier la complétion du cours dans `catalog/progress.json`.
  2. S'il reste des cours non démarrés dans la file demandée, instancier immédiatement un sous-agent frais pour le cours suivant (`TypeName="illimmi-course-agent"`, `Model="inherit"`).
  3. Dès que tous les cours du lot demandé sont certifiés, passer immédiatement à l'Étape 4.

### 4. MANDATORY Automated Incremental Google Drive Sync (`auto-sync`) & Progress Notifications (25%, 50%, 75%)
Dès que l'ensemble des cours demandés (ex: lot de 9, 15, 20 ou 25 cours) est certifié, l'agent maître **DOIT AUTOMATIQUEMENT** exécuter le synchronisateur cloud incrémental :

```powershell
python ".agents/skills/corpus-illimmi/scripts/drive_corpus_sync.py" auto-sync
```

#### Suivi et Notifications Proactives des Paliers (25 %, 50 %, 75 %) :
Pendant le téléversement des archives binaires sur Google Drive, `drive_corpus_sync.py` calcule en continu l'avancement du lot et maintient le fichier d'état `corpus_illimmi_1000/catalog/.sync_progress.json` tout en affichant des bannières de jalon explicites.
- **Surveillance périodique** : L'agent utilise `schedule` (toutes les 45 à 60s) ou vérifie la tâche pour interroger `python ".agents/skills/corpus-illimmi/scripts/drive_corpus_sync.py" progress`.
- **Notification chat obligatoire à chaque palier** : Dès que l'envoi franchit ou atteint **25 %**, **50 %** ou **75 %** du lot (ou à chaque cours terminé pour les petits lots de moins de 4 cours), l'agent **doit poster un message synthétique et visuel dans le chat** :
  ```markdown
  ### 🚀 Synchro Google Drive : Palier [25% | 50% | 75%] atteint !
  - **Progression** : `X / N cours envoyés` (P%)
  - **Volume transféré** : `Y Mo`
  - **Dernier cours téléversé** : `MATH_XXX`
  ```

**Ce que fait `drive_corpus_sync.py auto-sync` en toute autonomie :**
1. **Régénération des exports JSONL SFT** (`export_certified_jsonl.py`).
2. **Archivage strictement incrémental** : Liste l'intégralité des archives sur Drive (`--max 0`) et ne package en ZIP (dans le cache unique `corpus_exports/courses_archives/`) que les cours **nouveaux** ou **re-certifiés** depuis la dernière synchro.
3. **Upload & Mise à jour Cloud sans duplication (`ILLIMMI_CORPUS_STORE/`)** :
   - Stockage plat permanent : `ILLIMMI_CORPUS_STORE / (courses_archives, training_data, catalog, corpus_manifest.json)` (aucun dossier `releases/<tag>/`).
   - Ignore immédiatement les cours déjà présents sur Drive ; téléverse uniquement les nouveaux cours et met à jour `catalog/`, `training_data/` et `corpus_manifest.json` **en place** (`gdrive mutate update`).
4. **Mise à jour du manifeste `corpus_manifest.json`** : Enregistre les IDs Google Drive, empreintes SHA-256, dates de synchronisation (`last_sync_date`, `gdrive_synced_at`) et l'historique daté `sync_batches`.
5. **Git Push Découplé** : Committe et pousse uniquement le manifeste JSON léger (<50 Ko) sur `origin/dsl_dev`, en garantissant que **zéro binaire lourd** (PNG, WAV, MP4) ne pollue le dépôt Git.

### 5. Final Batch Report & Goal Completion
Afficher le tableau récapitulatif du lot (`Course ID`, `Title`, `Duration`, `Words`, `Scenes`, `World Model Score`), le total global mis à jour (`X / 1000`), la date/tag de synchro ainsi que le lien du store Google Drive (`https://drive.google.com/drive/folders/...`), et l'ID du prochain cours en attente.
*(Si `/goal` est actif, inclure `<!-- GOAL_COMPLETE -->` uniquement une fois la synchronisation Google Drive et Git confirmée !)*

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
   - **Fonctions mathématiques (`draw 2drep` & `draw 2dfunc`)** :
     * **Positionnement flexible de l'origine `at (cx, cy)` dans la zone droite ($X \in [92, 173], Y \in [18, 92]$)** : L'origine $(0, 0)$ est choisie judicieusement par l'agent selon les quadrants utiles du problème. Si le domaine est centré (ex: $[-4, 4] \times [-3, 3]$), centrer l'origine au milieu de la zone droite `at (133, 55)`. Si le domaine est strictement positif (ex: $[0, 10] \times [0, 10]$ pour suites, temps $t \ge 0$, racines, log), placer l'origine en bas à gauche de la zone de dessin (ex: `at (104, 84)`) pour que le premier quadrant occupe tout l'espace disponible vers le haut et la droite sans déborder. Formule d'aide au centrage : $cx \approx 133 - x_{mid} \times scale$ et $cy \approx 55 + y_{mid} \times scale$.
     * **Dimensionnement obligatoire du zoom `scale`** : dimensionner impérativement `scale ≈ 52 / (xmax - xmin)` (ex: `scale = 6.5` pour `[-4, 4]`, `scale = 8.0` pour `[-3, 3]`, `scale = 5.5` pour `[0, 10]`). Ne JAMAIS laisser `scale = 1.0` (microscopique, rejeté par WorldModelVerifier).
     * **Grille et graduation** : Toujours inclure `grid = true`, `grid_alpha = 0.7`, et un pas adapté `step = 1`. Tracer la courbe avec `draw 2dfunc id ... at <repere_id> y = <expression>`.
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
