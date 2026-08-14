import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:generation_orchestrator/http/audio_service_client.dart';
import 'package:generation_orchestrator/http/board_render_service_client.dart';
import 'package:generation_orchestrator/job/generation_job.dart';
import 'package:generation_orchestrator/job/job_store.dart';
import 'package:generation_orchestrator/models/course.dart';
import 'package:generation_orchestrator/pipeline/board_capture_planner.dart';
import 'package:generation_orchestrator/pipeline/claude_client.dart';
import 'package:generation_orchestrator/pipeline/models.dart';

/// [ClaudeClient] a des méthodes non-`final` : on peut donc les remplacer par
/// des réponses en boîte, sans jamais appeler le réseau.
class FakeClaudeClient extends ClaudeClient {
  final Map<String, dynamic> jsonResponse;
  final List<String> textResponses;
  final Map<String, dynamic> visualVerificationResponse;
  int _textCallIndex = 0;

  FakeClaudeClient({
    required this.jsonResponse,
    required this.textResponses,
    this.visualVerificationResponse = const {'ok': true, 'issues': []},
  });

  @override
  Future<Map<String, dynamic>> completeJson({
    required String system,
    required String userMessage,
    required Map<String, dynamic> schema,
    int maxTokens = 2048,
  }) async {
    if (schema.containsKey('properties') &&
        (schema['properties'] as Map).containsKey('idgap')) {
      final response = textResponses[_textCallIndex];
      if (_textCallIndex < textResponses.length - 1) _textCallIndex++;
      return {
        'idgap': 100,
        'visualsText': response,
      };
    }
    return jsonResponse;
  }


  @override
  Future<String> complete({
    required String system,
    required String userMessage,
    int maxTokens = 4096,
  }) async {
    final response = textResponses[_textCallIndex];
    if (_textCallIndex < textResponses.length - 1) _textCallIndex++;
    return response;
  }

  @override
  Future<Map<String, dynamic>> completeMultimodalJson({
    required String system,
    required List<ContentBlock> content,
    required Map<String, dynamic> schema,
    int maxTokens = 4096,
  }) async => visualVerificationResponse;
}

/// Évite tout appel HTTP réel à `board-render-service` : renvoie des PNG
/// vides (leur contenu n'a pas d'importance ici, seul l'enchaînement compte).
class FakeBoardRenderServiceClient extends BoardRenderServiceClient {
  FakeBoardRenderServiceClient() : super(baseUrl: 'http://fake');

  @override
  Future<List<CapturedImage>> renderBatch(Course course, CaptureBatch batch) async {
    return batch.points
        .map(
          (p) => CapturedImage(triggerElementIds: p.triggerElementIds, bytes: Uint8List(0)),
        )
        .toList();
  }
}

/// Évite tout appel HTTP réel à `audio-service` : renvoie une URL/durée en
/// boîte, comme le ferait un vrai appel `POST /narrate`.
class FakeAudioServiceClient extends AudioServiceClient {
  FakeAudioServiceClient() : super(baseUrl: 'http://fake');

  @override
  Future<NarrateResult> narrate({
    required String text,
    required String dirName,
    required String fileName,
  }) async {
    return NarrateResult(
      audioUrl: 'http://localhost:8082/audios/$dirName/$fileName.wav',
      duration: 10.0,
      wordTimestamps: [WordTimestamp(word: 'bonjour', start: 0.0, end: 0.5)],
    );
  }
}

const _metadataJson = {
  'subject': 'Les Dérivées',
  'level': 'Terminale',
  'duration_target': 90,
  'concepts_cles': ['limite', 'tangente'],
  'ton': 'pédagogique',
  'langue': 'fr',
};

/// Poll `jobStore.get(jobId)` jusqu'à ce qu'il atteigne `done`/`error` —
/// équivalent du polling que fait le client Flutter contre l'API HTTP.
Future<GenerationJob> _waitForCompletion(JobStore jobStore, String jobId) async {
  for (var i = 0; i < 100; i++) {
    final job = jobStore.get(jobId)!;
    if (job.status == 'done' || job.status == 'error') return job;
    await Future.delayed(const Duration(milliseconds: 10));
  }
  throw StateError('Le job $jobId n\'a pas terminé à temps.');
}

