import 'gemini_client.dart';
import 'llm_client.dart';
import 'models.dart';

/// Layer 3 : génération des appuis visuels Hypercourse (illimmi-doc.md
/// §2.4).
class Layer3VisualGenerator {
  final LlmClient _client;

  Layer3VisualGenerator({LlmClient? client})
    : _client = client ?? GeminiClient();

  static const String _hypercourseDsl = r'''
# Spécification du DSL Hypercourse (`.hc`)

## 1. Vue d'ensemble & Philosophie
Hypercourse (`.hc`) est un DSL (Domain Specific Language) déclaratif et déterministe conçu pour synchroniser des appuis visuels (textes, formules LaTeX, figures géométriques, tracés de fonctions, curseur de tableau) avec un fichier audio de narration.

### Propriétés clés
- Orientation temporelle : Chaque élément visuel est positionné dans le temps au moyen d'un timestamp de début (`start`) et d'une durée d'animation de son dessin (`for`) et disparaît du tableau une fois effacé par la commande (`erase`).
- Coordonnées normalisées 16:9 : L'espace de travail est indépendant de la résolution de l'écran.
- Transparence et Légèreté : Un cours complet de plusieurs minutes tient dans un fichier texte de quelques Ko.

---

## 2. Système de coordonnées & Espace de travail
Le tableau blanc utilise un repère cartésien à origine en haut à gauche avec un ratio 16:9 :

(0, 0) ────────────────────────────────────────── (177.78, 0)
  │                                                     │
  │                  (88.89, 50)                        │
  │              [Centre du Tableau]                    │
  │                                                     │
  │                  (84.0, 55.0)                       │
  │             [Centre Pédagogique]                    │
  │                                                     │
(0, 100) ──────────────────────────────────────── (177.78, 100)

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

start 2.5s      # Démarre à 2,5 secondes depuis le début de l'audio
for 1.5s        # Durée d'animation de 1,5 seconde pour l'apparition complète de l'élément.

Règles :
- Le suffixe `s` est obligatoire
- Les décimales sont supportées
- `start` est obligatoire pour chaque élément
- `for` est optionnel — si absent, l'élément apparaît instantanément et reste affiché jusqu'à la fin du cours ou jusqu'à un `erase`.

---

## 4. Définition des plages d'ID (Espaces de noms)
Chaque élément possède un identifiant numérique unique (`id`). La famille d'un élément est déduite automatiquement selon la valeur du paramètre `idgap` (valeur par défaut recommandée : 100) :

| Famille d'élément | Plage d'ID (`idgap = 100`) | Formule générale |
| :--- | :--- | :--- |
| `text` | `1 – 100` | 1 <= id <= idgap |
| `draw` | `101 – 200` | idgap + 1 <= id <= 2 * idgap |
| `speech` (legacy) | `201 – 300` | 2 * idgap + 1 <= id <= 3 * idgap |
| `mouse` | `301 – 400` | 3 * idgap + 1 <= id <= 4 * idgap |
| `erase` | `401 – 500` | 4 * idgap + 1 <= id <= 5 * idgap |

---

## 5. Couleurs
Format RGBA : `color (R, G, B, A)`

color (255, 0, 0, 1)          # Rouge opaque
color (0, 100, 255, 0.5)      # Bleu semi-transparent
fillcolor (200, 200, 0, 0.3)  # Remplissage jaune translucide

- R, G, B : 0–255
- A : 0.0–1.0

---

## 6. Formatage de texte
Le contenu textuel est encadré par `''` :

| Syntaxe | Résultat |
|---------|----------|
| `''texte''` | Texte normal |
| `''[bold]texte[/bold]''` | Gras |
| `''[italic]texte[/italic]''` | Italique |
| `''[color=#FF0000]texte[/color]''` | Texte coloré |
| `''[font=Courier]texte[/font]''` | Police spécifique |
| `''$E=mc^2$''` | Formule LaTeX inline |
| `''$$\int_0^\infty e^{-x}dx$$''` | Formule LaTeX display |

---

## 7. Structure d'un cours
La pipeline se charge d'ajouter le header du cours `course "..." id <courseid> idgap <idgap> for <durée>s audio "<audio>" { ... }`.
Le modèle doit choisir la valeur `idgap` (ex: 100) et générer les commandes visuelles `visualsText` qui vont à l'intérieur du bloc.

---

## 8. Syntaxe de référence des commandes

### 8.1 `text` - Affichage de texte ou formule LaTeX
text id <ID> start <TIME>s [for <DURATION>s] at (<X>, <Y>) ''<CONTENU>'' ;

Exemple :
text id 1 start 1.5s for 30s at (88.89, 8) ''[bold][color=#2980B9]Les Dérivées[/color][/bold]'' ;
text id 2 start 12s at (88.89, 40) ''$$f'(x) = \lim_{h \to 0} \frac{f(x+h)-f(x)}{h}$$'' ;

### 8.2 `draw` - Formes géométriques & Figures

#### `draw line` - Ligne droite
draw line id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] width <w> at [(<x1>,<y1>), (<x2>,<y2>)] ;

#### `draw arrow` - Flèche
draw arrow id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] width <w> at [(<x1>,<y1>), (<x2>,<y2>)] ;

#### `draw path` - Ligne brisée
draw path id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] width <w> at [(<x1>,<y1>), (<x2>,<y2>), ...] ;

#### `draw curve` - Courbe lissée
draw curve id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] width <w> [smooth|bezier] at [points] [with <+/->arrow at end] ;

#### `draw circle` - Cercle
draw circle id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] [width <w>] [fillcolor (<r>,<g>,<b>,<a>)] radius <r> at (<cx>, <cy>) [with <+/->arrow on <angle>deg] ;

#### `draw ellipse` - Ellipse
draw ellipse id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] [width <w>] [fillcolor (<r>,<g>,<b>,<a>)] radiusX <rx> radiusY <ry> [rotation <angle>] at (<cx>, <cy>) [with <+/->arrow on <angle>deg] ;

#### `draw arc` - Arc de cercle
draw arc id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] [width <w>] [fillcolor (<r>,<g>,<b>,<a>)] radius <r> at (<cx>, <cy>) from <début>deg to <fin>deg [with <+/->arrow at end] ;

#### `draw elliptic_arc` - Arc elliptique
draw elliptic_arc id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] [width <w>] [fillcolor (<r>,<g>,<b>,<a>)] radiusX <rx> radiusY <ry> [rotation <angle>] at (<cx>, <cy>) from <début>deg to <fin>deg [with <+/->arrow at end] ;

#### `draw polygone` - Polygone
draw polygone id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] [width <w>] [fillcolor (<r>,<g>,<b>,<a>)] at [(<x1>,<y1>), (<x2>,<y2>), ...] ;

#### `draw 2drep` - Repère cartésien
draw 2drep id <n> start <t>s [for <d>s] at (<x>, <y>) [color (<r>,<g>,<b>,<a>)] [width <w>] [scale = <facteur>] [x_range = [xmin, xmax]] [y_range = [ymin, ymax]] ;

#### `draw 2dfunc` - Fonction mathématique
draw 2dfunc id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] [width <w>] at <id_du_repere> y = <expression> ;

### 8.3 `mouse move` - Animation du curseur
mouse move id <ID> start <TIME>s for <DURATION>s at [(X1, Y1), (X2, Y2), ...] ;

### 8.4 `erase` - Effacement
erase id <ID> start <TIME>s [for <DURATION>s] at [<ID_1>, <ID_2>, ...] ;
''';

/*  static const String _systemPrompt = '''
Tu es ILLIMMI Layer 3.
Tu reçois un transcript de cours de mathématiques avec les timestamps de chaque groupe de mots.
Tu génères les appuis visuels Hypercourse synchronisés sur ce transcript.

Tu dois retourner un objet JSON correspondant au modèle :
{
  "idgap": <int>,
  "visualsText": "<commandes hypercourse>"
}

$_hypercourseDsl

RÈGLES :
- IDs : text(1 à idgap), draw(idgap+1 à 2*idgap), mouse(3*idgap+1 à 4*idgap), erase(4*idgap+1 à 5*idgap).
- Coordonnées : x ∈ [0, 177.78], y ∈ [0, 100].
- Pas trop d'éléments — un vrai prof n'écrit pas tout.
- Efface entre les grandes sections avec erase (les IDs référencés doivent être actuellement visibles à l'écran).
- N'utilise JAMAIS la commande `speech` ni `plot` — uniquement text/draw/mouse/erase.
- Le champ `visualsText` contient uniquement les commandes Hypercourse, sans le header `course` ni les accolades de fermeture.
''';*/

