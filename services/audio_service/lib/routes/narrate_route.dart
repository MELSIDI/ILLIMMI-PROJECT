import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../align/word_aligner.dart';
import '../tts/piper_service.dart';

/// `POST /narrate` `{"text","dirName","fileName"}` →
/// `{"audioUrl","duration","wordTimestamps"}`.
///
/// Synthétise la voix (Piper) puis aligne le résultat mot-par-mot, et
/// construit l'URL publique du fichier `.wav` servi par le handler statique
/// monté sur `/audios` (voir `bin/server.dart`).
Handler createNarrateHandler({
  required PiperServices piper,
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
    if (text == null || dirName == null || fileName == null) {
      return Response(
        400,
        body: jsonEncode({'error': 'Champs requis: text, dirName, fileName'}),
      );
    }

    try {
      final ttsResult = await piper.tts(text: text, dirName: dirName, fileName: fileName);
      if (ttsResult == null || ttsResult.file == null) {
        return Response.internalServerError(
          body: jsonEncode({'error': 'Échec de la synthèse Piper.'}),
        );
      }

      final wordTimestamps = await aligner.align(wavPath: ttsResult.file!.path);

      return Response.ok(
        jsonEncode({
          'audioUrl': '$publicBaseUrl/audios/$dirName/$fileName.wav',
          'duration': ttsResult.duration,
          'wordTimestamps': wordTimestamps.map((w) => w.toJson()).toList(),
        }),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      return Response.internalServerError(body: jsonEncode({'error': e.toString()}));
    }
  };
}
