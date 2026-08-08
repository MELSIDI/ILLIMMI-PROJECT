# ILLIMMI — Documentation Technique Complète

> **Hypercourse DSL · Pipeline IA · Génération de Dataset**

---

## Table des matières

1. [Le DSL Hypercourse](#1-le-dsl-hypercourse)
2. [Pipeline IA ILLIMMI](#2-pipeline-ia-illimmi)
3. [Pipeline Génération de Dataset](#3-pipeline-génération-de-dataset)

---

# 1. Le DSL Hypercourse

## 1.1 Vue d'ensemble

Hypercourse est un langage de description de cours interactifs. Il permet de synchroniser des appuis visuels (figures, textes, formules) avec un fichier audio d'un professeur.

Dans l'architecture ILLIMMI, **l'audio est unique et externe** : il est généré en amont par un TTS (Piper), puis les appuis visuels sont placés dans sa temporalité via leurs timestamps.

> La commande `speech` n'est plus utilisée dans l'architecture ILLIMMI. Elle reste supportée pour la compatibilité legacy.

---

## 1.2 Système de coordonnées

Le tableau utilise un repère normalisé **16:9** :

```
(0, 0) ─────────────────────────────── (177.78, 0)
  │                                           │
  │               (88.89, 50)                 │
  │            [Centre du tableau]            │
  │                                           │
  │                (84, 55)                   │
  │           [Centre Pédagogique]            │
  │                                           │
(0, 100) ─────────────────────────── (177.78, 100)
```

| Point | Coordonnées |
|-------|-------------|
| Coin supérieur gauche | `(0, 0)` |
| Coin inférieur droit | `(177.78, 100)` |
| Centre du tableau | `(88.89, 50)` |
| Centre pédagogique | `(84, 55)` |

---

## 1.3 Gestion du temps

Tous les événements sont exprimés en secondes.

```hypercourse
start 2.5s      # Démarre à 2,5 secondes depuis le début de l'audio
for 1.5s        # Durée d'animation de 1,5 seconde pour l'apparition    complete de l'élément.
```

**Règles :**
- Le suffixe `s` est obligatoire
- Les décimales sont supportées
- `start` est **obligatoire** pour chaque élément
- `for` est **optionnel** — si absent, l'élément appairait instantanément et resterait affiché jusqu'à la fin du cours ou jusqu'à un `erase`.

---

## 1.4 Identifiants (ID)

Chaque élément nécessite un ID unique. La convention dépend de `idgap` :

| Type | Plage |
|------|-------|
| `text` | 1 à idgap |
| `draw` | idgap+1 à 2×idgap |
| `speech` | 2×idgap+1 à 3×idgap |
| `mouse` | 3×idgap+1 à 4×idgap |
| `erase` | 4×idgap+1 à 5×idgap |

**Exemple avec `idgap 100` (valeur recommandée) :**

| Type | Plage |
|------|-------|
| `text` | 1 – 100 |
| `draw` | 101 – 200 |
| `speech` | 201 – 300 | 
| `mouse` | 301 – 400 |
| `erase` | 401 – 500 |

---

## 1.5 Couleurs

Format RGBA : `color (R, G, B, A)`

```hypercourse
color (255, 0, 0, 1)          # Rouge opaque
color (0, 100, 255, 0.5)      # Bleu semi-transparent
fillcolor (200, 200, 0, 0.3)  # Remplissage jaune translucide
```

- **R, G, B** : 0–255
- **A** : 0.0–1.0

---

## 1.6 Formatage de texte

Le contenu textuel est encadré par `''` :

| Syntaxe | Résultat |
|---------|----------|
| `''texte''` | Texte normal |
| `''[bold]texte[/bold]''` | **Gras** |
| `''[italic]texte[/italic]''` | *Italique* |
| `''[color=#FF0000]texte[/color]''` | Texte coloré |
| `''[font=Courier]texte[/font]''` | Police spécifique |
| `''$E=mc^2$''` | Formule LaTeX inline |
| `''$$\int_0^\infty e^{-x}dx$$''` | Formule LaTeX display |

L'imbrication est supportée :

```hypercourse
''[bold][color=#00FF00]Texte vert en gras[/color][/bold]''
```

---

## 1.7 Structure d'un cours

### Nouveau format ILLIMMI (avec audio externe)

```hypercourse
course "Titre du cours" id <courseid> idgap <idgap> for <durée>s audio "<fichier.wav>" {

    # Appuis visuels uniquement — l'audio joue en fond
    text id 1 start 1.5s at (88.89, 8) ''[bold]Titre[/bold]'' ;
    draw circle id 101 start 5.2s ... ;
    ...
}
```

**Paramètres du header :**

| Paramètre | Description |
|-----------|-------------|
| `id` | Identifiant unique du cours |
| `idgap` | Taille des plages d'IDs (recommandé : 100) |
| `for` | Durée totale = durée exacte de l'audio `.wav` |
| `audio` | Chemin vers le fichier audio (`.wav`, `.mp3`, ...) |

### Format legacy (avec speech intégré)

```hypercourse
course "Titre" id <id> idgap <idgap> for <durée>s {
    speech id 201 start 1s ''Bonjour...'' ;
    text id 1 start 1s at (88.89, 8) ''Titre'' ;
    ...
}
```

---

## 1.8 Référence des commandes

### `text` — Affichage de texte ou formule LaTeX

```hypercourse
text id <n> start <t>s [for <d>s] at (<x>, <y>) ''<contenu>'' ;
```

**Exemple :**
```hypercourse
text id 1 start 1.5s for 30s at (88.89, 8)
     ''[bold][color=#2980B9]Les Dérivées[/color][/bold]'' ;

text id 2 start 12s at (88.89, 40)
     ''$$f'(x) = \lim_{h \to 0} \frac{f(x+h)-f(x)}{h}$$'' ;
```

---

### `draw line` — Ligne droite

```hypercourse
draw line id <n> start <t>s [for <d>s]
          [color (<r>,<g>,<b>,<a>)] width <w>
          at [(<x1>,<y1>), (<x2>,<y2>)] ;
```

---

### `draw arrow` — Flèche

```hypercourse
draw arrow id <n> start <t>s [for <d>s]
           [color (<r>,<g>,<b>,<a>)] width <w>
           at [(<x1>,<y1>), (<x2>,<y2>)] ;
```

---

### `draw path` — Ligne brisée

```hypercourse
draw path id <n> start <t>s [for <d>s]
          [color (<r>,<g>,<b>,<a>)] width <w>
          at [(<x1>,<y1>), (<x2>,<y2>), ...] ;
```

---

### `draw curve` — Courbe lissée

```hypercourse
draw curve id <n> start <t>s [for <d>s]
           [color (<r>,<g>,<b>,<a>)] width <w>
           [smooth|bezier]
           at [points]
           [with <+/->arrow at end] ;
```

Options :
- `smooth` : lissage naturel (défaut)
- `bezier` : courbe de Bézier
- `+arrow` : flèche dans le sens trigonométrique
- `-arrow` : flèche dans le sens horaire

---

### `draw circle` — Cercle

```hypercourse
draw circle id <n> start <t>s [for <d>s]
            [color (<r>,<g>,<b>,<a>)] [width <w>]
            [fillcolor (<r>,<g>,<b>,<a>)]
            radius <r> at (<cx>, <cy>)
            [with <+/->arrow on <angle>deg] ;
```

**Exemple :**
```hypercourse
draw circle id 101 start 5.2s for 2s
            color (41, 128, 185, 1) width 3
            fillcolor (41, 128, 185, 0.15)
            radius 20 at (88.89, 55) ;
```

---

### `draw ellipse` — Ellipse

```hypercourse
draw ellipse id <n> start <t>s [for <d>s]
             [color (<r>,<g>,<b>,<a>)] [width <w>]
             [fillcolor (<r>,<g>,<b>,<a>)]
             radiusX <rx> radiusY <ry>
             [rotation <angle>]
             at (<cx>, <cy>)
             [with <+/->arrow on <angle>deg] ;
```

---

### `draw arc` — Arc de cercle

```hypercourse
draw arc id <n> start <t>s [for <d>s]
         [color (<r>,<g>,<b>,<a>)] [width <w>]
         [fillcolor (<r>,<g>,<b>,<a>)]
         radius <r> at (<cx>, <cy>)
         from <début>deg to <fin>deg
         [with <+/->arrow at end] ;
```

---

### `draw elliptic_arc` — Arc elliptique

```hypercourse
draw elliptic_arc id <n> start <t>s [for <d>s]
                  [color (<r>,<g>,<b>,<a>)] [width <w>]
                  [fillcolor (<r>,<g>,<b>,<a>)]
                  radiusX <rx> radiusY <ry>
                  [rotation <angle>]
                  at (<cx>, <cy>)
                  from <début>deg to <fin>deg
                  [with <+/->arrow at end] ;
```

---

### `draw polygone` — Polygone

```hypercourse
draw polygone id <n> start <t>s [for <d>s]
              [color (<r>,<g>,<b>,<a>)] [width <w>]
              [fillcolor (<r>,<g>,<b>,<a>)]
              at [(<x1>,<y1>), (<x2>,<y2>), ...] ;
```

---

### `draw 2drep` — Repère cartésien

```hypercourse
draw 2drep id <n> start <t>s [for <d>s]
           at (<x>, <y>)
           [color (<r>,<g>,<b>,<a>)] [width <w>]
           [scale = <facteur>]
           [x_range = [xmin, xmax]]
           [y_range = [ymin, ymax]] ;
```

**Valeurs par défaut :**
- Position : `(88.89, 50)`
- Scale : `1.0`
- x_range : `[-10, 10]`
- y_range : `[-10, 10]`

**Exemple :**
```hypercourse
draw 2drep id 101 start 8s
           at (88.89, 55)
           scale = 1.5
           x_range = [-5, 5]
           y_range = [-2, 8] ;
```

---

### `draw 2dfunc` — Fonction mathématique

```hypercourse
draw 2dfunc id <n> start <t>s [for <d>s]
            [color (<r>,<g>,<b>,<a>)] [width <w>]
            at <id_du_repere>
            y = <expression> ;
```

**Expressions supportées :**

| Type | Éléments |
|------|----------|
| Opérateurs | `+`, `-`, `*`, `/`, `^` |
| Fonctions | `sin`, `cos`, `tan`, `exp`, `log`, `sqrt`, `abs` |
| Constantes | `pi`, `e` |
| Variable | `x` |

**Exemples :**
```hypercourse
draw 2dfunc id 102 start 10s color (41, 128, 185, 1) width 2 at 101 y = x^2 ;
draw 2dfunc id 103 start 12s color (231, 76, 60, 1) width 2 at 101 y = sin(x) ;
draw 2dfunc id 104 start 14s at 101 y = exp(-x^2/2) ;
draw 2dfunc id 105 start 16s at 101 y = sin(x) * exp(-x/5) ;
```

---

### `mouse move` — Animation du curseur

```hypercourse
mouse move id <n> start <t>s for <d>s
           at [(<x1>,<y1>), (<x2>,<y2>), ...] ;
```

**Exemple :**
```hypercourse
# Le curseur souligne une formule en 2 secondes
mouse move id 301 start 15.5s for 2s
           at [(55, 45), (135, 45)] ;
```

---

### `erase` — Effacement

```hypercourse
erase id <n> start <t>s [for <d>s]
      at [<id1>, <id2>, ...] ;
```

**Règle critique :** les IDs référencés dans `at [...]` doivent être des éléments actuellement visibles à l'écran.

**Exemple :**
```hypercourse
erase id 401 start 35.8s for 1s at [1, 101, 102] ;
```

---

### `speech` — Narration vocale (legacy uniquement)

```hypercourse
speech id <n> start <t>s [for <d>s] ''<texte>'' ;
```

> **Déprécié dans l'architecture ILLIMMI.** Utilisé uniquement en mode legacy sans fichier `audio`.

---

## 1.9 Exemple complet — Architecture ILLIMMI

```hypercourse
course "Les Dérivées" id 1000 idgap 100 for 87.3s audio "derivees.wav" {

    # ══════════════════════════════════════
    # SECTION 1 : INTRODUCTION (0s – 12s)
    # ══════════════════════════════════════

    # Le prof dit "dérivées" à 1.3s → titre apparaît à 1.5s
    text id 1 start 1.5s at (88.89, 8)
         ''[bold][color=#2980B9]Les Dérivées[/color][/bold]'' ;

    # ══════════════════════════════════════
    # SECTION 2 : LA COURBE (12s – 35s)
    # ══════════════════════════════════════

    # Le prof dit "courbe" à 12.2s → repère apparaît à 12.5s
    draw 2drep id 101 start 12.5s
               at (88.89, 55) scale = 1.5
               x_range = [-2, 4] y_range = [-1, 10] ;

    # Le prof dit "x carré" à 14s → fonction tracée à 14.2s
    draw 2dfunc id 102 start 14.2s for 20s
                color (41, 128, 185, 1) width 2.5
                at 101 y = x^2 ;

    # Label de la fonction
    text id 2 start 14.5s for 20s at (140, 22)
         ''[color=#2980B9]$f(x) = x^2$[/color]'' ;

    # ══════════════════════════════════════
    # SECTION 3 : LA DÉFINITION (35s – 70s)
    # ══════════════════════════════════════

    # Effacement avant nouvelle section
    erase id 401 start 35.8s for 1s at [1, 2, 101, 102] ;

    # Le prof dit "définition" à 36.2s
    draw circle id 103 start 36.5s
                color (231, 76, 60, 1) fillcolor (231, 76, 60, 1)
                radius 2 at (88.89, 55) ;

    text id 3 start 37s at (88.89, 20)
         ''[bold]Définition :[/bold]'' ;

    # Le prof énonce la formule à 40s
    text id 4 start 40.3s at (88.89, 40)
         ''$$f'(a) = \lim_{h \to 0} \frac{f(a+h)-f(a)}{h}$$'' ;

    mouse move id 301 start 41s for 3s
               at [(45, 43), (133, 43)] ;

    # ══════════════════════════════════════
    # SECTION 4 : CONCLUSION (70s – 87.3s)
    # ══════════════════════════════════════

    erase id 402 start 70s for 1s at [103, 3, 4] ;

    text id 5 start 71s at (88.89, 45)
         ''[bold][color=#27AE60]Dérivée = pente de la tangente[/color][/bold]'' ;
}
```

---

# 2. Pipeline IA ILLIMMI

## 2.1 Vue d'ensemble

ILLIMMI est un système à **3 couches** (layers) qui transforme la demande d'un utilisateur en un cours interactif complet.

```
Utilisateur : "Explique-moi les dérivées"
         │
         ▼
┌──────────────────────┐
│   LAYER 1            │
│   Planification      │  → Métadonnées pédagogiques
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│   LAYER 2            │
│   Génération Audio   │  → Transcript + audio.wav + timestamps
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│   LAYER 3            │
│   Appuis Visuels     │  → Script Hypercourse (.hc)
│   (Gemma 4)          │
└──────────┬───────────┘
           │
           ▼
    App Flutter joue
    audio + visuels synchronisés
```

---

## 2.2 Layer 1 — Planification pédagogique

**Entrée :** prompt utilisateur

**Rôle :** Analyser la demande et produire les métadonnées pédagogiques qui guideront les layers suivants.

**Sortie :**
```json
{
  "subject": "Les Dérivées",
  "level": "Terminale",
  "duration_target": 90,
  "concepts_cles": ["taux de variation", "tangente", "limite", "notation f'(x)"],
  "structure": [
    { "section": "Introduction", "duree_estimee": 15 },
    { "section": "Définition par la limite", "duree_estimee": 25 },
    { "section": "Interprétation géométrique", "duree_estimee": 25 },
    { "section": "Exemple numérique", "duree_estimee": 20 },
    { "section": "Conclusion", "duree_estimee": 5 }
  ],
  "ton": "pédagogique, progressif, encourageant",
  "langue": "fr"
}
```

---

## 2.3 Layer 2 — Génération de l'audio

**Entrée :** métadonnées pédagogiques (Layer 1)

**Rôle :** Générer le transcript complet du cours, le synthétiser en audio, et aligner les timestamps mot par mot.

**Étapes internes :**

```
Métadonnées
    │
    ▼
LLM génère le transcript complet
    │
    ▼
Piper TTS → audio.wav (offline, local)
    │
    ▼
WhisperX (forced alignment)
→ chaque mot avec son timestamp exact
    │
    ▼
Sortie Layer 2
```

**Sortie :**
```json
{
  "transcript": "Bonjour, aujourd'hui nous allons étudier les dérivées...",
  "transcript_timestamped": [
    { "word": "Bonjour",      "start": 0.5,  "end": 0.9  },
    { "word": "aujourd'hui",  "start": 1.0,  "end": 1.5  },
    { "word": "dérivées",     "start": 3.1,  "end": 3.7  },
    { "word": "tangente",     "start": 18.2, "end": 18.8 },
    { "word": "limite",       "start": 32.5, "end": 32.9 }
  ],
  "duration": 87.3,
  "audio_file": "derivees.wav",
  "language": "fr"
}
```

---

## 2.4 Layer 3 — Génération des appuis visuels (Gemma 4)

**C'est ici que Gemma 4 fine-tuné intervient.**

**Entrée :**
- Transcript timestampé mot par mot
- Durée totale de l'audio
- Métadonnées pédagogiques

**Rôle :** Générer les éléments visuels Hypercourse (figures, textes, formules) avec leurs timestamps précis, calés sur les mots du transcript.

**Principe de synchronisation :**

```
Mot "dérivées" détecté à 3.1s
    → draw / text apparaît à 3.1s + 0.2s = 3.3s

Mot "tangente" détecté à 18.2s
    → draw line (tangente) apparaît à 18.4s

Mot "formule" détecté à 32.5s
    → text LaTeX apparaît à 32.7s
```

**Règle des 0.2s – 0.5s :** chaque élément visuel apparaît légèrement après le mot qui le déclenche, comme un vrai prof qui parle puis écrit.

**Sortie :**
```hypercourse
text id 1 start 1.5s at (88.89, 8) ''[bold]Les Dérivées[/bold]'' ;
draw 2drep id 101 start 12.5s at (88.89, 55) scale=1.5 ;
draw 2dfunc id 102 start 14.2s color (41,128,185,1) at 101 y = x^2 ;
erase id 401 start 35.8s for 1s at [1] ;
...
```

---

## 2.5 Assemblage final

Le système assemble le script Hypercourse complet :

```hypercourse
course "Les Dérivées" id 1000 idgap 100 for 87.3s audio "derivees.wav" {
    # [sortie de Layer 3 insérée ici]
    text id 1 start 1.5s ...
    draw 2drep id 101 ...
    ...
}
```

L'app Flutter reçoit ce fichier `.hc` et :
1. Lance `derivees.wav` dès le départ
2. Exécute chaque commande Hypercourse à son timestamp précis

---

## 2.6 Boucle question élève

Quand l'élève interrompt le cours avec une question :

```
Cours principal en cours (audio + visuels)
         │
         │  ← Élève : "Je comprends pas la limite"
         ▼
Cours principal → PAUSE

Layer 1 : analyse la question dans le contexte du cours
Layer 2 : génère transcript de réponse → audio_reponse.wav
Layer 3 : génère visuels de la réponse

         ▼
Mini-cours de réponse joué (audio + visuels)

         │
         │  ← Élève : "Oui c'est bon merci"
         ▼
Cours principal → REPREND là où il s'était arrêté
```

Ce cycle peut se répéter autant de fois que nécessaire jusqu'à la satisfaction de l'élève.

---

# 3. Pipeline Génération de Dataset

## 3.1 Principe

Le dataset est généré automatiquement à partir de **vidéos YouTube** de cours de mathématiques. Un LLM puissant (Claude) joue le rôle de Layer 3 pour annoter les appuis visuels — ces annotations deviennent les exemples d'entraînement de Gemma 4.

```
Vidéo YouTube (cours réel de prof humain)
         │
         ▼
yt-dlp → audio.wav
         │
         ▼
WhisperX → transcript timestampé
         │
         ▼
Claude (Layer 3 simulé) → appuis visuels Hypercourse
         │
         ▼
Validateur → vérifie syntaxe, IDs, coordonnées
         │
         ▼
Paire dataset { input, output } sauvegardée
```

---

## 3.2 Format d'une paire dataset

```json
{
  "id": 42,
  "metadata": {
    "subject": "Les Dérivées",
    "level": "Terminale",
    "source_url": "https://youtube.com/watch?v=..."
  },
  "input": {
    "transcript": "Bonjour, aujourd'hui nous allons étudier les dérivées...",
    "transcript_timestamped": [
      { "word": "Bonjour",    "start": 0.5,  "end": 0.9  },
      { "word": "dérivées",   "start": 3.1,  "end": 3.7  },
      { "word": "tangente",   "start": 18.2, "end": 18.8 },
      { "word": "f",          "start": 32.1, "end": 32.2 },
      { "word": "prime",      "start": 32.3, "end": 32.6 }
    ],
    "duration": 87.3,
    "audio_file": "audio.wav"
  },
  "output": "text id 1 start 1.5s at (88.89, 8) ''[bold]Les Dérivées[/bold]'' ;\ndraw 2drep id 101 start 12.5s at (88.89, 55) scale=1.5 ;\ndraw 2dfunc id 102 start 14.2s color (41,128,185,1) at 101 y = x^2 ;\nerase id 401 start 35.8s for 1s at [1] ;",
  "hypercourse_script": "course \"Les Dérivées\" id 1000 idgap 100 for 87.3s audio \"audio.wav\" {\n    ...\n}"
}
```

**Note importante :** Le transcript dans `input` ne contient **pas** les timestamps — l'IA doit apprendre à les inférer depuis le fichier audio. Les timestamps sont disponibles dans `transcript_timestamped` pour la supervision.

---

## 3.3 Étapes du pipeline

### Étape 1 — Téléchargement audio

```bash
yt-dlp --extract-audio --audio-format wav \
       --output "audio" \
       "https://youtube.com/watch?v=..."
```

### Étape 2 — Transcription et alignment

```python
import whisperx

model = whisperx.load_model("large-v2", device="cuda")
audio = whisperx.load_audio("audio.wav")

# Transcription
result = model.transcribe(audio, language="fr")

# Forced alignment — timestamps mot par mot
model_a, metadata = whisperx.load_align_model(language_code="fr", device="cuda")
result = whisperx.align(result["segments"], model_a, metadata, audio, device="cuda")

# Extraction
words = [
    { "word": w["word"], "start": w["start"], "end": w["end"] }
    for segment in result["segments"]
    for w in segment.get("words", [])
]
```

### Étape 3 — Génération des appuis visuels (Claude)

Claude reçoit le transcript formaté avec timestamps et génère les commandes Hypercourse :

```
[0.5s] Bonjour aujourd'hui nous allons étudier les dérivées
[5.2s] La dérivée mesure la pente de la tangente
[10.8s] Regardons la courbe f de x égal x carré
[18.2s] Traçons la tangente en ce point
[32.5s] La formule est f prime de a égal limite...
```

**Prompt système :**

```
Tu es ILLIMMI Layer 3.
Tu reçois un transcript de cours de mathématiques avec les timestamps de chaque groupe de mots.
Tu génères uniquement les commandes Hypercourse (text, draw, mouse, erase) qui servent d'appuis visuels.

RÈGLES :
- Chaque élément apparaît 0.2s à 0.5s après le mot déclencheur
- IDs : text(1-100), draw(101-200), mouse(301-400), erase(401-500)
- Coordonnées : x ∈ [0, 177.78], y ∈ [0, 100]
- Pas trop d'éléments — un vrai prof n'écrit pas tout
- Effacer entre les grandes sections avec erase
- Génère uniquement les commandes, rien d'autre
```

### Étape 4 — Validation automatique

```python
def validate(script, duration):
    errors = []
    used_ids = {}
    active_ids = set()

    for line in script.splitlines():
        # Vérification des plages d'IDs
        # Vérification des coordonnées [0,177.78] x [0,100]
        # Vérification des timestamps ≤ duration
        # Vérification que erase référence des IDs actifs
        ...

    return errors
```

Si des erreurs sont détectées → Claude corrige (jusqu'à 3 tentatives).

### Étape 5 — Sauvegarde

```
dataset/
├── pair_0001.json     ← paire input/output
├── pair_0001.hc       ← script Hypercourse complet
├── pair_0002.json
├── pair_0002.hc
└── report.json        ← rapport du batch

audios/
└── video_0001/
    └── audio.wav
```

---

## 3.4 Format du fichier batch

Créer un fichier `urls.txt` :

```
# Format : URL | Sujet | Niveau
https://youtube.com/watch?v=aaa | Les Dérivées | Terminale
https://youtube.com/watch?v=bbb | Équation 2nd degré | Seconde
https://youtube.com/watch?v=ccc | Trigonométrie | Première
https://youtube.com/watch?v=ddd | Les Intégrales | Terminale
https://youtube.com/watch?v=eee | Vecteurs | Première
```

Lancement :

```bash
export ANTHROPIC_API_KEY="sk-ant-..."
python pipeline.py --batch urls.txt
```

---

## 3.5 Objectifs quantitatifs du dataset

| Taille | Qualité attendue de Gemma 4 |
|--------|----------------------------|
| 50 paires | Commence à comprendre la structure |
| 200 paires | Génère des scripts syntaxiquement corrects |
| 500 paires | Synchronisation précise avec le transcript |
| 1000+ paires | Précision chirurgicale — qualité professeur |

---

## 3.6 Chaînes YouTube recommandées

**Mathématiques en français :**
- Yvan Monka — lycée, très structuré
- Maths Adultes — progression claire
- Le Prof de Prépas — niveau avancé
- Maths & Tiques — collège/lycée

**Mathématiques en arabe (contexte Maroc) :**
- De nombreux enseignants marocains publient des cours complets sur YouTube, idéaux pour enrichir le dataset avec une dimension multilingue.

---

## 3.7 Fine-tuning Gemma 4

Une fois le dataset constitué, le fine-tuning se fait avec **Unsloth + LoRA** sur Kaggle (GPU gratuit).

**Format d'entraînement (Gemma chat template) :**

```
<start_of_turn>user
Tu es ILLIMMI Layer 3, expert en appuis visuels pédagogiques Hypercourse.

SUJET : Les Dérivées
NIVEAU : Terminale
DURÉE : 87.3s

TRANSCRIPT TIMESTAMPÉ :
[0.5s] Bonjour aujourd'hui nous allons étudier les dérivées
[5.2s] La dérivée mesure la pente de la tangente en un point
...

Génère les appuis visuels Hypercourse.
<end_of_turn>
<start_of_turn>model
text id 1 start 1.5s at (88.89, 8) ''[bold]Les Dérivées[/bold]'' ;
draw 2drep id 101 start 12.5s at (88.89, 55) scale=1.5 ;
draw 2dfunc id 102 start 14.2s color (41,128,185,1) at 101 y = x^2 ;
...
<end_of_turn>
```

**Hyperparamètres recommandés :**

| Paramètre | Valeur |
|-----------|--------|
| Base model | `google/gemma-4-4b-it` |
| Méthode | LoRA |
| Rank (r) | 16 |
| Alpha | 32 |
| Epochs | 3–5 |
| Learning rate | 2e-4 |
| Batch size | 4 |
| Outil | Unsloth |

---

*Documentation ILLIMMI — Version 1.0*