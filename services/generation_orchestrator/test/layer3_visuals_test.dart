import 'package:generation_orchestrator/pipeline/layer3_visuals.dart';
import 'package:generation_orchestrator/pipeline/llm_client.dart';
import 'package:generation_orchestrator/pipeline/models.dart';
import 'package:test/test.dart';

class CapturingLlmClient implements LlmClient {
  String? lastSystem;
  String? lastUserMessage;
  Map<String, dynamic>? lastSchema;

  @override
  Future<String> complete({
    required String system,
    required String userMessage,
    int maxTokens = 16384,
  }) async {
    lastSystem = system;
    lastUserMessage = userMessage;
    return '{"idgap": 100, "visualsText": ""}';
  }

  @override
  Future<Map<String, dynamic>> completeJson({
    required String system,
    required String userMessage,
    required Map<String, dynamic> schema,
    int maxTokens = 16384,
  }) async {
    lastSystem = system;
    lastUserMessage = userMessage;
    lastSchema = schema;
    return {'idgap': 100, 'visualsText': 'draw 101 line at (10, 20) to (50, 60);'};
  }

  @override
  Future<Map<String, dynamic>> completeMultimodalJson({
    required String system,
    required List<ContentBlock> content,
    required Map<String, dynamic> schema,
    int maxTokens = 16384,
  }) async {
    throw UnimplementedError();
  }
}

void main() {
  group('Layer3VisualGenerator with Compact Timeline', () {
    late CapturingLlmClient client;
    late Layer3VisualGenerator generator;
    late CourseMetadata metadata;

    setUp(() {
      client = CapturingLlmClient();
      generator = Layer3VisualGenerator(client: client);
      metadata = CourseMetadata(
        subject: 'Les vecteurs',
        level: '2nde',
        durationTarget: 180,
        conceptsCles: ['vecteur', 'direction', 'sens', 'norme'],
        ton: 'didactique',
        langue: 'fr',
        planPedagogique: [
          PlanSection(
            section: 'accroche',
            objectif: 'Comprendre la notion',
            contenuAttendu: 'Exemple de force',
            supportVisuelSuggere: 'Flèche orientée',
          ),
        ],
      );
    });

    test('transmits transcript.compactTimeline directly without 6-word grouping', () async {
      const sampleCompact = '''<0.110>Bonjour !<1.300>
<1.300>Dans<1.380>
<1.380>ce<1.450>
<1.450>cours,<1.830>
<2.150>tu<2.150>
<2.150>vas<2.610>
<2.610>apprendre<3.080>
<3.080>à<3.160>
<3.160>construire<3.600>
<3.600>des<3.840>
<3.840>points<4.180>''';

      final transcript = TranscriptResult(
        transcript: 'Bonjour ! Dans ce cours, tu vas apprendre à construire des points',
        transcriptTimestamped: [
          WordTimestamp(word: 'Bonjour !', start: 0.11, end: 1.30),
          WordTimestamp(word: 'Dans', start: 1.30, end: 1.38),
          WordTimestamp(word: 'ce', start: 1.38, end: 1.45),
          WordTimestamp(word: 'cours,', start: 1.45, end: 1.83),
          WordTimestamp(word: 'tu', start: 2.15, end: 2.15),
          WordTimestamp(word: 'vas', start: 2.15, end: 2.61),
          WordTimestamp(word: 'apprendre', start: 2.61, end: 3.08),
          WordTimestamp(word: 'à', start: 3.08, end: 3.16),
          WordTimestamp(word: 'construire', start: 3.16, end: 3.60),
          WordTimestamp(word: 'des', start: 3.60, end: 3.84),
          WordTimestamp(word: 'points', start: 3.84, end: 4.18),
        ],
        duration: 4.18,
        audioFile: 'vecteurs.wav',
        language: 'fr',
        compactTimeline: sampleCompact,
      );

      final result = await generator.generate(transcript, metadata);

      expect(result.idGap, 100);
      expect(result.visualsText, contains('draw 101 line'));

      // Check prompt user message contains the compact timeline directly
      final userMessage = client.lastUserMessage;
      expect(userMessage, isNotNull);
      expect(userMessage, contains('TRANSCRIPT TIMESTAMPÉ :'));
      expect(userMessage, contains('<0.110>Bonjour !<1.300>'));
      expect(userMessage, contains('<3.160>construire<3.600>'));
      expect(userMessage, contains('<3.840>points<4.180>'));

      // Verify that old 6-word grouping format [0.0s] is NOT present
      expect(userMessage, isNot(contains('[0.0s]')));
      expect(userMessage, isNot(contains('[0.1s]')));
      expect(userMessage, isNot(contains('[2.6s]')));

      // Check system prompt includes the new instructions
      final system = client.lastSystem;
      expect(system, isNotNull);
      expect(system, contains('<START>TEXT<END>'));
      expect(system, contains('<3.160>construire<3.600>'));
      expect(system, contains('pauses naturelles'));
    });

    test('correctSyntax also transmits compactTimeline directly', () async {
      const sampleCompact = '<3.160>construire<3.600>\n<3.600>des<3.840>\n<3.840>points<4.180>';

      final transcript = TranscriptResult(
        transcript: 'construire des points',
        transcriptTimestamped: [],
        duration: 4.18,
        audioFile: 'vecteurs.wav',
        language: 'fr',
        compactTimeline: sampleCompact,
      );

      await generator.correctSyntax(
        brokenScript: 'draw line at (0, 0);',
        syntaxError: 'Missing id',
        transcript: transcript,
        metadata: metadata,
      );

      final userMessage = client.lastUserMessage;
      expect(userMessage, isNotNull);
      expect(userMessage, contains('<3.160>construire<3.600>'));
      expect(userMessage, contains('<3.840>points<4.180>'));
    });

    test('falls back to transcriptTimestamped.toCompact() if compactTimeline is null', () async {
      final transcript = TranscriptResult(
        transcript: 'Bonjour ! Dans ce cours,',
        transcriptTimestamped: [
          WordTimestamp(word: 'Bonjour !', start: 0.11, end: 1.30),
          WordTimestamp(word: 'Dans', start: 1.30, end: 1.38),
          WordTimestamp(word: 'ce', start: 1.38, end: 1.45),
          WordTimestamp(word: 'cours,', start: 1.45, end: 1.83),
        ],
        duration: 1.83,
        audioFile: 'test.wav',
        language: 'fr',
      );

      await generator.generate(transcript, metadata);

      final userMessage = client.lastUserMessage;
      expect(userMessage, isNotNull);
      expect(userMessage, contains('<0.110>Bonjour !<1.300>'));
      expect(userMessage, contains('<1.450>cours,<1.830>'));
    });
  });
}
