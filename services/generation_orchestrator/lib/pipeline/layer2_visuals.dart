import 'gemini_client.dart';
import 'llm_client.dart';
import 'models.dart';
import 'prompt_loader.dart';

/// Layer 2 : génération des appuis visuels Hypercourse synchronisés sur l'audio.
class Layer2VisualGenerator {
  final LlmClient _client;

  Layer2VisualGenerator({LlmClient? client})
    : _client = client ?? GeminiClient();

  static String get hypercourseDsl => PromptLoader.load('hypercourse_dsl.md');

  static String get systemPrompt => PromptLoader.load(
        'layer2_visuals_system.md',
        variables: {'hypercourse_dsl': hypercourseDsl},
      );

  static String get syntaxCorrectionSystemPrompt => PromptLoader.load(
        'layer2_syntax_correction_system.md',
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

  Future<Layer2Result> generate(
    TranscriptResult transcript, {
    String? subject,
    String? level,
    CourseMetadata? metadata,
    String? previousAttempt,
    String? previousError,
  }) async {
    final timestampedText = _formatTimestampedTranscript(transcript);
    final effectiveSubject = subject ?? metadata?.subject ?? transcript.subject;
    final effectiveLevel = level ?? metadata?.level;

    var userMessage = '''
SUJET : $effectiveSubject
${effectiveLevel != null && effectiveLevel.isNotEmpty ? 'NIVEAU : $effectiveLevel\n' : ''}DURÉE : ${transcript.duration.toStringAsFixed(1)}s

TRANSCRIPT TIMESTAMPÉ :
$timestampedText

Génère les appuis visuels Hypercourse sous forme de JSON avec {"idgap": int, "visualsText": "..."}.
''';

    if (previousAttempt != null && previousError != null) {
      userMessage += '''

Le script précédent que tu as généré a provoqué cette erreur au parsing :
$previousError

Script précédent à corriger :
$previousAttempt

Corrige impérativement l'erreur en respectant le DSL Hypercourse, tout en conservant la structure et le contenu pédagogique.
''';

      final json = await _client.completeJson(
        system: syntaxCorrectionSystemPrompt,
        userMessage: userMessage,
        schema: _schema,
        maxTokens: 16384,
      );
      return Layer2Result.fromJson(json);
    }

    final json = await _client.completeJson(
      system: systemPrompt,
      userMessage: userMessage,
      schema: _schema,
      maxTokens: 16384,
    );
    return Layer2Result.fromJson(json);
  }

  /// Étape dédiée à la correction de syntaxe DSL suite à une erreur de compilation/parsing.
  Future<Layer2Result> correctSyntax({
    required String brokenScript,
    required String syntaxError,
    required TranscriptResult transcript,
    String? subject,
    String? level,
    CourseMetadata? metadata,
  }) async {
    final timestampedText = _formatTimestampedTranscript(transcript);
    final effectiveSubject = subject ?? metadata?.subject ?? transcript.subject;
    final effectiveLevel = level ?? metadata?.level;

    final userMessage = '''
SUJET : $effectiveSubject
${effectiveLevel != null && effectiveLevel.isNotEmpty ? 'NIVEAU : $effectiveLevel\n' : ''}
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

    return Layer2Result.fromJson(json);
  }

  String _formatTimestampedTranscript(TranscriptResult transcript) {
    final compact = transcript.compactTimeline;
    if (compact != null && compact.trim().isNotEmpty) {
      return compact.trim();
    }

    if (transcript.transcriptTimestamped.isNotEmpty) {
      return transcript.transcriptTimestamped
          .map((w) => w.toCompact())
          .join('\n');
    }

    return transcript.transcript;
  }
}

/// Alias rétro-compatible
typedef Layer3VisualGenerator = Layer2VisualGenerator;
