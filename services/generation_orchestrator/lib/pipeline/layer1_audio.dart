import '../http/audio_service_client.dart';
import 'gemini_client.dart';
import 'llm_client.dart';
import 'models.dart';
import 'prompt_loader.dart';

/// Layer 1 : Narration orale complète du professeur + audio (Piper TTS)
/// + alignement mot-à-mot (Whisper).
///
/// L'ancien Layer 1 (planificateur bureaucratique) a été supprimé pour donner
/// une liberté pédagogique totale au professeur, sans contrainte de durée ni
/// découpage rigide imposé.
class Layer1AudioGenerator {
  final LlmClient _client;
  final AudioServiceClient _audioClient;

  Layer1AudioGenerator({LlmClient? client, AudioServiceClient? audioClient})
    : _client = client ?? GeminiClient(),
      _audioClient = audioClient ?? AudioServiceClient();

  /// Génère directement le transcript oral à partir du prompt utilisateur,
  /// avec niveau et langue optionnels.
  Future<TranscriptResult> generate(
    String prompt, {
    String? level,
    String language = 'français',
    CourseMetadata? metadata,
  }) async {
    final effectivePrompt = metadata?.subject ?? prompt;
    final effectiveLevel = level ?? metadata?.level;
    final effectiveLangue = metadata?.langue ?? language;

    final transcript = await _generateTranscript(
      prompt: effectivePrompt,
      level: effectiveLevel,
      langue: effectiveLangue,
    );

    final narration = await _audioClient.narrate(
      text: transcript,
      dirName: _slugify(effectivePrompt),
      fileName: 'narration',
    );

    return TranscriptResult(
      subject: effectivePrompt,
      transcript: transcript,
      transcriptTimestamped: narration.wordTimestamps,
      duration: narration.duration,
      audioFile: narration.audioUrl,
      language: effectiveLangue,
      compactTimeline: narration.compactTimeline,
    );
  }

  Future<String> _generateTranscript({
    required String prompt,
    String? level,
    required String langue,
  }) {
    final levelInfo = (level != null && level.trim().isNotEmpty)
        ? 'NIVEAU CIBLE : $level'
        : 'NIVEAU : Non précisé (adapte une explication claire et universelle)';

    final system = PromptLoader.load(
      'layer1_audio_system.md',
      variables: {
        'prompt': prompt,
        'levelInfo': levelInfo,
        'langue': langue,
      },
    );

    return _client.complete(
      system: system,
      userMessage: 'Rédige l\'explication orale complète du cours pour : "$prompt".',
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

/// Alias rétro-compatible
typedef Layer2AudioGenerator = Layer1AudioGenerator;
