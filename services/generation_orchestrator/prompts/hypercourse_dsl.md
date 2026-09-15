# Spécification du DSL Hypercourse (`.hc`)

## 1. Vue d'ensemble & Philosophie
Hypercourse (`.hc`) est un DSL (Domain Specific Language) déclaratif et déterministe conçu pour synchroniser des appuis visuels (textes, formules LaTeX, figures géométriques, tracés de fonctions, curseur de tableau) avec un fichier audio de narration.

### Propriétés clés
- **Orientation temporelle** : Chaque élément visuel est positionné dans le temps au moyen d'un timestamp de début (`start`) et d'une durée d'animation de son dessin (`for`), et disparaît du tableau une fois effacé par la commande (`erase`).
- **Coordonnées normalisées 16:9** : L'espace de travail est indépendant de la résolution de l'écran.
- **Transparence et Légèreté** : Un cours complet de plusieurs minutes tient dans un fichier texte de quelques Ko.

---

## 2. Système de coordonnées & Espace de travail
Le tableau blanc utilise un repère cartésien avec l'origine `(0, 0)` en haut à gauche et un ratio 16:9 :

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
| Centre pédagogique | `(84.0, 55.0)` |

---

## 3. Définition des plages d'ID (Espaces de noms)
Chaque élément possède un identifiant numérique unique (`id`). La famille d'un élément est déduite automatiquement selon la valeur du paramètre `idgap` (valeur par défaut recommandée : `100`) :

| Famille d'élément | Plage d'ID (`idgap = 100`) | Formule générale |
| :--- | :--- | :--- |
| `text` | `1 – 100` | $1 \le \text{id} \le \text{idgap}$ |
| `draw` | `101 – 200` | $\text{idgap} + 1 \le \text{id} \le 2 \times \text{idgap}$ |
| `speech` *(legacy)* | `201 – 300` | $2 \times \text{idgap} + 1 \le \text{id} \le 3 \times \text{idgap}$ |
| `mouse` | `301 – 400` | $3 \times \text{idgap} + 1 \le \text{id} \le 4 \times \text{idgap}$ |
| `erase` | `401 – 500` | $4 \times \text{idgap} + 1 \le \text{id} \le 5 \times \text{idgap}$ |

---

## 4. Formatage du texte & LaTeX
Le contenu textuel est encadré par des doubles apostrophes `''` :

| Syntaxe | Description | Résultat |
| :--- | :--- | :--- |
| `''texte''` | Texte brut standard | Texte normal |
| `''[bold]texte[/bold]''` | Balise gras | **Texte en gras** |
| `''[italic]texte[/italic]''` | Balise italique | *Texte en italique* |
| `''[color=#2980B9]texte[/color]''` | Balise couleur hexadécimale | Texte coloré |
| `''[font=Courier]texte[/font]''` | Balise typographie | Police spécifique |
| `''$E=mc^2$''` | Formule LaTeX inline (dans le texte) | Formule mathématique inline |
| `''$$\int_0^\infty e^{-x}dx$$''` | Formule LaTeX display (centrée / mise en valeur) | Équation mathématique display |

> *Note : Les balises peuvent être imbriquées, ex : `''[bold][color=#27AE60]Théorème[/color][/bold]''`.*

---

## 5. Paramètres Communs (Partagés par plusieurs commandes)
Ces paramètres partagent une sémantique et une syntaxe identiques lorsqu'ils apparaissent dans les commandes :