void main() {
  test('startJob() aboutit quand le Layer 3 produit un script valide du premier coup', () async {
    const validVisuals =
        "text id 1 start 1.5s at (88.89, 8) ''[bold]Les Dérivées[/bold]'' ;";

    final jobStore = JobStore(
      claudeClient: FakeClaudeClient(
        jsonResponse: _metadataJson,
        textResponses: ['Bonjour, ceci est le transcript.', validVisuals],
      ),
      audioServiceClient: FakeAudioServiceClient(),
      boardRenderServiceClient: FakeBoardRenderServiceClient(),
    );

    final jobId = jobStore.startJob('Explique-moi les dérivées');
    final job = await _waitForCompletion(jobStore, jobId);

    expect(job.status, 'done');
    expect(job.script, contains('course "Les Dérivées"'));
    expect(job.script, contains(validVisuals));
    expect(job.audioUrl, isNotNull);
  });

  test('startJob() retente le Layer 3 quand le premier script échoue au parsing', () async {
    // ID 9999 dépasse toute plage de famille valide pour idgap 100
    // (IdConfig.getFamilyIndex) → doit faire échouer le parsing.
    const invalidVisuals = "text id 9999 start 1s at (0, 0) ''x'' ;";
    const validVisuals =
        "text id 1 start 1.5s at (88.89, 8) ''[bold]Les Dérivées[/bold]'' ;";

    final jobStore = JobStore(
      claudeClient: FakeClaudeClient(
        jsonResponse: _metadataJson,
        textResponses: [
          'Bonjour, ceci est le transcript.',
          invalidVisuals,
          validVisuals,
        ],
      ),
      audioServiceClient: FakeAudioServiceClient(),
      boardRenderServiceClient: FakeBoardRenderServiceClient(),
    );

    final jobId = jobStore.startJob('Explique-moi les dérivées');
    final job = await _waitForCompletion(jobStore, jobId);

    expect(job.status, 'done');
    expect(job.script, contains(validVisuals));
    expect(job.script, isNot(contains('9999')));
  });

  test(
    'startJob() retente le Layer 3 quand la vérification visuelle détecte un problème',
    () async {
      const validVisuals =
          "text id 1 start 1.5s at (88.89, 8) ''[bold]Les Dérivées[/bold]'' ;";

      final jobStore = JobStore(
        claudeClient: FakeClaudeClient(
          jsonResponse: _metadataJson,
          // Le script parse correctement les deux fois : seule la
          // vérification visuelle échoue à la première tentative.
          textResponses: [
            'Bonjour, ceci est le transcript.',
            validVisuals,
            validVisuals,
          ],
          visualVerificationResponse: {
            'ok': false,
            'issues': [
              {'elementId': 1, 'description': 'Le texte déborde du cadre du tableau.'},
            ],
          },
        ),
        audioServiceClient: FakeAudioServiceClient(),
        boardRenderServiceClient: FakeBoardRenderServiceClient(),
      );

      final jobId = jobStore.startJob('Explique-moi les dérivées');
      final job = await _waitForCompletion(jobStore, jobId);

      expect(job.status, 'error');
      expect(job.error, contains('déborde du cadre du tableau'));
    },
  );

  test('startJob() fonctionne de bout en bout avec Gemini (FakeGeminiClient)', () async {
    const validVisuals =
        "text id 1 start 1.5s at (88.89, 8) ''[bold]Les Dérivées[/bold]'' ;";

    final jobStore = JobStore(
      llmClient: FakeGeminiClient(
        jsonResponse: _metadataJson,
        textResponses: ['Narration Gemini...', validVisuals],
      ),
      audioServiceClient: FakeAudioServiceClient(),
      boardRenderServiceClient: FakeBoardRenderServiceClient(),
    );

    final jobId = jobStore.startJob('Explique-moi les dérivées');
    final job = await _waitForCompletion(jobStore, jobId);

    expect(job.status, 'done');
    expect(job.script, contains('course "Les Dérivées"'));
    expect(job.script, contains(validVisuals));
  });
}

class FakeGeminiClient extends FakeClaudeClient {
  FakeGeminiClient({
    required super.jsonResponse,
    required super.textResponses,
    super.visualVerificationResponse,
  });
}