  static const String _systemPrompt = '''
  Tu es ILLIMMI Layer 3.
  Tu reçois un transcript de cours de mathématiques avec les timestamps de chaque groupe de mots.
  Tu génères les appuis visuels Hypercourse synchronisés sur ce transcript.

  Tu dois retourner un objet JSON correspondant au modèle :
  {
    "idgap": <int>,
    "visualsText": "<commandes hypercourse>"
  }

  $_hypercourseDsl

  RÈGLES :
  - IDs : text(1 à idgap), draw(idgap+1 à 2*idgap), mouse(3*idgap+1 à 4*idgap), erase(4*idgap+1 à 5*idgap).
  - Coordonnées : x ∈ [0, 177.78], y ∈ [0, 100].
  - Pas trop d'éléments — un vrai prof n'écrit pas tout.
  - Efface entre les grandes sections avec erase (les IDs référencés doivent être actuellement visibles à l'écran).
  - N'utilise JAMAIS la commande `speech` ni `plot` — uniquement text/draw/mouse/erase.
  - Le champ `visualsText` contient uniquement les commandes Hypercourse, sans le header `course` ni les accolades de fermeture.

  DÉTECTION OBLIGATOIRE DES ANCRAGES VISUELS DANS LE TRANSCRIPT :
  Le transcript a été rédigé pour contenir des verbes d'action qui indiquent
  explicitement QUAND et QUOI dessiner. Scanne-le et traite CHAQUE occurrence
  selon cette correspondance :

  | Verbe / expression dans le transcript          | Commande attendue                        |
  |--------------------------------------------------|-------------------------------------------|
  | "traçons/dessinons la courbe de..."              | draw 2drep + draw 2dfunc                  |
  | "regarde ce point / ce point se déplace..."      | mouse move (+ draw circle si point fixe)  |
  | "dessinons le cercle / disque de rayon..."       | draw circle                               |
  | "on découpe / on décompose cette figure..."      | draw polygone ou draw path                |
  | "suivons cette trajectoire..."                   | draw curve                                |
  | "sur cet axe / entre ces deux valeurs..."        | draw line ou draw arrow                   |
  | "voici la formule / l'énoncé..."                 | text (LaTeX)                              |

  Si tu identifies un de ces ancrages dans le transcript et que tu réponds
  uniquement par un `text`, ta réponse est INCORRECTE — un professeur qui dit
  "traçons la courbe" en écrivant juste le mot "courbe" au tableau n'a rien
  enseigné. Le geste visuel décrit par la narration DOIT être exécuté par une
  commande `draw` ou `mouse move` correspondante, au timestamp où il est
  prononcé (± 1s).

  AUTO-VÉRIFICATION AVANT DE RÉPONDRE :
  Relis le transcript et compte les ancrages visuels détectés (verbes
  d'action ci-dessus). Compte ensuite les commandes `draw`/`mouse` que tu as
  générées. Si ces deux nombres sont très différents (ex: 5 ancrages détectés
  pour seulement 1 draw généré), ton script est incomplet — reprends-le avant
  de répondre. Un cours qui n'utilise que `text` alors que le transcript
  contient des verbes d'action visuelle est un échec de ta tâche.
  ''';