| Paramètre commun | Syntaxe | Obligatoire / Optionnel | Description & Règle d'usage |
| :--- | :--- | :--- | :--- |
| **Identifiant** | `id <n>` | **Obligatoire** | Entier unique identifiant l'élément visuel. Doit respecter la plage d'ID définie par `idgap`. |
| **Début temporel** | `start <t>s` | **Obligatoire** | Timestamp exact (en secondes avec suffixe `s`, ex: `start 2.5s`) auquel l'élément commence à être dessiné ou exécuté. |
| **Durée d'animation** | `for <d>s` | **Optionnel** *(sauf `mouse move`)* | Durée d'animation (en secondes avec suffixe `s`, ex: `for 1.5s`) pour l'apparition progressive du tracé. Si omis, l'élément apparaît instantanément à `start`. |
| **Couleur de trait** | `color (<r>, <g>, <b>, <a>)` | **Optionnel** | Couleur du contour / trait au format RGBA (`r, g, b` : 0 à 255, `a` : 0.0 à 1.0). Ex: `color (41, 128, 185, 1)`. |
| **Épaisseur de trait** | `width <w>` | **Optionnel / Dépend commande** | Épaisseur du tracé en unités de rendu (valeur numérique, ex: `width 2` ou `width 3.5`). |
| **Couleur de remplissage**| `fillcolor (<r>, <g>, <b>, <a>)` | **Optionnel** | Couleur de remplissage intérieur pour les formes fermées ou semi-fermées (`circle`, `ellipse`, `arc`, `elliptic_arc`, `polygone`). |

---

## 6. Syntaxe des Commandes & Paramètres Spécifiques (Cas Particuliers)

### 6.1 `text` — Affichage de texte ou formules LaTeX
Affiche un titre, une définition, une formule LaTeX ou une explication au tableau.

```hypercourse
text id <ID> start <TIME>s [for <DURATION>s] at (<X>, <Y>) ''<CONTENU>'' ;
```

- **Paramètres communs :** `id`, `start`, `for` (optionnel).
- **Paramètres spécifiques (Cas particuliers) :**
  - `at (<X>, <Y>)` : Coordonnées du point d'ancrage où est positionné le texte sur le tableau blanc 16:9.
  - `''<CONTENU>''` : Chaîne de texte délimitée par `''`, contenant du texte brut, des balises de style BBCode (`[bold]`, `[color=...]`) et/ou des expressions LaTeX (`$...$` ou `$$...$$`).

**Exemples :**
```hypercourse
text id 1 start 1.5s for 30s at (88.89, 8) ''[bold][color=#2980B9]Les Dérivées[/color][/bold]'' ;
text id 2 start 12.0s at (88.89, 40) ''$$f'(x) = \lim_{h \to 0} \frac{f(x+h)-f(x)}{h}$$'' ;
```

---

### 6.2 `draw line` — Segment de droite
Trace un segment droit reliant deux points.

```hypercourse
draw line id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] width <w> at [(<x1>,<y1>), (<x2>,<y2>)] ;
```

- **Paramètres communs :** `id`, `start`, `for`, `color`, `width`.
- **Paramètres spécifiques (Cas particuliers) :**
  - `at [(<x1>,<y1>), (<x2>,<y2>)]` : Liste contenant **exactement 2 points**, le point de départ `(x1, y1)` et le point d'arrivée `(x2, y2)`.

**Exemple :**
```hypercourse
draw line id 101 start 4.0s for 1.2s color (52, 73, 94, 1) width 2 at [(20, 50), (150, 50)] ;
```

---

### 6.3 `draw arrow` — Flèche rectiligne
Trace une flèche orientée pour pointer ou relier deux éléments.

```hypercourse
draw arrow id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] width <w> at [(<x1>,<y1>), (<x2>,<y2>)] ;
```

- **Paramètres communs :** `id`, `start`, `for`, `color`, `width`.
- **Paramètres spécifiques (Cas particuliers) :**
  - `at [(<x1>,<y1>), (<x2>,<y2>)]` : Exactement 2 points : l'origine `(x1, y1)` et la destination `(x2, y2)` où sera placée la pointe de la flèche.

**Exemple :**
```hypercourse
draw arrow id 102 start 6.5s for 0.8s color (231, 76, 60, 1) width 3 at [(40, 20), (70, 45)] ;
```

---

### 6.4 `draw path` — Ligne brisée (Polyligne)
Trace une suite continue de segments reliant plusieurs points.

```hypercourse
draw path id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] width <w> at [(<x1>,<y1>), (<x2>,<y2>), ...] ;
```

- **Paramètres communs :** `id`, `start`, `for`, `color`, `width`.
- **Paramètres spécifiques (Cas particuliers) :**
  - `at [(<x1>,<y1>), (<x2>,<y2>), ...]` : Liste de 2 ou plusieurs points reliés séquentiellement sans fermeture automatique.

