import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../pipeline/models.dart';

class NarrateResult {
  final String audioUrl;
  final double duration;
  final List<WordTimestamp> wordTimestamps;
  final String? compactTimeline;
  final String? wordsUrl;

  NarrateResult({
    required this.audioUrl,
    required this.duration,
    required this.wordTimestamps,
    this.compactTimeline,
    this.wordsUrl,
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
    final compactTimeline = body['compactTimeline'] as String?;
    final wordsUrl = body['wordsUrl'] as String?;

    List<WordTimestamp> words;
    if (body['wordTimestamps'] is List) {
      words = (body['wordTimestamps'] as List)
          .map((w) => WordTimestamp.fromJson(w as Map<String, dynamic>))
          .toList();
    } else if (compactTimeline != null && compactTimeline.isNotEmpty) {
      words = compactTimeline
          .split('\n')
          .map((l) => l.trim())
          .where((l) => l.isNotEmpty)
          .map((l) => WordTimestamp.fromCompact(l))
          .toList();
    } else {
      words = [];
    }

    return NarrateResult(
      audioUrl: body['audioUrl'] as String,
      duration: (body['duration'] as num).toDouble(),
      wordTimestamps: words,
      compactTimeline: compactTimeline,
      wordsUrl: wordsUrl,
    );
  }
}