  static final Map<String, dynamic> _schema = {
    'type': 'object',
    'properties': {
      'idgap': {'type': 'integer'},
      'visualsText': {'type': 'string'},
    },
    'required': ['idgap', 'visualsText'],
    'additionalProperties': false,
  };

  static const String _syntaxCorrectionSystemPrompt = '''
Tu es ILLIMMI Layer 3 — expert en correction de syntaxe du DSL Hypercourse (`.hc`).
Un script Hypercourse a été généré mais il contient une erreur de compilation ou de parsing syntaxique.
Ta seule tâche est de corriger les erreurs de syntaxe sans altérer l'intention pédagogique ni la structure globale du cours.

Tu dois retourner un objet JSON correspondant au modèle :
{
  "idgap": <int>,
  "visualsText": "<commandes hypercourse corrigées>"
}

$_hypercourseDsl

RÈGLES DE CORRECTION SYNTAXIQUE :
- Lis attentivement le message d'erreur de parsing et repère la commande erronée dans le script précédent.
- Corrige la syntaxe (point-virgule ';' manquant à la fin de chaque commande, parenthèses mal fermées, nom de commande ou paramètre mal orthographié, guillemets manquants, valeurs d'ID ou de couleurs invalides).
- Conserve le contenu pédagogique et les timestamps de début/durée originaux.
- Le champ `visualsText` doit contenir uniquement les commandes Hypercourse corrigées, sans le header `course` ni les accolades de fermeture.
''';