**Exemple :**
```hypercourse
draw path id 103 start 8.0s for 2.0s color (39, 174, 96, 1) width 2 at [(20, 80), (50, 30), (80, 70), (110, 20)] ;
```

---

### 6.5 `draw curve` — Courbe lissée ou Bézier
Trace une courbe fluide passant par des points ou contrôlée par des points Bézier.

```hypercourse
draw curve id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] width <w> [smooth|bezier] at [(<x1>,<y1>), (<x2>,<y2>), ...] [with <+/->arrow at end] ;
```

- **Paramètres communs :** `id`, `start`, `for`, `color`, `width`.
- **Paramètres spécifiques (Cas particuliers) :**
  - `[smooth|bezier]` *(optionnel)* : Mode d'interpolation de la courbe (`smooth` = interpolation lissée naturelle par défaut, `bezier` = courbe de Bézier).
  - `at [(<x1>,<y1>), ...]` : Points de passage ou points de contrôle de la courbe.
  - `[with <+/->arrow at end]` *(optionnel)* : Ajoute une pointe de flèche à l'extrémité finale de la courbe (`+arrow` = sens trigonométrique / direct, `-arrow` = sens horaire).

**Exemple :**
```hypercourse
draw curve id 104 start 10.0s for 1.5s color (142, 68, 173, 1) width 2.5 smooth at [(30, 60), (70, 20), (120, 60)] with +arrow at end ;
```

---

### 6.6 `draw circle` — Cercle
Dessine un cercle plein ou contourné.

```hypercourse
draw circle id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] [width <w>] [fillcolor (<r>,<g>,<b>,<a>)] radius <r> at (<cx>, <cy>) [with <+/->arrow on <angle>deg] ;
```

- **Paramètres communs :** `id`, `start`, `for`, `color`, `width`, `fillcolor`.
- **Paramètres spécifiques (Cas particuliers) :**
  - `radius <r>` : Rayon du cercle en unités du repère 16:9.
  - `at (<cx>, <cy>)` : Coordonnées du centre du cercle.
  - `[with <+/->arrow on <angle>deg]` *(optionnel)* : Dessine une flèche directionnelle sur la circonférence du cercle à l'angle spécifié (`+arrow` sens trigo, `-arrow` sens horaire).

**Exemples :**
```hypercourse
draw circle id 105 start 12.0s for 1.5s color (41, 128, 185, 1) width 3 fillcolor (41, 128, 185, 0.2) radius 18 at (88.89, 50) ;
draw circle id 106 start 14.0s for 1.0s color (231, 76, 60, 1) width 2 radius 15 at (50, 50) with +arrow on 90deg ;
```

---

### 6.7 `draw ellipse` — Ellipse
Dessine une ellipse avec éventuelle rotation.

```hypercourse
draw ellipse id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] [width <w>] [fillcolor (<r>,<g>,<b>,<a>)] radiusX <rx> radiusY <ry> [rotation <angle>] at (<cx>, <cy>) [with <+/->arrow on <angle>deg] ;
```

- **Paramètres communs :** `id`, `start`, `for`, `color`, `width`, `fillcolor`.
- **Paramètres spécifiques (Cas particuliers) :**
  - `radiusX <rx>` : Demi-grand axe horizontal (avant rotation).
  - `radiusY <ry>` : Demi-petit axe vertical (avant rotation).
  - `[rotation <angle>]` *(optionnel)* : Angle de rotation en degrés de l'ellipse autour de son centre (défaut : 0).
  - `at (<cx>, <cy>)` : Centre de l'ellipse.
  - `[with <+/->arrow on <angle>deg]` *(optionnel)* : Flèche positionnée sur le pourtour.

**Exemple :**
```hypercourse
draw ellipse id 107 start 16.0s for 2.0s color (243, 156, 18, 1) width 2 fillcolor (243, 156, 18, 0.15) radiusX 25 radiusY 12 rotation 30 at (88.89, 50) ;
```

---

### 6.8 `draw arc` — Arc de cercle
Dessine une portion angulaire de cercle.

```hypercourse
draw arc id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] [width <w>] [fillcolor (<r>,<g>,<b>,<a>)] radius <r> at (<cx>, <cy>) from <début>deg to <fin>deg [with <+/->arrow at end] ;
```

