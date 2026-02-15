# Hypercourse DSL

> Un langage spécifique au domaine pour créer des leçons animées et interactives

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.0.0-green.svg)](CHANGELOG.md)
[![Dart](https://img.shields.io/badge/dart-3.0%2B-blue.svg)](https://dart.dev/)
[![Flutter](https://img.shields.io/badge/flutter-3.0%2B-blue.svg)](https://flutter.dev/)

##  Table des matières

- [Introduction](#-introduction)
- [Installation](#-installation)
- [Démarrage rapide](#-démarrage-rapide)
- [Concepts fondamentaux](#-concepts-fondamentaux)
- [Référence des commandes](#-référence-des-commandes)
- [Exemples](#-exemples)
- [Bonnes pratiques](#-bonnes-pratiques)
- [API](#-api)
- [Contribution](#-contribution)
- [Licence](#-licence)

---

##  Introduction

**Hypercourse** est un DSL (Domain-Specific Language) conçu pour orchestrer des présentations éducatives animées sur un tableau virtuel. Il permet   de décrire le deroulement du cours de manière déclarative et intuitive :

-  **Textes et formules LaTeX** avec animations d'écriture
-  **Formes géométriques** (lignes, cercles, polygones, courbes, ...)
-  **Graphiques mathématiques** avec repères cartésiens
-  **Narration vocale** synchronisée
-  **Animations de curseur** pour guider l'attention
-  **Séquencement temporel précis** au dixième de seconde

###  Caractéristiques principales

- **Syntaxe lisible** : Proche du langage naturel
- **Support LaTeX natif** : Formules mathématiques directement intégrées
- **Système de coordonnées normalisé** : Format 16:9 standard
- **Animation temporelle** : Contrôle précis du timing
- **Extensible** : Intégration Python pour graphiques complexes
- **Typage fort** : Détection d'erreurs à la compilation

---

##  Installation

### Prérequis

- Dart SDK 3.0+
- Flutter 3.0+
- (Optionnel) Python 3.8+ avec matplotlib pour les graphiques avancés

### Intégration dans un projet Flutter

```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  # Autres dépendances...
    cupertino_icons: ^1.0.8
    flutter_math_fork: ^0.7.4
    webview_flutter: ^4.13.0
    http: ^1.5.0
```

Copiez les fichiers suivants dans votre projet :

```
my_prof_app/
lib/
├── models/
|   ├── basic_elements/
|   |  ├── draw_element.dart
|   |  ├── erase_element.dart
|   |  ├── mouse_element.dart
|   |  ├── plot_element.dart
|   |  ├── speech_element.dart
|   |  └── text_element.dart
|   ├── draw_elements/
|   |  ├── arc_element.dart
|   |  ├── arrow_element.dart
|   |  ├── circle_element.dart
|   |  ├── curve_element.dart
|   |  ├── ellipse_element.dart
|   |  ├── elliptic_arc_element.dart
|   |  ├── function2d_element.dart
|   |  ├── line_element.dart
|   |  ├── path_element.dart
|   |  ├── polygon_element.dart
|   |  └── repere2d_element.dart
│   └── hyper_element.dart
├── parsers/
|   ├── command_parsers/
|   |  ├── command_parser_factory.dart
|   |  ├── command_parser_interface.dart
|   |  ├── draw_command_parser.dart
|   |  ├── erase_command_parser.dart
|   |  ├── mouse_command_parser.dart
|   |  ├── plot_command_parser.dart
|   |  ├── speech_command_parser.dart
|   |  └── text_command_parser.dart
|   ├── draw_parsers/
|   |  ├── arc_draw_parser.dart
|   |  ├── circle_draw_parser.dart
|   |  ├── curve_draw_parser.dart
|   |  ├── draw_parser_factory.dart
|   |  ├── draw_parser_interface.dart
|   |  ├── ellipse_draw_parser.dart
|   |  ├── elliptic_arc_draw_parser.dart
|   |  ├── function2d_draw_parser.dart
|   |  ├── line_draw_parser.dart
|   |  ├── path_draw_parser.dart
|   |  ├── polygon_draw_parser.dart
|   |  └── repere2d_draw_parser.dart
|   ├── tokenizer/
|   |  ├── token_types.dart
|   |  └── tokenizer.dart
│   ├── hypercourse_parser.dart
│   ├── hypercourse_timer.dart
|   └── parsing_utils.dart
├── board_painter/
|   ├── element_painters/
|   |  ├── arc_element_painter.dart
|   |  ├── circle_element_painter.dart
|   |  ├── curve_element_painter.dart
|   |  ├── element_painter_factory.dart
|   |  ├── element_painter_interface.dart
|   |  ├── ellipse_element_painter.dart
|   |  ├── elliptic_arc_element_painter.dart
|   |  ├── function2d_element_painter.dart
|   |  ├── line_element_painter.dart
|   |  ├── path_element_painter.dart
|   |  ├── polygon_element_painter.dart
|   |  └── repere2d_element_painter.dart
|   ├── helpers/
|   |  ├── arrow_head_painter.dart
|   |  ├── function_evaluator.dart
|   |  ├── grid_painter.dart
|   |  ├── path_animation.dart
|   |  └── text_pattern_finder.dart
│   ├── board_painter.dart
|   └── coordinate_system.dart
├── board_plotter/
|    └── plot_widget.dart
├── board_writter/
|    └── latex_widget.dart
├── player/
|    └── course_player.dart
└── main.dart
```

---

##  Démarrage rapide

### Votre première leçon

Créez un fichier `lesson.hypercourse` :

```hypercourse
course "Ma Première Leçon" id 1 idgap 7000 for 9s {
    # Afficher un titre
    text id 1 start 1s for 2s at (88.89, 20)  
         ''[bold]Bienvenue ![/bold]'' ;
    
    # Dessiner un cercle
    draw circle id 10 start 3s for 2s 
         color (255, 0, 0, 1) 
         width 3 
         radius 30 
         at (88.89, 50) ;
    
    # Ajouter une narration
    speech id 100 start 1s for 7s
        "Bienvenue dans votre première leçon interactive." ;
}
```

### Utilisation dans Flutter

```dart
import 'package:flutter/material.dart';
import 'parsers/hypercourse_parser.dart';
import 'renderers/hypercourse_renderer.dart';

class LessonPlayer extends StatelessWidget {
  final String script = '''
    course "Demo" {
      text id 1  start 1s at (88.89, 50) ''Hello World!'' ;
    }
  ''';

  @override
  Widget build(BuildContext context) {
    final parser = HypercourseParser(script);
    final elements = parser.parse();
    
    return HypercourseRenderer(elements: elements);
  }
}
```

---

##  Concepts fondamentaux

### Système de coordonnées

Le tableau blanc utilise un repère normalisé 16:9 :

```
(0, 0) ─────────────────────────── (177.78, 0)
   │                                     │
   │          (88.89, 50)                │
   │            [centre]                 │
   │                                     │
(0, 100) ───────────────────────── (177.78, 100)
```

**Points remarquables :**
- Centre : `(88.89, 50)`
- Coin supérieur gauche : `(0, 0)`
- Coin inférieur droit : `(177.78, 100)`

### Gestion du temps

Tous les événements sont temporisés en secondes :

```hypercourse
start 2.5s      # Démarre à 2,5 secondes
for 1.5s        # Durée d'animation de 1,5 seconde
```

**Règles :**
- Suffixe `s` obligatoire
- Décimales supportées
- `start` : moment d'apparition (obligatoire)
- `for` : durée d'animation (optionnel)

### Identifiants (ID)

Chaque élément nécessite un ID unique :

```hypercourse
id 1        # Identifiant unique (entier)
```

**Convention recommandée :**
- 1-9 : Titres et textes principaux
- 10-99 : Éléments géométriques
- 100-199 : Repères et fonctions
- 200-299 : Graphiques Python
- 500+ : Narration
- 600+ : Animations de curseur
- 900+ : Commandes d'effacement

### Couleurs

Format RGBA : `color (R, G, B, A)`

```hypercourse
color (255, 0, 0, 1)        # Rouge opaque
color (0, 100, 255, 0.5)    # Bleu semi-transparent
fillcolor (200, 200, 0, 0.3) # Remplissage jaune translucide
```

- **R, G, B** : 0-255
- **A** : 0.0-1.0 (transparence)

### Formatage de texte

Le contenu textuel est encadré par `''` et supporte :

| Syntaxe | Résultat | Exemple |
|---------|----------|---------|
| `''texte''` | Texte normal | `''Bonjour''` |
| `[bold]...[/bold]` | **Gras** | `''[bold]Important[/bold]''` |
| `[italic]...[/italic]` | *Italique* | `''[italic]Note[/italic]''` |
| `[color=#RRGGBB]...[/color]` | Couleur | `''[color=#FF0000]Rouge[/color]''` |
| `[font=Police]...[/font]` | Police | `''[font=Courier]Code[/font]''` |
| `$...$` | Math inline | `''La formule $E=mc^2$''` |
| `$$...$$` | Math display | `''$$\int_0^\infty e^{-x}dx$$''` |

**Imbrication possible :**
```hypercourse
''[bold][color=#00FF00]Texte vert en gras[/color][/bold]''
```

### Commentaires

```hypercourse
# Ceci est un commentaire
# Les commentaires sont ignorés par le parser
```

---

##  Référence des commandes

### Structure de base

```hypercourse
course "Titre de la leçon" {
    # Vos commandes ici...
}
```

###  Commande `text`

Affiche du texte ou des formules LaTeX.

```hypercourse
text id <id> start <time>s [for <duration>s] at (<x>, <y>)  ''<contenu>'' ;
```

**Exemple :**
```hypercourse
text id 1  start 1s for 2s at (88.89, 20) 
     ''$$\frac{-b \pm \sqrt{b^2-4ac}}{2a}$$'' ;
```

###  Commandes de dessin

#### Ligne droite

```hypercourse
draw line id <id> start <time>s [for <duration>s] 
          [color <rgba>] width <number> 
          at [(<x1>, <y1>), (<x2>, <y2>)] ;
```

#### Flèche

```hypercourse
draw arrow id <id> start <time>s [for <duration>s] 
           [color <rgba>] width <number> 
           at [(<x1>, <y1>), (<x2>, <y2>)] ;
```

#### Ligne brisée

```hypercourse
draw path id <id> start <time>s [for <duration>s] 
          [color <rgba>] width <number> 
          at [(<x1>, <y1>), (<x2>, <y2>), ...] ;
```

#### Courbe lissée

```hypercourse
draw curve id <id> start <time>s [for <duration>s] 
           [color <rgba>] width <number> 
           [smooth|bezier] 
           at [points] 
           [with <+/->arrow at end] ;
```

**Options :**
- `smooth` : Lissage naturel (défaut)
- `bezier` : Courbe de Bézier
- `+arrow` : Sens trigonométrique
- `-arrow` : Sens horaire

#### Polygone

```hypercourse
draw polygone id <id> start <time>s [for  <duration>s] 
              [color <rgba>] width <number> 
              [fillcolor <rgba>] 
              at [points] ;
```

#### Cercle

```hypercourse
draw circle id <id> start <time>s [for <duration>s] 
            [color <rgba>] width <number> 
            [fillcolor <rgba>] 
            radius <r> at (<cx>, <cy>) 
            [with <+/->arrow on <angle>deg] ;
```

#### Ellipse

```hypercourse
draw ellipse id <id> start <time>s [for <duration>s] 
             [color <rgba>] width <number> 
             [fillcolor <rgba>] 
             radiusX <rx> radiusY <ry> 
             [rotation <angle>] 
             at (<cx>, <cy>) 
             [with <+/->arrow on <angle>deg] ;
```

#### Arc de cercle

```hypercourse
draw arc id <id> start <time>s [for <duration>s] 
         [color <rgba>] width <number> 
         [fillcolor <rgba>] 
         radius <r> at (<cx>, <cy>) 
         from <start>deg to <end>deg 
         [with <+/->arrow at end] ;
```

#### Arc elliptique

```hypercourse
draw elliptic_arc id <id> start <time>s [for <duration>s] 
                  [color <rgba>] width <number> 
                  [fillcolor <rgba>] 
                  radiusX <rx> radiusY <ry> 
                  [rotation <angle>] 
                  at (<cx>, <cy>) 
                  from <start>deg to <end>deg 
                  [with <+/->arrow at end] ;
```

###  Graphiques mathématiques

#### Repère cartésien

```hypercourse
draw 2drep id <id> start <time>s [for <duration>s] 
           at (<x>, <y>) 
           [color <rgba>] [width <number>] 
           [scale <factor>] 
           [x_range = [xmin, xmax]] 
           [y_range = [ymin, ymax]] ;
```

**Paramètres par défaut :**
- Position : `(88.89, 50)` (centre)
- Scale : `1.0`
- x_range : `[-10, 10]`
- y_range : `[-10, 10]`

**Exemple :**
```hypercourse
draw 2drep id 100 start 1s 
           at (88.89, 50) 
           scale = 2 
           x_range = [-5, 5] 
           y_range = [-3, 3] ;
```

#### Fonction mathématique

```hypercourse
draw 2dfunc id <id> start <time>s [for <duration>s] 
            [color <rgba>] [width <number>] 
            at <repere_id> 
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
# Parabole
draw 2dfunc id 101 start 3s at 100 y = x^2 ;

# Sinusoïde
draw 2dfunc id 102 start 4s color (255, 0, 0, 1) at 100 y = sin(x) ;

# Gaussienne
draw 2dfunc id 103 start 5s at 100 y = exp(-x^2/2) ;

# Combinaison
draw 2dfunc id 104 start 6s at 100 y = sin(x) * exp(-x/5) ;
```

#### Graphique Python

Pour des graphiques complexes nécessitant matplotlib :

```hypercourse
plot id <id> start <time>s [for <duration>s] 
     at (<x>, <y>) 
     code python ''<script>'' ;
```

**Exemple :**
```hypercourse
plot id 200 start 8s at (88.89, 50) code python ''
import numpy as np
import matplotlib.pyplot as plt

x = np.linspace(-5, 5, 200)
y1 = np.sin(x)
y2 = np.cos(x)

plt.plot(x, y1, 'r-', label='sin(x)', linewidth=2)
plt.plot(x, y2, 'b--', label='cos(x)', linewidth=2)
plt.legend()
plt.grid(True, alpha=0.3)
plt.xlabel('x')
plt.ylabel('y')
'' ;
```

###  Effacement

```hypercourse
erase id <id> start <time>s [for <duration>s] 
      at [<id1>, <id2>, ...] ;
```

**Exemple :**
```hypercourse
# Efface les éléments 1, 10, 20 et 30
erase id 999 start 15s for 1s at [1, 10, 20, 30] ;
```

###  Narration vocale

```hypercourse
speech id <id> start <time>s [for <duration>s] "<texte>" ;
```

**Exemple :**
```hypercourse
speech id 500 start 3s "Bienvenue dans cette leçon sur les dérivées." ;
speech id 501 start 7s "Observons maintenant la courbe de la fonction." ;
```

###  Animation de curseur

```hypercourse
mouse move id <id> start <time>s for <duration>s 
           at [(<x1>, <y1>), (<x2>, <y2>), ...] ;
```

**Exemple :**
```hypercourse
# Curseur suivant un chemin en 3 secondes
mouse move id 600 start 5s for 3s 
           at [(20, 20), (88.89, 50), (150, 80)] ;
```

---

##  Exemples

### Exemple 1 : Théorème de Pythagore

```hypercourse
course "Théorème de Pythagore" {
    # Introduction
    text id 1 start 1s for 2s at (88.89, 10)
         ''[bold][color=#2C3E50]Théorème de Pythagore[/color][/bold]'' ;
    
    speech id 500 start 1s 
           "Découvrons ensemble le célèbre théorème de Pythagore." ;
    
    # Triangle rectangle
    draw polygone id 10 start 3s for 2s 
                  color (52, 152, 219, 1) 
                  width 3 
                  fillcolor (52, 152, 219, 0.2) 
                  at [(40, 70), (100, 70), (40, 30)] ;
    
    speech id 501 start 3s 
           "Voici un triangle rectangle." ;
    
    # Angles droits
    draw path id 11 start 5s 
              color (150, 150, 150, 1) 
              width 1.5 
              at [(40, 65), (45, 65), (45, 70)] ;
    
    # Labels des côtés
    text id 20 start 6s at (70, 75) ''$c$ (hypoténuse)'' ;
    text id 21 start 6s at (33, 50) ''$a$'' ;
    text id 22 start 6s at (105, 50) ''$b$'' ;
    
    # Carrés sur les côtés
    draw polygone id 30 start 8s for 1.5s 
                  color (231, 76, 60, 0.7) 
                  width 2 
                  fillcolor (231, 76, 60, 0.3) 
                  at [(40, 70), (40, 100), (10, 100), (10, 70)] ;
    
    draw polygone id 31 start 8s for 1.5s 
                  color (46, 204, 113, 0.7) 
                  width 2 
                  fillcolor (46, 204, 113, 0.3) 
                  at [(100, 70), (100, 100), (130, 100), (130, 70)] ;
    
    draw polygone id 32 start 8s for 1.5s 
                  color (155, 89, 182, 0.7) 
                  width 2 
                  fillcolor (155, 89, 182, 0.3) 
                  at [(40, 30), (40, 0), (70, 0), (70, 30)] ;
    
    speech id 502 start 8s 
           "Construisons un carré sur chaque côté du triangle." ;
    
    # Formule finale
    text id 40 start 11s for 3s at (88.89, 85)
         ''$$[color=#E74C3C]a^2[/color] + [color=#2ECC71]b^2[/color] = [color=#9B59B6]c^2[/color]$$'' ;
    
    speech id 503 start 11s 
           "La somme des aires des deux petits carrés égale l'aire du grand carré." ;
}
```

### Exemple 2 : Fonctions trigonométriques

```hypercourse
course "Sinus et Cosinus" {
    # Titre
    text id 1 start 0.5s at (88.89, 8)
         ''[bold]Fonctions Trigonométriques[/bold]'' ;
    
    # Repère
    draw 2drep id 100 start 1s for 1s 
               at (88.89, 50) 
               color (100, 100, 100, 1) 
               width 1.5 
               scale = 3 
               x_range = [-6.28, 6.28] 
               y_range = [-1.5, 1.5] ;
    
    speech id 500 start 1s 
           "Voici le repère cartésien pour nos fonctions." ;
    
    # Fonction sinus
    draw 2dfunc id 101 start 3s for 3s 
                color (231, 76, 60, 1) 
                width 3 
                at 100 
                y = sin(x) ;
    
    speech id 501 start 3s 
           "La courbe rouge représente la fonction sinus." ;
    
    # Fonction cosinus
    draw 2dfunc id 102 start 6s for 3s 
                color (52, 152, 219, 1) 
                width 3 
                at 100 
                y = cos(x) ;
    
    speech id 502 start 6s 
           "La courbe bleue représente la fonction cosinus." ;
    
    # Légendes
    text id 110 start 9s at (145, 15)
         ''[color=#E74C3C]$y = \sin(x)$[/color]'' ;
    
    text id 111 start 9s at (145, 22)
         ''[color=#3498DB]$y = \cos(x)$[/color]'' ;
    
    # Points remarquables
    draw circle id 120 start 10s 
                color (46, 204, 113, 1) 
                width 2 
                fillcolor (46, 204, 113, 0.5) 
                radius 2 
                at (88.89, 50) ;
    
    draw circle id 121 start 10.5s 
                color (46, 204, 113, 1) 
                width 2 
                fillcolor (46, 204, 113, 0.5) 
                radius 2 
                at (135.89, 20) ;
    
    # Curseur montrant les points
    mouse move id 600 start 10s for 2s 
               at [(88.89, 50), (135.89, 20)] ;
    
    text id 130 start 11s at (135.89, 15)
         ''$(\frac{\pi}{2}, 1)$'' ;
}
```

### Exemple 3 : Dérivée d'une fonction

```hypercourse
course "Introduction aux Dérivées" {
    # Titre
    text id 1 start 0.5s at (88.89, 8)
         ''[bold]La Dérivée : Taux de Variation[/bold]'' ;
    
    # Repère
    draw 2drep id 100 start 1s 
               at (88.89, 55) 
               scale = 4 
               x_range = [-3, 3] 
               y_range = [-2, 10] ;
    
    # Fonction principale
    draw 2dfunc id 101 start 2s for 2s 
                color (52, 152, 219, 1) 
                width 3.5 
                at 100 
                y = x^2 ;
    
    speech id 500 start 2s 
           "Considérons la fonction f de x égale x carré." ;
    
    text id 10 start 3.5s at (20, 20)
         ''$f(x) = x^2$'' ;
    
    # Point A
    draw circle id 110 start 5s 
                color (231, 76, 60, 1) 
                width 2 
                fillcolor (231, 76, 60, 1) 
                radius 1.5 
                at (68.89, 59) ;
    
    text id 111 start 5.5s at (65, 64)
         ''$A$'' ;
    
    # Point B
    draw circle id 120 start 6s 
                color (231, 76, 60, 1) 
                width 2 
                fillcolor (231, 76, 60, 1) 
                radius 1.5 
                at (108.89, 43) ;
    
    text id 121 start 6.5s at (112, 43)
         ''$B$'' ;
    
    # Sécante
    draw line id 130 start 7s for 1s 
              color (46, 204, 113, 1) 
              width 2 
              at [(55, 68), (120, 35)] ;
    
    speech id 501 start 7s 
           "La droite verte est la sécante passant par A et B." ;
    
    text id 131 start 8s at (125, 30)
         ''Sécante'' ;
    
    # Animation : B se rapproche de A
    erase id 900 start 10s at [120, 121, 130, 131] ;
    
    draw circle id 122 start 10.5s 
                color (231, 76, 60, 1) 
                width 2 
                fillcolor (231, 76, 60, 1) 
                radius 1.5 
                at (88.89, 51) ;
    
    draw line id 132 start 11s for 1s 
              color (46, 204, 113, 1) 
              width 2 
              at [(60, 65), (115, 45)] ;
    
    speech id 502 start 10.5s 
           "Lorsque B se rapproche de A..." ;
    
    # Tangente finale
    erase id 901 start 13s at [122, 132] ;
    
    draw line id 140 start 13.5s for 1.5s 
              color (155, 89, 182, 1) 
              width 3 
              at [(45, 68), (110, 48)] ;
    
    text id 141 start 15s at (115, 45)
         ''[color=#9B59B6]Tangente[/color]'' ;
    
    speech id 503 start 13.5s 
           "La sécante devient la tangente. Sa pente est la dérivée en A." ;
    
    # Formule de la dérivée
    text id 150 start 16s for 2s at (88.89, 88)
         ''$$f'(x) = \lim_{h \to 0} \frac{f(x+h) - f(x)}{h}$$'' ;
}
```

---

##  Bonnes pratiques

### Organisation du code

#### 1. Structure hiérarchique des IDs

```hypercourse
# Recommandé
text id 1 ...           # Titre principal
text id 2 ...           # Sous-titre

draw line id 10 ...     # Premier élément géométrique
draw circle id 11 ...   # Deuxième élément géométrique

draw 2drep id 100 ...   # Repère
draw 2dfunc id 101 ...  # Première fonction
draw 2dfunc id 102 ...  # Deuxième fonction

speech id 500 ...       # Première narration
speech id 501 ...       # Deuxième narration
```

#### 2. Commentaires descriptifs

```hypercourse
# ═══════════════════════════════════════
# SECTION 1 : INTRODUCTION
# ═══════════════════════════════════════

# Affichage du titre avec animation d'écriture
text id 1 start 1s for 2s at (88.89, 10) ''[bold]Titre[/bold]'' ;

# ═══════════════════════════════════════
# SECTION 2 : CONSTRUCTION GÉOMÉTRIQUE
# ═══════════════════════════════════════

# Triangle ABC
draw polygone id 10 start 3s ... ;
```

#### 3. Séquencement logique

```hypercourse
# ✓ Bon : progression temporelle claire
text id 1 start 1s ...
draw line id 10 start 3s ...
draw circle id 11 start 5s ...

# ✗ Mauvais : ordre temporel confus
draw circle id 11 start 5s ...
text id 1 start 1s ...
draw line id 10 start 3s ...
```

### Temporisation optimale

#### Espacement des animations

```hypercourse
# ✓ Bon : laisse le temps de visualiser
text id 1 start 1s for 2s ...
draw line id 10 start 4s for 1s ...     # 1s après la fin du texte
draw circle id 11 start 6s for 1.5s ... # 1s après la ligne

# ✗ Mauvais : trop d'animations simultanées
text id 1 start 1s for 2s ...
draw line id 10 start 1s for 1s ...
draw circle id 11 start 1.5s for 1.5s ...
```

#### Durées d'animation

```hypercourse
# Durées recommandées
text ... for 2s       # Texte court
text ... for 3s       # Formule complexe
draw line ... for 1s  # Ligne simple
draw circle ... for 1.5s  # Forme simple
draw 2dfunc ... for 3s    # Fonction mathématique
```

### Synchronisation audio-visuel

```hypercourse
# ✓ Bon : narration synchronisée avec l'animation
draw circle id 10 start 5s for 2s ...
speech id 500 start 5s "Observons ce cercle." ;

# Narration suivante après l'animation
speech id 501 start 8s "Maintenant, traçons une tangente." ;
draw line id 11 start 8s for 1s ...
```

### Performance et lisibilité

#### Limiter la complexité

```hypercourse
# ✓ Bon : nombre raisonnable d'éléments simultanés
# Maximum 5-10 animations en parallèle

# ✗ Mauvais : trop d'éléments actifs
# Plus de 20 formes animées en même temps
```

#### Utiliser l'effacement

```hypercourse
# ✓ Bon : nettoyer régulièrement
text id 1 start 1s ...
draw line id 10 start 3s ...
erase id 900 start 10s at [1, 10] ;  # Libère la mémoire

# Nouvelles animations
text id 2 start 11s ...
```

### Choix des couleurs

#### Palette cohérente

```hypercourse
# Définir une palette de couleurs au début (en commentaire)
# Palette :
# - Bleu principal : (52, 152, 219, 1)
# - Rouge accent : (231, 76, 60, 1)
# - Vert validation : (46, 204, 113, 1)
# - Gris neutre : (149, 165, 166, 1)

draw line id 10 color (52, 152, 219, 1) ...
draw circle id 11 color (231, 76, 60, 1) ...
```

#### Contraste et accessibilité

```hypercourse
# ✓ Bon : contraste élevé
text ... ''[color=#000000]Texte noir sur fond blanc[/color]'' ;

# ✓ Bon : transparence pour les remplissages
draw circle ... fillcolor (52, 152, 219, 0.3) ;

# ✗ Mauvais : faible contraste
text ... ''[color=#CCCCCC]Texte gris clair sur fond blanc[/color]'' ;
```

### Formules LaTeX

#### Formules simples vs complexes

```hypercourse
# Formule inline pour le texte courant
text id 1 ... ''La formule $E = mc^2$ est célèbre.'' ;

# Formule display pour mise en évidence
text id 2 ... ''$E = mc^2$'' ;

# Formules complexes avec espacement
text id 3 ... ''$\int_{-\infty}^{+\infty} e^{-x^2} dx = \sqrt{\pi}$'' ;
```

#### Formatage lisible

```hypercourse
# ✓ Bon : formule bien espacée
''$f(x) = \frac{1}{\sigma \sqrt{2\pi}} e^{-\frac{(x-\mu)^2}{2\sigma^2}}$''

# ✓ Bon : utilisation de \text pour le texte
''$P(A|B) = \frac{P(B|A) \cdot P(A)}{P(B)} \text{ (Théorème de Bayes)}$''
```

---

## 🔧 API

### Classe `HypercourseParser`

Parser principal pour analyser les scripts Hypercourse.

```dart
class HypercourseParser {
  final String script;
  
  HypercourseParser(this.script);
  
  /// Parse le script et retourne la liste des éléments
  List<HyperElement> parse();
}
```

**Utilisation :**

```dart
final script = '''
  hypergeneration "Demo" {
    text id 1 at (88.89, 50) start 1s ''Hello!'' ;
  }
''';

final parser = HypercourseParser(script);
final elements = parser.parse();
```

**Gestion des erreurs :**

```dart
try {
  final elements = parser.parse();
  print('✓ Parsing réussi : ${elements.length} éléments');
} catch (e) {
  print('✗ Erreur de parsing : $e');
}
```

### Types d'éléments (`HyperElement`)

Tous les éléments héritent de la classe abstraite `HyperElement` :

```dart
abstract class HyperElement {
  final int id;
  final double startTime;
  final double duration;
  
  HyperElement({
    required this.id,
    required this.startTime,
    this.duration = 0,
  });
}
```

#### Types disponibles

| Classe | Description |
|--------|-------------|
| `TextElement` | Texte ou formule LaTeX |
| `LineElement` | Ligne droite |
| `ArrowElement` | Flèche |
| `PathElement` | Ligne brisée |
| `CurveElement` | Courbe lissée |
| `PolygonElement` | Polygone fermé |
| `CircleElement` | Cercle |
| `EllipseElement` | Ellipse |
| `ArcElement` | Arc de cercle |
| `EllipticArcElement` | Arc elliptique |
| `Repere2DElement` | Repère cartésien |
| `Function2DElement` | Fonction mathématique |
| `PlotElement` | Graphique Python |
| `EraseElement` | Effacement d'éléments |
| `SpeechElement` | Narration vocale |
| `MouseEvent` | Animation de curseur |

### Exemple d'utilisation complète

```dart
import 'package:flutter/material.dart';
import 'parsers/hypercourse_parser.dart';
import 'renderers/hypercourse_renderer.dart';

class LessonViewer extends StatefulWidget {
  @override
  _LessonViewerState createState() => _LessonViewerState();
}

class _LessonViewerState extends State<LessonViewer> {
  List<HyperElement>? elements;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadLesson();
  }

  void _loadLesson() {
    final script = '''
      course "Ma Leçon" {
        text id 1 start 1s for 2s at (88.89, 50)
             ''[bold]Bienvenue ![/bold]'' ;
        
        draw circle id 10 start 3s for 2s 
             color (255, 0, 0, 1) 
             width 3 
             radius 30 
             at (88.89, 50) ;
      }
    ''';

    try {
      final parser = HypercourseParser(script);
      setState(() {
        elements = parser.parse();
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Text(
            'Erreur : $errorMessage',
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    if (elements == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Hypercourse Viewer')),
      body: HypercourseRenderer(elements: elements!),
    );
  }
}
```

---

##  Cas d'usage avancés

### 1. Animation progressive d'un graphique

```hypercourse
course "Construction Progressive" {
    # Repère
    draw 2drep id 100 start 1s at (88.89, 50) scale = 3 ;
    
    # Fonction tracée par segments
    draw 2dfunc id 101 start 3s for 1s 
                color (231, 76, 60, 1) 
                at 100 
                y = x^2 ;
    
    # Points remarquables apparaissant un par un
    draw circle id 110 start 5s radius 2 at (68.89, 54) ;
    text id 111 start 5.5s at (65, 58) ''$(-2, 4)' ;
    
    draw circle id 120 start 6s radius 2 at (88.89, 50) ;
    text id 121 start 6.5s at (85, 54) ''$(0, 0)' ;
    
    draw circle id 130 start 7s radius 2 at (108.89, 54) ;
    text id 131 start 7.5s at (105, 58) ''$(2, 4)' ;
    
    # Tangentes apparaissant progressivement
    draw line id 140 start 8s for 1s 
              color (46, 204, 113, 1) 
              at [(78.89, 58), (98.89, 42)] ;
    
    text id 141 start 9s at (100, 40)
         ''Tangente en $(0,0)' ;
}
```

### 2. Animation de transformation géométrique

```hypercourse
course "Rotation d'un Carré" {
    # Carré initial
    draw polygone id 10 start 1s for 1s 
                  color (52, 152, 219, 1) 
                  width 2 
                  fillcolor (52, 152, 219, 0.3) 
                  at [(70, 40), (107.78, 40), (107.78, 60), (70, 60)] ;
    
    speech id 500 start 1s "Voici un carré." ;
    
    # Centre de rotation
    draw circle id 20 start 2s 
                color (231, 76, 60, 1) 
                width 2 
                fillcolor (231, 76, 60, 1) 
                radius 2 
                at (88.89, 50) ;
    
    text id 21 start 2.5s at (92, 52) ''$O' ;
    
    speech id 501 start 2s "Nous allons le faire tourner autour du point O." ;
    
    # Effacement du carré initial
    erase id 900 start 4s for 0.5s at [10] ;
    
    # Carré après rotation de 45°
    draw polygone id 11 start 4.5s for 1s 
                  color (52, 152, 219, 1) 
                  width 2 
                  fillcolor (52, 152, 219, 0.3) 
                  at [(88.89, 33.79), (115.1, 50), (88.89, 66.21), (62.68, 50)] ;
    
    # Arc montrant l'angle de rotation
    draw arc id 30 start 5s for 1s 
             color (46, 204, 113, 1) 
             width 2 
             at (88.89, 50) 
             radius 15 
             from 0deg to 45deg 
             with +arrow at end ;
    
    text id 31 start 6s at (105, 47) ''$45°' ;
    
    speech id 502 start 5s "Le carré a tourné de 45 degrés." ;
}
```

### 3. Démonstration avec plusieurs étapes

```hypercourse
course "Résolution d'Équation" {
    # Équation initiale
    text id 1 start 1s for 2s at (88.89, 30) 
         ''$2x + 5 = 13$'' ;
    
    speech id 500 start 1s "Résolvons cette équation." ;
    
    # Étape 1 : Soustraire 5
    text id 2 start 4s for 2s at (88.89, 40)
         ''$2x + 5 [color=#E74C3C]-5[/color] = 13 [color=#E74C3C]-5[/color]$'' ;
    
    speech id 501 start 4s "Première étape : soustrayons 5 de chaque côté." ;
    
    # Résultat étape 1
    text id 3 start 7s for 2s at (88.89, 50)
         ''$2x = 8$'' ;
    
    # Étape 2 : Diviser par 2
    text id 4 start 10s for 2s at (88.89, 60)
         ''$\frac{2x}{[color=#3498DB]2[/color]} = \frac{8}{[color=#3498DB]2[/color]}$'' ;
    
    speech id 502 start 10s "Deuxième étape : divisons par 2." ;
    
    # Solution finale
    draw polygone id 10 start 13s for 1s 
                  color (46, 204, 113, 1) 
                  width 3 
                  fillcolor (46, 204, 113, 0.2) 
                  at [(70, 68), (107.78, 68), (107.78, 78), (70, 78)] ;
    
    text id 5 start 13.5s for 2s at (88.89, 73)
         ''$[bold]x = 4[/bold]$'' ;
    
    speech id 503 start 13.5s "La solution est x égale 4." ;
    
    # Vérification
    text id 6 start 16s for 2s at (88.89, 85)
         ''Vérification : $2(4) + 5 = 8 + 5 = 13$ ✓'' ;
}
```

### 4. Graphique avec annotations dynamiques

```hypercourse
course "Analyse de Fonction" {
    # Repère et fonction
    draw 2drep id 100 start 1s at (88.89, 50) scale = 2.5 
               x_range = [-4, 4] y_range = [-3, 5] ;
    
    draw 2dfunc id 101 start 2s for 2s 
                color (52, 152, 219, 1) 
                width 3 
                at 100 
                y = x^3 - 3*x ;
    
    text id 1 start 4s at (20, 15)
         ''$f(x) = x^3 - 3x' ;
    
    # Maximum local
    draw circle id 110 start 5s 
                color (46, 204, 113, 1) 
                width 2 
                fillcolor (46, 204, 113, 1) 
                radius 2 
                at (68.89, 43) ;
    
    mouse move id 600 start 5s for 1s at [(60, 55), (68.89, 43)] ;
    
    text id 111 start 6s at (60, 40)
         ''[color=#2ECC71]Maximum local[/color]'' ;
    
    draw arrow id 112 start 6s 
               color (46, 204, 113, 1) 
               width 1.5 
               at [(65, 41), (68.89, 43)] ;
    
    speech id 500 start 5s "Voici le maximum local en x égale moins 1." ;
    
    # Minimum local
    draw circle id 120 start 8s 
                color (231, 76, 60, 1) 
                width 2 
                fillcolor (231, 76, 60, 1) 
                radius 2 
                at (108.89, 57) ;
    
    mouse move id 601 start 8s for 1s at [(68.89, 43), (108.89, 57)] ;
    
    text id 121 start 9s at (120, 54)
         ''[color=#E74C3C]Minimum local[/color]'' ;
    
    draw arrow id 122 start 9s 
               color (231, 76, 60, 1) 
               width 1.5 
               at [(115, 55), (108.89, 57)] ;
    
    speech id 501 start 8s "Et le minimum local en x égale 1." ;
    
    # Points d'inflexion
    draw circle id 130 start 11s 
                color (155, 89, 182, 1) 
                width 2 
                fillcolor (155, 89, 182, 1) 
                radius 2 
                at (88.89, 50) ;
    
    text id 131 start 11.5s at (92, 48)
         ''[color=#9B59B6]Point d'inflexion[/color]'' ;
    
    speech id 502 start 11s "Le point d'inflexion se trouve à l'origine." ;
}
```

---

##  Débogage et résolution de problèmes

### Erreurs courantes

#### 1. Erreur de syntaxe

```
✗ Erreur : Attendu ";" à la position 145, trouvé "}"
```

**Cause :** Oubli du point-virgule à la fin d'une commande.

**Solution :**
```hypercourse
# ✗ Mauvais
text id 1 start 1s at (50, 50) ''Hello''

# ✓ Bon
text id 1 at (50, 50) start 1s ''Hello'' ;
```

#### 2. ID manquant

```
✗ Erreur : Attendu "id" à la position 87
```

**Cause :** Commande sans identifiant.

**Solution :**
```hypercourse
# ✗ Mauvais
text start 1s at (50, 50) ''Hello'' ;

# ✓ Bon
text id 1 start 1s at (50, 50) ''Hello'' ;
```

#### 3. Points insuffisants

```
✗ Erreur : Une ligne nécessite au moins 2 points
```

**Cause :** Liste de points incomplète.

**Solution :**
```hypercourse
# ✗ Mauvais
draw line id 10 at [(50, 50)] ;

# ✓ Bon
draw line id 10 at [(30, 30), (70, 70)] ;
```

#### 4. Repère inexistant pour fonction

```
✗ Erreur : 2dfunc id 101: manque "at <id_repere>"
```

**Cause :** Fonction sans repère associé.

**Solution :**
```hypercourse
# Créer d'abord le repère
draw 2drep id 100 start 1s ... ;

# Puis la fonction
draw 2dfunc id 101 start 3s at 100 y = x^2 ;
```

### Mode débogage

Le parser affiche des informations de débogage dans la console :

```
 Elements parsés: 5
  - TextElement id=1
  - Repere2DElement id=100
  - Function2DElement id=101
  - SpeechElement id=500
  - EraseElement id=999
```

### Validation du script

```dart
void validateScript(String script) {
  try {
    final parser = HypercourseParser(script);
    final elements = parser.parse();
    
    print('✓ Script valide');
    print('  Nombre d\'éléments : ${elements.length}');
    
    // Vérifier les IDs uniques
    final ids = elements.map((e) => e.id).toList();
    final uniqueIds = ids.toSet();
    if (ids.length != uniqueIds.length) {
      print('⚠ Attention : IDs dupliqués détectés');
    }
    
    // Vérifier l'ordre temporel
    for (int i = 1; i < elements.length; i++) {
      if (elements[i].startTime < elements[i-1].startTime) {
        print('⚠ Attention : éléments non ordonnés temporellement');
        break;
      }
    }
    
  } catch (e) {
    print('✗ Script invalide : $e');
  }
}
```

---

##  Performances et optimisation

### Recommandations

| Aspect | Recommandation | Limite |
|--------|----------------|--------|
| Éléments simultanés | < 10 animations | 20 max |
| Durée totale | < 5 minutes | 10 minutes |
| Taille du script | < 1000 lignes | 2000 lignes |
| Points par path | < 100 points | 500 points |
| Fonctions 2D | < 5 courbes | 10 courbes |

### Optimisations

#### Réutilisation d'éléments

```hypercourse
# ✗ Mauvais : créer plusieurs fois le même élément
draw circle id 10 start 1s ... ;
erase id 900 start 5s at [10] ;
draw circle id 11 start 6s ... ;  # Même cercle !

# ✓ Bon : garder l'élément visible
draw circle id 10 start 1s for 10s ... ;
```

#### Groupement d'effacements

```hypercourse
# ✗ Mauvais : plusieurs commandes erase
erase id 900 start 10s at [1] ;
erase id 901 start 10s at [2] ;
erase id 902 start 10s at [3] ;

# ✓ Bon : un seul effacement groupé
erase id 900 start 10s at [1, 2, 3] ;
```

---

##  Contribution

### Guide de contribution

Nous accueillons les contributions ! Voici comment participer :

1. **Fork** le projet
2. Créez une **branche** pour votre fonctionnalité (`git checkout -b feature/AmazingFeature`)
3. **Committez** vos changements (`git commit -m 'Add AmazingFeature'`)
4. **Push** vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une **Pull Request**

### Standards de code

- Suivre les conventions Dart/Flutter
- Documenter toutes les fonctions publiques
- Ajouter des tests pour les nouvelles fonctionnalités
- Maintenir la compatibilité ascendante

### Rapporter des bugs

Utilisez le template suivant :

```markdown
**Description du bug**
Description claire et concise du problème.

**Script Hypercourse**
```hypercourse
# Votre script qui cause le problème
```

**Comportement attendu**
Ce qui devrait se passer.

**Comportement observé**
Ce qui se passe réellement.

**Environnement**
- OS : [ex: Windows 11]
- Dart SDK : [ex: 3.2.0]
- Flutter : [ex: 3.16.0]
```

---

##  Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.

```
MIT License

Copyright (c) 2024 Hypercourse

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

##  Ressources

### Documentation

- [Guide de démarrage rapide](docs/quickstart.md)
- [Référence complète du DSL](docs/reference.md)
- [Tutoriels vidéo](https://example.com/tutorials)
- [FAQ](docs/faq.md)

### Communauté

- [Discord](https://discord.gg/hypercourse)
- [Forum](https://forum.hypercourse.dev)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/hypercourse)

### Outils

- [Éditeur en ligne](https://editor.hypercourse.dev)
- [Validateur de syntaxe](https://validator.hypercourse.dev)
- [Galerie d'exemples](https://gallery.hypercourse.dev)

---

##  Changelog

### Version 1.0.0 (2024-01-XX)

#### Ajouts
-  Support complet des formes géométriques
-  Système de repères cartésiens avec fonctions 2D
-  Intégration LaTeX pour formules mathématiques
-  Narration vocale synchronisée
-  Animation de curseur
-  Commande d'effacement progressif

#### Améliorations
-  Meilleur rendu des courbes lissées
-  Performances optimisées pour les animations
-  Documentation complète

#### Corrections
-  Correction du parsing des nombres négatifs
-  Gestion correcte des espaces dans les expressions
-  Fix des arcs elliptiques avec rotation

---

##  Remerciements

- **Flutter Team** pour le framework exceptionnel
- **LaTeX Project** pour le système de composition typographique
- **Matplotlib** pour les capacités de visualisation
- **Communauté open source** pour les contributions et retours

---

##  Contact

- **Email** : contact@hypercourse.dev
- **Twitter** : [@hypercourse](https://twitter.com/hypercourse)
- **Site web** : [https://hypercourse.dev](https://hypercourse.dev)

---

<div align="center">

**Fait avec ❤️ pour l'éducation**

[Documentation](https://docs.hypercourse.dev) • [Exemples](https://examples.hypercourse.dev) • [Communauté](https://community.hypercourse.dev)

</div>