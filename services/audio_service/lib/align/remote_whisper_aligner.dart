import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models.dart';
import 'word_aligner.dart';

/// Alignement mot-par-mot à distance, via l'API Whisper d'OpenAI
/// (`POST /v1/audio/transcriptions`, `timestamp_granularities=word`).
///
/// La clé est lue depuis la variable d'environnement `OPENAI_API_KEY` —
/// jamais en dur dans le code.
class RemoteWhisperAligner implements WordAligner {
  static const String _endpoint =
      'https://api.openai.com/v1/audio/transcriptions';

  String get _apiKey {
    final key = Platform.environment['OPENAI_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception(
        'OPENAI_API_KEY n\'est pas définie. '
        'Exporte-la dans ton environnement avant d\'utiliser RemoteWhisperAligner : '
        'export OPENAI_API_KEY="sk-..."',
      );
    }
    return key;
  }

  @override
  Future<List<WordTimestamp>> align({required String wavPath}) async {
    final request = http.MultipartRequest('POST', Uri.parse(_endpoint))
      ..headers['Authorization'] = 'Bearer $_apiKey'
      ..fields['model'] = 'whisper-1'
      ..fields['response_format'] = 'verbose_json'
      ..fields['timestamp_granularities[]'] = 'word'
      ..files.add(await http.MultipartFile.fromPath('file', wavPath));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception(
        'Erreur API Whisper (OpenAI) (${response.statusCode}): ${response.body}',
      );
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final words = body['words'] as List? ?? [];

    return words
        .map(
          (w) => WordTimestamp(
            word: w['word'] as String,
            start: (w['start'] as num).toDouble(),
            end: (w['end'] as num).toDouble(),
          ),
        )
        .toList();
  }
}
