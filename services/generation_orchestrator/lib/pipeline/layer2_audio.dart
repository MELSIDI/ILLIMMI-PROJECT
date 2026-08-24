/*import '../http/audio_service_client.dart';
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
}*/


import '../http/audio_service_client.dart';
import 'gemini_client.dart';
import 'llm_client.dart';
import 'models.dart';

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

    final system =
        '''
Tu es un professeur qui rédige le texte intégral d'une narration de cours,
destinée à une synthèse vocale (Piper TTS) ET à un système qui va dessiner
des visuels EN SYNCHRONISATION avec ce que tu dis. Ta narration doit donc
guider explicitement l'oeil, pas juste informer l'oreille.

Niveau : ${metadata.level}
Durée cible : ~${metadata.durationTarget}s (~$targetWords mots)
Ton : ${metadata.ton}
Langue : ${metadata.langue}

PLAN PÉDAGOGIQUE À SUIVRE STRICTEMENT, DANS CET ORDRE :
$planText

RÈGLES DE RÉDACTION :
1. Suis le plan section par section, sans en sauter, sans les fusionner.
2. Pour toute section dont le support_visuel_suggere N'EST PAS "text",
   inclus une phrase de verbalisation explicite du geste visuel : "traçons
   la courbe de...", "regarde ce point qui se déplace sur l'axe...",
   "dessinons le cercle de rayon...", "je découpe cette figure en...".
   Ces phrases sont les ancrages qu'un système en aval utilisera pour
   savoir QUAND dessiner QUOI — sans elles, il ne dessinera rien.
3. Respecte l'ordre pédagogique : un exemple concret avant toute
   généralisation ou définition formelle, jamais l'inverse.
4. La section erreur_frequente doit nommer explicitement le piège
   ("on pourrait croire que... mais en réalité...").
5. Écris uniquement le texte parlé : pas de titres, pas de balises, pas de
   mise en forme — des phrases naturelles, fluides, comme si tu parlais
   directement à l'élève.
6. N'écris pas de résumé télégraphique : développe, prends le temps
   d'expliquer, un vrai cours n'est pas une liste à puces récitée.
''';

    return _client.complete(
      system: system,
      userMessage:
          'Rédige la narration complète du cours sur "${metadata.subject}", en suivant scrupuleusement le plan pédagogique fourni.',
      maxTokens: 3072,
    );
  }

  String _slugify(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
  }
}
