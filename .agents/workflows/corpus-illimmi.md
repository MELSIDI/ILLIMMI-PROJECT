---
description: Generate and visually certify courses for ILLIMMI's 1,000-course Lycée corpus with configurable parallel subagents (1 to 5, default 5).
argument-hint: "[--workers 1..5] [--batch-size N] [--course-id ID] [--subject 'Name']"
---

# Corpus Generation Workflow (`/corpus-illimmi`)

Generate courses for the ILLIMMI 1,000-course Lycée corpus using the active Antigravity model (**Argon** via `Model="inherit"`), local Piper TTS, Whisper.cpp acoustic alignment, bespoke Hypercourse DSL (`.hc`), and multimodal PNG World Model verification.

## Usage

`/corpus-illimmi [--workers 1|2|3|4|5] [--batch-size N] [--course-id ID] [--subject "Matière"]`

Also accepts natural language commands such as:
- `/corpus-illimmi` (lance un lot par défaut avec 5 sous-agents)
- `/corpus-illimmi --workers 2` (règle la concurrence à 2 sous-agents en parallèle)
- `/corpus-illimmi --workers 1` (mode séquentiel, 1 sous-agent à la fois)
- `/corpus-illimmi --batch-size 15 --workers 3` (traite 15 cours avec une fenêtre glissante de 3 sous-agents)
- `"génère le corpus avec 4 sous-agents"`

## Arguments & Configuration

| Argument / Option | Description | Valeurs possibles | Valeur par défaut |
|---|---|---|---|
| `--workers`, `--concurrency`, `-w` | Nombre de sous-agents `illimmi-course-agent` actifs simultanément en parallèle | `1`, `2`, `3`, `4`, `5` | **`5`** |
| `--batch-size` | Nombre total de cours à sélectionner et traiter dans la session | Entier positif (ex: `5`, `10`, `25`) | `10` |
| `--course-id` | Identifiant(s) spécifique(s) de cours à générer | Ex: `MATH_021`, `MATH_021,MATH_022` | Non spécifié (prochains en attente) |
| `--subject` | Filtrer les cours par discipline | `Mathématiques`, `Physique-Chimie`, `Français`, `Anglais` | Non spécifié (toutes matières) |
| `--start-index` | Index numérique minimum de départ dans le catalogue | Ex: `21` pour démarrer à `MATH_021` | Non spécifié |

## Workflow d'Orchestration (Agent Maître)

### Étape 1 : Analyser les paramètres et sélectionner le lot
1. Extraire le nombre de sous-agents $W$ demandé par l'utilisateur ($1, 2, 3, 4 \text{ ou } 5$).
   - **Si l'utilisateur n'a rien précisé : utiliser $W = 5$ par défaut**.
2. Exécuter `select_batch.py` :
   ```powershell
   python ".agents/skills/corpus-illimmi/scripts/select_batch.py" --batch-size <N> --workers <W>
   ```

### Étape 2 : Lancement initial des $W$ premiers sous-agents
Pour le lot sélectionné, lancer immédiatement les $\min(W, N)$ premiers sous-agents en parallèle dans le même tour :

```python
initial_count = min(workers, len(selected_courses))
for course in selected_courses[:initial_count]:
    invoke_subagent(
        TypeName="illimmi-course-agent",
        Role=f"ILLIMMI Course Author ({course['id']})",
        Model="inherit", # RÈGLE ABSOLUE : garantit le modèle actif Argon
        Prompt=(
            f"Read .agents/skills/corpus-illimmi/SKILL.md (Section 'Single-Course 5-Step Execution Protocol') "
            f"and .agents/skills/corpus-illimmi/references/course_authoring_rules.md. "
            f"Execute Steps 1 -> 5 end-to-end for {course['id']} ('{course['title']}'). "
            f"Certify with step4_certify_course.py and return the JSON certification summary."
        )
    )
```

Terminer le tour sans appeler d'autre outil pour attendre les notifications réactives.

### Étape 3 : Gestion du Pool Glissant (Sliding Window de $W$ Workers)
- Le système Antigravity réveille automatiquement l'agent maître à chaque fin de cours via **reactive wakeup** (zéro polling).
- À chaque réveil :
  1. Enregistrer la complétion du cours certifié.
  2. S'il reste des cours non démarrés dans le lot, lancer immédiatement le cours suivant pour maintenir le pool saturé à $W$ sous-agents actifs.
  3. Répéter jusqu'à certification complète de tous les cours du lot.

### Étape 4 : Synchronisation Cloud Automatique Google Drive
Dès que tous les cours du lot sont certifiés, exécuter automatiquement :
```powershell
python ".agents/skills/corpus-illimmi/scripts/drive_corpus_sync.py" auto-sync
```