- **Paramètres communs :** `id`, `start`, `for`, `color`, `width`, `fillcolor`.
- **Paramètres spécifiques (Cas particuliers) :**
  - `radius <r>` : Rayon de l'arc.
  - `at (<cx>, <cy>)` : Centre du cercle porteur.
  - `from <début>deg to <fin>deg` : Angle de départ et angle d'arrivée en degrés (0° correspond à l'axe horizontal droit / 3 heures).
  - `[with <+/->arrow at end]` *(optionnel)* : Ajoute une pointe de flèche à l'angle final de l'arc.

**Exemple :**
```hypercourse
draw arc id 108 start 18.5s for 1.0s color (41, 128, 185, 1) width 3 radius 10 at (60, 50) from 0deg to 120deg with +arrow at end ;
```

---

### 6.9 `draw elliptic_arc` — Arc elliptique
Dessine une portion angulaire d'ellipse.

```hypercourse
draw elliptic_arc id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] [width <w>] [fillcolor (<r>,<g>,<b>,<a>)] radiusX <rx> radiusY <ry> [rotation <angle>] at (<cx>, <cy>) from <début>deg to <fin>deg [with <+/->arrow at end] ;
```

- **Paramètres communs :** `id`, `start`, `for`, `color`, `width`, `fillcolor`.
- **Paramètres spécifiques (Cas particuliers) :**
  - `radiusX <rx>`, `radiusY <ry>` : Demi-axes de l'ellipse.
  - `[rotation <angle>]` *(optionnel)* : Angle de rotation global de l'ellipse en degrés.
  - `at (<cx>, <cy>)` : Centre de l'ellipse.
  - `from <début>deg to <fin>deg` : Plage angulaire de tracé de l'arc.
  - `[with <+/->arrow at end]` *(optionnel)* : Flèche directionnelle à la terminaison.

**Exemple :**
```hypercourse
draw elliptic_arc id 109 start 20.0s for 1.2s color (155, 89, 182, 1) width 2 radiusX 20 radiusY 10 rotation 15 at (80, 50) from 30deg to 180deg with +arrow at end ;
```

---

### 6.10 `draw polygone` — Polygone
Dessine une forme géométrique polygonale fermée (triangle, quadrilatère, polygone quelconque).

```hypercourse
draw polygone id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] [width <w>] [fillcolor (<r>,<g>,<b>,<a>)] at [(<x1>,<y1>), (<x2>,<y2>), ...] ;
```

- **Paramètres communs :** `id`, `start`, `for`, `color`, `width`, `fillcolor`.
- **Paramètres spécifiques (Cas particuliers) :**
  - `at [(<x1>,<y1>), (<x2>,<y2>), ...]` : Liste des sommets ordonnés du polygone. La fermeture entre le dernier point et le premier est **automatique**.

**Exemple :**
```hypercourse
draw polygone id 110 start 22.0s for 1.5s color (230, 126, 34, 1) width 2 fillcolor (230, 126, 34, 0.25) at [(50, 70), (80, 30), (110, 70)] ;
```

---

### 6.11 `draw 2drep` — Repère cartésien 2D
Crée un repère orthonormal ou orthonormé avec axes gradués et origines pour y tracer des fonctions mathématiques.

```hypercourse
draw 2drep id <n> start <t>s [for <d>s] at (<x>, <y>) [color (<r>,<g>,<b>,<a>)] [width <w>] [scale = <facteur>] [x_range = [xmin, xmax]] [y_range = [ymin, ymax]] ;
```

- **Paramètres communs :** `id`, `start`, `for`, `color`, `width`.
- **Paramètres spécifiques (Cas particuliers) :**
  - `at (<x>, <y>)` : Position de l'origine $(0, 0)$ du repère dans les coordonnées 16:9 du tableau (valeur par défaut : `(88.89, 50)`).
  - `scale = <facteur>` : **Facteur d'échelle / zoom** des unités mathématiques sur l'écran (défaut : `1.0`).
    > *Important : Le paramètre `scale` contrôle la taille physique d'une unité mathématique sur le tableau blanc.*
  - `x_range = [xmin, xmax]` : Bornes de visibilité de l'axe horizontal (défaut : `[-10, 10]`).
  - `y_range = [ymin, ymax]` : Bornes de visibilité de l'axe vertical (défaut : `[-10, 10]`).

