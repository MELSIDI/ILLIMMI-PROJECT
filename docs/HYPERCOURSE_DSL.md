# Spécification du DSL Hypercourse (`.hc`)

> **Spécification officielle et complète du langage de description de cours animés ILLIMMI.**

---

## 1. Vue d'ensemble & Philosophie

Hypercourse (`.hc`) est un DSL (Domain Specific Language) déclaratif et déterministe conçu pour synchroniser des appuis visuels (textes, formules LaTeX, figures géométriques, tracés de fonctions, curseur de tableau) avec un fichier audio de narration.

### Propriétés clés
- **Orientation temporelle** : Chaque élément visuel est positionné dans le temps au moyen d'un timestamp de début (`start`) et d'une durée d'animation de son dessin (`for`) et disparrait du tableau une fois effacer par la commande (`erase`).
- **Coordonnées normalisées 16:9** : L'espace de travail est indépendant de la résolution de l'écran.
- **Transparence et Légèreté** : Un cours complet de plusieurs minutes tient dans un fichier texte de quelques Ko.

---

## 2. Système de coordonnées & Espace de travail

Le tableau blanc utilise un repère cartésien à origine en haut à gauche avec un ratio **16:9** :

```
(0, 0) ────────────────────────────────────────── (177.78, 0)
  │                                                     │
  │                  (88.89, 50)                        │
  │              [Centre du Tableau]                    │
  │                                                     │
  │                  (84.0, 55.0)                       │
  │             [Centre Pédagogique]                    │
  │                                                     │
(0, 100) ──────────────────────────────────────── (177.78, 100)
```

| Point remarquable | Coordonnées `(x, y)` |
| :--- | :--- |
| Coin supérieur gauche | `(0, 0)` |
| Coin supérieur droit | `(177.78, 0)` |
| Coin inférieur gauche | `(0, 100)` |
| Coin inférieur droit | `(177.78, 100)` |
| Centre géométrique | `(88.89, 50)` |

---

## 3. Gestion du temps
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


## 4. Définition des plages d'ID (Espaces de noms)

Chaque élément possède un identifiant numérique unique (`id`). La famille d'un élément est déduite automatiquement selon la valeur du paramètre `idgap` (valeur par défaut recommandée : `100`) :

| Famille d'élément | Plage d'ID (`idgap = 100`) | Formule générale |
| :--- | :--- | :--- |
| `text` | `1 – 100` | $1 \le \text{id} \le \text{idgap}$ |
| `draw` | `101 – 200` | $\text{idgap} + 1 \le \text{id} \le 2 \times \text{idgap}$ |
| `speech` *(legacy)* | `201 – 300` | $2 \times \text{idgap} + 1 \le \text{id} \le 3 \times \text{idgap}$ |
| `mouse` | `301 – 400` | $3 \times \text{idgap} + 1 \le \text{id} \le 4 \times \text{idgap}$ |
| `erase` | `401 – 500` | $4 \times \text{idgap} + 1 \le \text{id} \le 5 \times \text{idgap}$ |

---

## 5. Couleurs
Format RGBA : `color (R, G, B, A)`

```hypercourse
color (255, 0, 0, 1)          # Rouge opaque
color (0, 100, 255, 0.5)      # Bleu semi-transparent
fillcolor (200, 200, 0, 0.3)  # Remplissage jaune translucide
```

- **R, G, B** : 0–255
- **A** : 0.0–1.0

---

# 6 Formatage de texte

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

# 7 Structure d'un cours

```hypercourse
course "Titre du cours" id <courseid> idgap <idgap> for <durée>s audio "<fichier.wav>" {

    # Appuis visuels — l'audio joue en fond
    text id 1 start 1.5s at (88.89, 8) ''[bold]Titre[/bold]'' ;
    draw circle id 101 start 5.2s ... ;
    # et ça continue...
}
```

**Paramètres du header :**

| Paramètre | Description |
|-----------|-------------|
| `id` | Identifiant unique du cours |
| `idgap` | Taille des plages d'IDs (exemple : 100) |
| `for` | Durée totale = durée exacte de l'audio `.wav` |
| `audio` | Chemin vers le fichier audio (`.wav`, `.mp3`, ...) — seule source de narration |