  Future<Layer3Result> generate(
    TranscriptResult transcript,
    CourseMetadata metadata, {
    String? previousAttempt,
    String? previousError,
  }) async {
    final timestampedText = _formatTimestampedTranscript(transcript);

    var userMessage = '''
SUJET : ${metadata.subject}
NIVEAU : ${metadata.level}
DURÉE : ${transcript.duration.toStringAsFixed(1)}s

TRANSCRIPT TIMESTAMPÉ :
$timestampedText

Génère les appuis visuels Hypercourse sous forme de JSON avec {"idgap": int, "visualsText": "..."}.
''';

    if (previousAttempt != null && previousError != null) {
      userMessage += '''

Le script précédent que tu as généré a provoqué cette erreur au parsing :
$previousError

Script précédent :
$previousAttempt

Corrige-le en respectant strictly la syntaxe et les règles ci-dessus.
''';
    }

    final json = await _client.completeJson(
      system: _systemPrompt,
      userMessage: userMessage,
      schema: _schema,
      maxTokens: 4096,
    );

    return Layer3Result.fromJson(json);
  }

  /// Étape dédiée à la correction de syntaxe DSL suite à une erreur de compilation/parsing.
  Future<Layer3Result> correctSyntax({
    required String brokenScript,
    required String syntaxError,
    required TranscriptResult transcript,
    required CourseMetadata metadata,
  }) async {
    final timestampedText = _formatTimestampedTranscript(transcript);

    final userMessage = '''
SUJET : ${metadata.subject}
NIVEAU : ${metadata.level}

TRANSCRIPT TIMESTAMPÉ :
$timestampedText

LE SCRIPT PRÉCÉDENT A PROVOQUÉ UNE ERREUR DE COMPILATION/PARSING DU DSL HYPERCOURSE :
$syntaxError

SCRIPT AVEC ERREUR SYNTAXIQUE :
$brokenScript

Corrige strictement les erreurs de syntaxe et renvoie le script Hypercourse corrigé au format JSON avec {"idgap": int, "visualsText": "..."}.
''';

    final json = await _client.completeJson(
      system: _syntaxCorrectionSystemPrompt,
      userMessage: userMessage,
      schema: _schema,
      maxTokens: 4096,
    );

    return Layer3Result.fromJson(json);
  }


  /// Regroupe les mots timestampés en lignes `[t s] mot1 mot2 ...` (par
  /// groupes de 6 mots), au format utilisé dans illimmi-doc.md §3.3.
  String _formatTimestampedTranscript(TranscriptResult transcript) {
    const groupSize = 6;
    final words = transcript.transcriptTimestamped;
    if (words.isEmpty) return transcript.transcript;

    final buffer = StringBuffer();
    for (var i = 0; i < words.length; i += groupSize) {
      final chunk = words.skip(i).take(groupSize).toList();
      final start = chunk.first.start.toStringAsFixed(1);
      final text = chunk.map((w) => w.word).join(' ');
      buffer.writeln('[${start}s] $text');
    }
    return buffer.toString();
  }
}
