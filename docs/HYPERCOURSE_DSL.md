# Spécification du DSL Hypercourse (`.hc`)

> **Spécification officielle et complète du langage de description de cours animés ILLIMMI.**

---

## 1. Vue d'ensemble & Philosophie

Hypercourse (`.hc`) est un DSL (Domain Specific Language) déclaratif et déterministe conçu pour synchroniser des appuis visuels (textes, formules LaTeX, figures géométriques, tracés de fonctions, curseur de tableau) avec un fichier audio de narration.

### Propriétés clés
- **Orientation temporelle** : Chaque élément visuel est positionné dans le temps au moyen d'un timestamp de début (`start`) et d'une durée d'animation (`for`).
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

## 4. Syntaxe de référence des commandes

### 4.1 En-tête de cours
Définit le nom du cours et le fichier audio associé :
```hypercourse
course "Les Dérivées et Tangentes" ;
audio "audios/les_derivees/narration.wav" ;
```

---

### 4.2 Commande `text` (Texte et LaTeX)
Affiche un texte ou une formule mathématique LaTeX.
```hypercourse
text id <ID> start <TIME>s [for <DURATION>s] at (<X>, <Y>) ''<CONTENU>'' ;
```
- **Formattage inline** : `[bold]...[/bold]`, `[italic]...[/italic]`, `[color=#RRGGBB]...[/color]`
- **Formules LaTeX** : Inline `$...$` ou Display `$$...$$` (rendues via KaTeX / `flutter_math_fork`).

**Exemple :**
```hypercourse
text id 1 start 1.5s for 1.0s at (88.89, 10.0) ''[bold]1. Définition de la dérivée[/bold]'' ;
text id 2 start 4.0s for 2.0s at (20.0, 30.0) ''La limite est : $f'(a) = \lim_{h \to 0} \frac{f(a+h) - f(a)}{h}$'' ;
```

---

### 4.3 Commandes `draw` (Formes géométriques & Figures)

#### Line / Arrow (Ligne et Flèche)
```hypercourse
draw line id <ID> start <TIME>s [for <DURATION>s] [color (R, G, B, A)] width <W> at [(X1, Y1), (X2, Y2)] ;
```
- **Flèche** : Si l'ID ou le drapeau indique un mode flèche, une pointe de flèche orientée est dessinée à l'extrémité.

#### Circle (Cercle)
```hypercourse
draw circle id <ID> start <TIME>s [for <DURATION>s] [color (...)] [width <W>] [fillcolor (...)] radius <R> at (CX, CY) ;
```

#### Polygon (Polygone)
```hypercourse
draw polygone id <ID> start <TIME>s [for <DURATION>s] [color (...)] [width <W>] [fillcolor (...)] at [(X1, Y1), (X2, Y2), (X3, Y3)] ;
```

#### Ellipse & Arc
```hypercourse
draw ellipse id <ID> start <TIME>s [for <DURATION>s] [color (...)] [width <W>] radius_x <RX> radius_y <RY> rotation <ANGLE> at (CX, CY) ;
```

#### Repère 2D & Fonction 2D
```hypercourse
draw 2drep id 101 start 5.0s for 1.0s at (88.89, 60.0) scale = 1.0 x_range = [-5, 5] y_range = [-5, 5] ;
draw 2dfunc id 102 start 7.0s for 2.0s color (0, 150, 255, 1) width 2 at 101 y = x^2 - 2 ;
```

---

### 4.4 Commande `mouse` (Animation du curseur)
Simule le déplacement du curseur du professeur pour souligner ou pointer un élément sur le tableau.
```hypercourse
mouse move id <ID> start <TIME>s for <DURATION>s at [(X1, Y1), (X2, Y2), ...] ;
```

---

### 4.5 Commande `erase` (Effacement du tableau)
Efface une liste d'éléments actuellement visibles à l'écran pour nettoyer le tableau blanc avant une nouvelle section.
```hypercourse
erase id <ID> start <TIME>s [for <DURATION>s] at [<ID_1>, <ID_2>, ...] ;
```

**Exemple :**
```hypercourse
erase id 401 start 25.0s for 0.5s at [1, 2, 101, 102] ;
```

---

### 4.6 Commande `plot` (Composant interactif Python)
Intègre un graphique Python/Matplotlib/Plotly complexe calculé via `plot-service`.
```hypercourse
plot id <ID> start <TIME>s at (<X>, <Y>) width <W> height <H> ''<CODE_PYTHON>'' ;
```
