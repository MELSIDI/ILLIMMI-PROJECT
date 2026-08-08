import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../pipeline/models.dart';

class NarrateResult {
  final String audioUrl;
  final double duration;
  final List<WordTimestamp> wordTimestamps;

  NarrateResult({
    required this.audioUrl,
    required this.duration,
    required this.wordTimestamps,
  });
}

/// Client HTTP vers le microservice `audio-service` (TTS Piper + alignement
/// mot-à-mot), base URL configurable via `AUDIO_SERVICE_URL`.
class AudioServiceClient {
  final String baseUrl;

  AudioServiceClient({String? baseUrl})
    : baseUrl =
          baseUrl ??
          Platform.environment['AUDIO_SERVICE_URL'] ??
          'http://localhost:8082';

  Future<NarrateResult> narrate({
    required String text,
    required String dirName,
    required String fileName,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/narrate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'text': text, 'dirName': dirName, 'fileName': fileName}),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Erreur audio-service (${response.statusCode}): ${response.body}',
      );
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final words = (body['wordTimestamps'] as List)
        .map((w) => WordTimestamp.fromJson(w as Map<String, dynamic>))
        .toList();

    return NarrateResult(
      audioUrl: body['audioUrl'] as String,
      duration: (body['duration'] as num).toDouble(),
      wordTimestamps: words,
    );
  }
}
