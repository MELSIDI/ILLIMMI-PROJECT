import '../http/audio_service_client.dart';
import 'gemini_client.dart';
import 'llm_client.dart';
import 'models.dart';

/// Layer 2 : transcript complet + narration audio + alignement mot-par-mot
/// (illimmi-doc.md §2.3).
///
/// La synthèse vocale (Piper) et l'alignement mot-par-mot ne tournent plus
/// en-process : ils sont délégués au microservice `audio-service` via
/// [AudioServiceClient], qui renvoie une URL HTTP jouable directement par le
/// client Flutter (`CoursePlayer` sait déjà lire une URL `http(s)://`).
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
    final system =
        '''
Tu es un professeur qui rédige le texte intégral d'une narration de cours,
destinée à être lue par une synthèse vocale (Piper TTS). Écris uniquement le
texte parlé, sans mise en forme, sans titres, sans balises — des phrases
naturelles et fluides, comme si tu parlais directement à l'élève.

Niveau : ${metadata.level}
Durée cible : environ ${metadata.durationTarget} secondes de parole
Concepts clés à couvrir : ${metadata.conceptsCles.join(', ')}
Ton : ${metadata.ton}
Langue : ${metadata.langue}
''';

    return _client.complete(
      system: system,
      userMessage: 'Rédige la narration complète du cours sur "${metadata.subject}".',
      maxTokens: 2048,
    );
  }

  String _slugify(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
  }
}