**Exemple :**
```hypercourse
draw 2drep id 101 start 8.0s for 1.0s at (88.89, 55) scale = 1.5 x_range = [-5, 5] y_range = [-2, 8] ;
```

---

### 6.12 `draw 2dfunc` — Tracé de fonction mathématique
Trace une courbe analytique $y = f(x)$ attachée dynamiquement à un repère `2drep`.

```hypercourse
draw 2dfunc id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] [width <w>] at <id_du_repere> y = <expression> ;
```

- **Paramètres communs :** `id`, `start`, `for`, `color`, `width`.
- **Paramètres spécifiques (Cas particuliers) :**
  - `at <id_du_repere>` : Identifiant numérique (`id`) du `2drep` auquel cette courbe est rattachée (la courbe s'adapte automatiquement à son origine, son échelle et ses axes).
  - `y = <expression>` : Expression mathématique analytique en fonction de la variable `x`.
    - **Opérateurs supportés :** `+`, `-`, `*`, `/`, `^`
    - **Fonctions supportées :** `sin`, `cos`, `tan`, `exp`, `log`, `sqrt`, `abs`
    - **Constantes supportées :** `pi`, `e`
    - **Variable :** `x`

**Exemples :**
```hypercourse
draw 2dfunc id 102 start 10.0s for 2.0s color (41, 128, 185, 1) width 2.5 at 101 y = x^2 ;
draw 2dfunc id 103 start 13.0s for 2.0s color (231, 76, 60, 1) width 2 at 101 y = sin(x) ;
draw 2dfunc id 104 start 16.0s for 2.0s color (39, 174, 96, 1) width 2 at 101 y = exp(-x^2 / 2) ;
```

---

### 6.13 `mouse move` — Animation du curseur / pointeur
Anime le curseur virtuel du professeur pour pointer, surligner ou guider le regard de l'apprenant.

```hypercourse
mouse move id <ID> start <TIME>s for <DURATION>s at [(X1, Y1), (X2, Y2), ...] ;
```

- **Paramètres communs :** `id`, `start`.
- **Paramètres spécifiques (Cas particuliers) :**
  - `for <DURATION>s` : **Obligatoire ici** — définit la durée exacte pendant laquelle le curseur parcourt la trajectoire.
  - `at [(X1, Y1), (X2, Y2), ...]` : Trajectoire du curseur définie par une suite de coordonnées ordonnées sur le tableau blanc.

**Exemple :**
```hypercourse
# Le curseur souligne une formule horizontale entre 15.5s et 17.5s
mouse move id 301 start 15.5s for 2.0s at [(55, 45), (135, 45)] ;
```

---

### 6.14 `erase` — Effacement d'éléments
Nettoie le tableau en faisant disparaître un groupe d'éléments visuels lors d'un changement de section ou de concept.

```hypercourse
erase id <ID> start <TIME>s [for <DURATION>s] at [<ID_1>, <ID_2>, ...] ;
```

- **Paramètres communs :** `id`, `start`, `for` (optionnel, durée de transition d'effacement).
- **Paramètres spécifiques (Cas particuliers) :**
  - `at [<ID_1>, <ID_2>, ...]` : Liste des identifiants (`id`) des éléments à effacer.
    > *Règle critique : Les IDs listés dans `at [...]` doivent être des éléments actuellement présents et visibles sur le tableau.*

**Exemple :**
```hypercourse
erase id 401 start 35.0s for 0.5s at [1, 2, 101, 102] ;
```

---

## 7. Structure d'un cours complet & Intégration
La pipeline backend englobe automatiquement les commandes générées dans le header de cours :
```hypercourse
course "Titre du cours" id <courseid> idgap <idgap> for <durée>s audio "<audio.wav>" {
    # visualText : Vos commandes text, draw, mouse, erase viennent ici
}
```

Le modèle LLM génère uniquement le bloc de commandes `visualsText` avec la valeur `idgap` choisie.
