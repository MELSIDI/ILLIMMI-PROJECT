import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:shelf/shelf.dart';

import '../align/compact_timeline.dart';
import '../align/word_aligner.dart';
import '../tts/tts_engine.dart';

/// `POST /narrate` `{"text","dirName","fileName","ttsProvider"}` →
/// `{"audioUrl","duration","wordTimestamps"}`.
///
/// Synthétise la voix (OpenRouter ou Piper local) puis aligne le résultat mot-par-mot, et
/// construit l'URL publique du fichier `.wav` servi par le handler statique
/// monté sur `/audios` (voir `bin/server.dart`).
Handler createNarrateHandler({
  required TtsEngine ttsEngine,
  required WordAligner aligner,
  required String publicBaseUrl,
}) {
  return (Request request) async {
    final Map<String, dynamic> body;
    try {
      body = jsonDecode(await request.readAsString()) as Map<String, dynamic>;
    } catch (e) {
      return Response(400, body: jsonEncode({'error': 'Corps JSON invalide: $e'}));
    }

    final text = body['text'] as String?;
    final dirName = body['dirName'] as String?;
    final fileName = body['fileName'] as String?;
    final ttsProvider = body['ttsProvider'] as String?;
    if (text == null || dirName == null || fileName == null) {
      return Response(
        400,
        body: jsonEncode({'error': 'Champs requis: text, dirName, fileName'}),
      );
    }

    try {
      final ttsResult = await ttsEngine.tts(
        text: text,
        dirName: dirName,
        fileName: fileName,
        preferredProvider: ttsProvider,
      );
      if (ttsResult == null || ttsResult.file == null) {
        return Response.internalServerError(
          body: jsonEncode({'error': 'Échec de la synthèse vocale.'}),
        );
      }

      // Sauvegarde la narration originale comme source de vérité textuelle
      final audioDir = ttsResult.file!.parent;
      final narrationFile = File(p.join(audioDir.path, 'narration.txt'));
      await narrationFile.writeAsString(text);

      final wordTimestamps = await aligner.align(
        wavPath: ttsResult.file!.path,
        narrationText: text,
        narrationPath: narrationFile.path,
      );

      final compactTimeline =
          const CompactTimelineWriter().writeToString(wordTimestamps);

      return Response.ok(
        jsonEncode({
          'audioUrl': '$publicBaseUrl/audios/$dirName/$fileName.wav',
          'wordsUrl': '$publicBaseUrl/audios/$dirName/${fileName}_words.txt',
          'duration': ttsResult.duration,
          'wordTimestamps': wordTimestamps.map((w) => w.toJson()).toList(),
          'compactTimeline': compactTimeline,
        }),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return Response.internalServerError(body: jsonEncode({'error': e.toString()}));
    }
  };
}