---

## 8 Syntaxe de référence des commandes

### 8.1 `text` - Affichage de texte ou formule LaTeX
```hypercourse
text id <ID> start <TIME>s [for <DURATION>s] at (<X>, <Y>) ''<CONTENU>'' ;
```

**Exemple :**
```hypercourse
text id 1 start 1.5s for 30s at (88.89, 8)
     ''[bold][color=#2980B9]Les Dérivées[/color][/bold]'' ;

text id 2 start 12s at (88.89, 40)
     ''$$f'(x) = \lim_{h \to 0} \frac{f(x+h)-f(x)}{h}$$'' ;
```

---


### 4.3 `draw` - Formes géométriques & Figures

#### 4.3.1 `draw line` - Ligne droite
```hypercourse
draw line id <n> start <t>s [for <d>s]
          [color (<r>,<g>,<b>,<a>)] width <w>
          at [(<x1>,<y1>), (<x2>,<y2>)] ;
```

#### 4.3.2 `draw arrow` - Flèche
```hypercourse
draw arrow id <n> start <t>s [for <d>s]
           [color (<r>,<g>,<b>,<a>)] width <w>
           at [(<x1>,<y1>), (<x2>,<y2>)] ;
```

#### 4.3.3 `draw path` - Ligne brisée
```hypercourse
draw path id <n> start <t>s [for <d>s]
          [color (<r>,<g>,<b>,<a>)] width <w>
          at [(<x1>,<y1>), (<x2>,<y2>), ...] ;
```

#### 4.3.4 `draw curve` - Courbe lissée
```hypercourse
draw curve id <n> start <t>s [for <d>s]
           [color (<r>,<g>,<b>,<a>)] width <w>
           [option]
           at [points]
           [with <+/->arrow at end] ;
```
Options :
- `smooth` : lissage naturel (défaut)
- `bezier` : courbe de Bézier
- `+arrow` : flèche dans le sens trigonométrique
- `-arrow` : flèche dans le sens horaire

#### 4.3.5 `draw circle` - Cercle

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

draw circle id 101 start 5.2s for 2s
            color (41, 128, 185, 1) width 3
            fillcolor (41, 128, 185, 0.15)
            radius 20 at (60, 70) 
            with +arrow at 90deg;
```

#### 4.3.6 `draw ellipse` - Ellipse

```hypercourse
draw ellipse id <n> start <t>s [for <d>s]
             [color (<r>,<g>,<b>,<a>)] [width <w>]
             [fillcolor (<r>,<g>,<b>,<a>)]
             radiusX <rx> radiusY <ry>
             [rotation <angle>]
             at (<cx>, <cy>)
             [with <+/->arrow on <angle>deg] ;
```

#### 4.3.7 `draw arc` - Arc de cercle

```hypercourse
draw arc id <n> start <t>s [for <d>s]
         [color (<r>,<g>,<b>,<a>)] [width <w>]
         [fillcolor (<r>,<g>,<b>,<a>)]
         radius <r> at (<cx>, <cy>)
         from <début>deg to <fin>deg
         [with <+/->arrow at end] ;
```

#### 4.3.8 `draw elliptic_arc` - Arc elliptique

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

#### 4.3.9 `draw polygone` - Polygone

```hypercourse
draw polygone id <n> start <t>s [for <d>s]
              [color (<r>,<g>,<b>,<a>)] [width <w>]
              [fillcolor (<r>,<g>,<b>,<a>)]
              at [(<x1>,<y1>), (<x2>,<y2>), ...] ;
```

#### 4.3.10 `draw 2drep` - Repère cartésien

```hypercourse
draw 2drep id <n> start <t>s [for <d>s]
           at (<x>, <y>)
           [color (<r>,<g>,<b>,<a>)] [width <w>]
           [scale = <facteur>]
           [grid = true|false]
           [grid_alpha = <0.0..1.0>]
           [step = <pas>]
           [show_labels = true|false]
           [x_range = [xmin, xmax]]
           [y_range = [ymin, ymax]] ;
