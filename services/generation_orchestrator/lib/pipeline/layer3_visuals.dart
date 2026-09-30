import 'gemini_client.dart';
import 'llm_client.dart';
import 'models.dart';
import 'prompt_loader.dart';

/// Layer 3 : génération des appuis visuels Hypercourse (illimmi-doc.md
/// §2.4).
class Layer3VisualGenerator {
  final LlmClient _client;

  Layer3VisualGenerator({LlmClient? client})
    : _client = client ?? GeminiClient();

  static String get hypercourseDsl => PromptLoader.load('hypercourse_dsl.md');

  static String get systemPrompt => PromptLoader.load(
        'layer3_visuals_system.md',
        variables: {'hypercourse_dsl': hypercourseDsl},
      );

  static String get syntaxCorrectionSystemPrompt => PromptLoader.load(
        'layer3_syntax_correction_system.md',
        variables: {'hypercourse_dsl': hypercourseDsl},
      );

  static final Map<String, dynamic> _schema = {
    'type': 'object',
    'properties': {
      'idgap': {'type': 'integer'},
      'visualsText': {'type': 'string'},
    },
    'required': ['idgap', 'visualsText'],
    'additionalProperties': false,
  };

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
      system: systemPrompt,
      userMessage: userMessage,
      schema: _schema,
      maxTokens: 16384,
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
      system: syntaxCorrectionSystemPrompt,
      userMessage: userMessage,
      schema: _schema,
      maxTokens: 16384,
    );

    return Layer3Result.fromJson(json);
  }


  /// Transmet la timeline compacte directement au prompt LLM (<START>TEXT<END>)
  /// sans regroupement arbitraire de mots, préservant la résolution temporelle fine.
  String _formatTimestampedTranscript(TranscriptResult transcript) {
    final compact = transcript.compactTimeline;
    if (compact != null && compact.trim().isNotEmpty) {
      return compact.trim();
    }

    // Fallback si compactTimeline n'est pas renseignée (ex: mocks de test)
    if (transcript.transcriptTimestamped.isNotEmpty) {
      return transcript.transcriptTimestamped
          .map((w) => w.toCompact())
          .join('\n');
    }

    return transcript.transcript;
  }
}

