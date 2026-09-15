import '../http/audio_service_client.dart';
import 'gemini_client.dart';
import 'llm_client.dart';
import 'models.dart';
import 'prompt_loader.dart';

/// Layer 2 : transcript complet + narration audio + alignement mot-par-mot
/// (illimmi-doc.md §2.3).
class Layer2AudioGenerator {
  final LlmClient _client;
  final AudioServiceClient _audioClient;

  Layer2AudioGenerator({LlmClient? client, AudioServiceClient? audioClient})
    : _client = client ?? GeminiClient(),
      _audioClient = audioClient ?? AudioServiceClient();

  Future<TranscriptResult> generate(CourseMetadata metadata) async {
    final transcript = await _generateTranscript(metadata);

    final narration = await _audioClient.narrate(
      text: transcript,
      dirName: _slugify(metadata.subject),
      fileName: 'narration',
    );

    return TranscriptResult(
      transcript: transcript,
      transcriptTimestamped: narration.wordTimestamps,
      duration: narration.duration,
      audioFile: narration.audioUrl,
      language: metadata.langue,
    );
  }

  Future<String> _generateTranscript(CourseMetadata metadata) {
    final planText = metadata.planPedagogique
        .map(
          (s) =>
              '- [${s.section}] objectif: ${s.objectif} | contenu: ${s.contenuAttendu} | support visuel prévu: ${s.supportVisuelSuggere}',
        )
        .join('\n');

    // ~155 mots/minute pour une narration française posée, ton professoral.
    final targetWords = (metadata.durationTarget / 60 * 155).round();

    final system = PromptLoader.load(
      'layer2_audio_system.md',
      variables: {
        'level': metadata.level,
        'durationTarget': metadata.durationTarget.toString(),
        'targetWords': targetWords.toString(),
        'ton': metadata.ton,
        'langue': metadata.langue,
        'planText': planText,
      },
    );

    return _client.complete(
      system: system,
      userMessage:
          'Rédige la narration complète du cours sur "${metadata.subject}", en suivant scrupuleusement le plan pédagogique fourni.',
      maxTokens: 16384,
    );
  }

  String _slugify(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
  }
}

