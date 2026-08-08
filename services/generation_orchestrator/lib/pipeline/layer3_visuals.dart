import 'claude_client.dart';
import 'models.dart';

/// Layer 3 : génération des appuis visuels Hypercourse (illimmi-doc.md
/// §2.4), normalement confiée à un Gemma 4 fine-tuné — remplacé ici par
/// Claude en attendant ce fine-tuning.
///
/// Ne génère volontairement jamais de commande `speech` : le sous-titre n'a
/// pas encore d'affichage à l'écran (aucun toggle/overlay construit), donc
/// seuls `text`/`draw`/`mouse`/`erase` sont produits.
class Layer3VisualGenerator {
  final ClaudeClient _client;

  Layer3VisualGenerator({ClaudeClient? client})
    : _client = client ?? ClaudeClient();

  static const String _systemPrompt = '''
Tu es ILLIMMI Layer 3.
Tu reçois un transcript de cours de mathématiques avec les timestamps de
chaque groupe de mots. Tu génères uniquement les commandes Hypercourse
(text, draw, mouse, erase) qui servent d'appuis visuels synchronisés sur ce
transcript.

RÈGLES :
- Chaque élément apparaît 0.2s à 0.5s après le mot déclencheur.
- IDs : text(1-100), draw(101-200), mouse(301-400), erase(401-500).
- Coordonnées : x ∈ [0, 177.78], y ∈ [0, 100].
- Pas trop d'éléments — un vrai prof n'écrit pas tout.
- Efface entre les grandes sections avec erase (les IDs référencés doivent
  être actuellement visibles à l'écran).
- N'utilise JAMAIS la commande `speech` — uniquement text/draw/mouse/erase.
- Génère uniquement les commandes Hypercourse, rien d'autre (pas de
  ```markdown``` ni de commentaire hors syntaxe `#`).

SYNTAXE DE RÉFÉRENCE :
text id <n> start <t>s [for <d>s] at (<x>, <y>) ''<contenu>'' ;
draw line id <n> start <t>s [for <d>s] [color (<r>,<g>,<b>,<a>)] width <w> at [(<x1>,<y1>), (<x2>,<y2>)] ;
draw circle id <n> start <t>s [for <d>s] [color (...)] [width <w>] [fillcolor (...)] radius <r> at (<cx>, <cy>) ;
draw polygone id <n> start <t>s [for <d>s] [color (...)] [width <w>] [fillcolor (...)] at [(<x1>,<y1>), ...] ;
draw 2drep id <n> start <t>s [for <d>s] at (<x>, <y>) [scale = <f>] [x_range = [min, max]] [y_range = [min, max]] ;
draw 2dfunc id <n> start <t>s [for <d>s] [color (...)] [width <w>] at <id_du_repere> y = <expression> ;
mouse move id <n> start <t>s for <d>s at [(<x1>,<y1>), (<x2>,<y2>), ...] ;
erase id <n> start <t>s [for <d>s] at [<id1>, <id2>, ...] ;
''';

  Future<String> generate(
    TranscriptResult transcript,
    CourseMetadata metadata, {
    String? previousAttempt,
    String? previousError,
  }) {
    final timestampedText = _formatTimestampedTranscript(transcript);

    var userMessage =
        '''
SUJET : ${metadata.subject}
NIVEAU : ${metadata.level}
DURÉE : ${transcript.duration.toStringAsFixed(1)}s

TRANSCRIPT TIMESTAMPÉ :
$timestampedText

Génère les appuis visuels Hypercourse.
''';

    if (previousAttempt != null && previousError != null) {
      userMessage +=
          '''

Le script précédent que tu as généré a provoqué cette erreur au parsing :
$previousError

Script précédent :
$previousAttempt

Corrige-le en respectant strictement la syntaxe et les règles ci-dessus.
''';
    }

    return _client.complete(
      system: _systemPrompt,
      userMessage: userMessage,
      maxTokens: 4096,
    );
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