```

**Paramètres et options :**
- `at (<x>, <y>)` : Centre du repère (intersection des axes $x=0, y=0$). L'agent place convenablement l'origine dans la zone droite ($X \in [92, 173], Y \in [18, 92]$) selon les quadrants utiles (ex: centré `at (133, 55)` pour domaines symétriques, ou en bas à gauche ex: `at (104, 84)` pour un domaine positif $[0, 10] \times [0, 10]$). Formule de centrage : $cx \approx 133 - x_{mid} \times scale$, $cy \approx 55 + y_{mid} \times scale$.
- `scale = <facteur>` : Facteur d'échelle (unités canvas par unité mathématique).
- `grid = true|false` : Active la grille cartésienne d'arrière-plan (tracée avec la couleur du repère, trait fin et opacité allégée).
- `grid_alpha = <alpha>` : Opacité de la grille (défaut : `0.7`).
- `step = <pas>` (ou `graduation = <pas>`) : Pas de graduation sur les axes et espacement de la grille (défaut : `1.0`).
- `show_labels = true|false` : Affiche les valeurs numériques sur les graduations.
- `x_range = [xmin, xmax]` : Bornes de l'axe des abscisses (défaut : `[-10, 10]`).
- `y_range = [ymin, ymax]` : Bornes de l'axe des ordonnées (défaut : `[-10, 10]`).

**Règle d'or de dimensionnement de `scale` (Vérification World Model) :**
Sur le canevas 16:9 ($177.78 \times 100$), pour une occupation optimale de la colonne droite ($x \in [95, 170]$, largeur cible $\approx 50$ à $60$) :
$$\text{scale} \approx \frac{52}{x_{max} - x_{min}}$$

| Plage mathématique $x$ | Amplitude $\Delta x$ | `scale` recommandé | Largeur écran résultante |
|---|---|---|---|
| $[-3 ; 3]$ | $6$ | `7.0` à `8.5` | $42$ à $51$ u |
| $[-4 ; 4]$ | $8$ | `6.0` à `6.5` | $48$ à $52$ u |
| $[-5 ; 5]$ | $10$ | `5.0` à `5.5` | $50$ à $55$ u |
| $[-2 ; 6]$ | $8$ | `6.0` à `6.5` | $48$ à $52$ u |
| $[-10 ; 10]$ | $20$ | `2.5` à `3.0` | $50$ à $60$ u |

> [!WARNING]
> Si `scale` est trop faible (ex: `scale = 1.0` sur $[-4, 4]$), le repère ne mesurera que 8 unités de large (microscopique et illisible). Le World Model Verifier rejettera automatiquement le script (`scale_errors`).

**Exemple recommandé :**
```hypercourse
draw 2drep id 101 start 8s for 20s
           at (132, 56)
           color (248, 250, 252, 0.95) width 1.5
           scale = 6.5
           grid = true grid_alpha = 0.7 step = 1
           x_range = [-4, 4]
           y_range = [-2, 6] ;
```

---

#### 4.3.11 `draw 2dfunc` - Fonction mathématique

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

### 4.4 `mouse move` - Animation du curseur
Simule le déplacement du curseur du professeur pour souligner ou pointer un élément sur le tableau.
```hypercourse
mouse move id <ID> start <TIME>s for <DURATION>s at [(X1, Y1), (X2, Y2), ...] ;
```

**Exemple :**
```hypercourse
# Le curseur souligne une formule en 2 secondes
mouse move id 301 start 15.5s for 2s
           at [(55, 45), (135, 45)] ;
```

---

### 4.5 `erase` - Effacement
Efface une liste d'éléments actuellement visibles à l'écran pour nettoyer le tableau blanc avant une nouvelle section.

```hypercourse
erase id <ID> start <TIME>s [for <DURATION>s] at [<ID_1>, <ID_2>, ...] ;
```
**Règle critique :** les IDs référencés dans `at [...]` doivent être des éléments actuellement visibles à l'écran.

**Exemple :**
```hypercourse
erase id 401 start 25.0s for 0.5s at [1, 2, 101, 102] ;
```

---

### 4.6 `plot` - Composant interactif Python
Intègre un graphique Python/Matplotlib/Plotly complexe calculé via `plot-service`.
```hypercourse
plot id <ID> start <TIME>s at (<X>, <Y>) width <W> height <H> ''<CODE_PYTHON>'' ;

```

## 5. Exemple complet

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
