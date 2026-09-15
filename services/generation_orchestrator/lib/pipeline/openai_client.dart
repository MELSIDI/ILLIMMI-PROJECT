import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'llm_client.dart';

/// Client HTTP brut pour l'API Chat Completions d'OpenAI — implémente [LlmClient].
class OpenAiClient implements LlmClient {
  static const String _defaultModel = 'gpt-4o';
  static const String _endpoint = 'https://api.openai.com/v1/chat/completions';

  String get model => Platform.environment['OPENAI_MODEL'] ?? _defaultModel;

  String get _apiKey {
    final key = Platform.environment['OPENAI_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception(
        'OPENAI_API_KEY n\'est pas définie. '
        'Exporte-la dans ton environnement avant de lancer le service : '
        'export OPENAI_API_KEY="sk-..."',
      );
    }
    return key;
  }

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $_apiKey',
  };

  /// Complétion texte simple (pas de sortie JSON contrainte).
  @override
  Future<String> complete({
    required String system,
    required String userMessage,
    int maxTokens = 4096,
  }) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: _headers,
      body: jsonEncode({
        'model': model,
        'max_tokens': maxTokens,
        'messages': [
          {'role': 'system', 'content': system},
          {'role': 'user', 'content': userMessage},
        ],
      }),
    );

    final body = _decodeOrThrow(response);
    return _extractText(body);
  }

  /// Complétion contrainte par un schéma JSON (`response_format.json_schema`,
  /// mode strict) — garantit une sortie JSON valide et conforme au schéma.
  @override
  Future<Map<String, dynamic>> completeJson({
    required String system,
    required String userMessage,
    required Map<String, dynamic> schema,
    int maxTokens = 8192,
  }) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: _headers,
      body: jsonEncode({
        'model': model,
        'max_tokens': maxTokens,
        'messages': [
          {'role': 'system', 'content': system},
          {'role': 'user', 'content': userMessage},
        ],
        'response_format': {
          'type': 'json_schema',
          'json_schema': {'name': 'response', 'schema': schema, 'strict': true},
        },
      }),
    );

    final body = _decodeOrThrow(response);
    final text = _extractText(body);
    return _parseJson(text);
  }

  /// Complétion multimodale (texte + images) contrainte par un schéma JSON —
  /// chaque [ImageBlock] devient un bloc `image_url` (data URI base64),
  /// chaque [TextBlock] un bloc `text`, dans l'ordre reçu.
  @override
  Future<Map<String, dynamic>> completeMultimodalJson({
    required String system,
    required List<ContentBlock> content,
    required Map<String, dynamic> schema,
    int maxTokens = 8192,
  }) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: _headers,
      body: jsonEncode({
        'model': model,
        'max_tokens': maxTokens,
        'messages': [
          {'role': 'system', 'content': system},
          {'role': 'user', 'content': content.map(_partFor).toList()},
        ],
        'response_format': {
          'type': 'json_schema',
          'json_schema': {'name': 'response', 'schema': schema, 'strict': true},
        },
      }),
    );

    final body = _decodeOrThrow(response);
    final text = _extractText(body);
    return _parseJson(text);
  }

  Map<String, dynamic> _parseJson(String rawText) {
    var cleaned = rawText.trim();
    if (cleaned.startsWith('```json')) {
      cleaned = cleaned.substring(7);
    } else if (cleaned.startsWith('```')) {
      cleaned = cleaned.substring(3);
    }
    if (cleaned.endsWith('```')) {
      cleaned = cleaned.substring(0, cleaned.length - 3);
    }
    cleaned = cleaned.trim();
    try {
      return jsonDecode(cleaned) as Map<String, dynamic>;
    } catch (e) {
      throw FormatException(
        'JSON invalide renvoyé par OpenAI ($e). Texte reçu: $cleaned',
      );
    }
  }

  Map<String, dynamic> _partFor(ContentBlock block) => switch (block) {
    TextBlock() => {'type': 'text', 'text': block.text},
    ImageBlock() => {
      'type': 'image_url',
      'image_url': {'url': 'data:${block.mediaType};base64,${base64Encode(block.bytes)}'},
    },
  };

  Map<String, dynamic> _decodeOrThrow(http.Response response) {
    if (response.statusCode != 200) {
      throw Exception(
        'Erreur API OpenAI (${response.statusCode}): ${response.body}',
      );
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  String _extractText(Map<String, dynamic> body) {
    final choices = body['choices'] as List?;
    if (choices == null || choices.isEmpty) {
      throw Exception('Aucun choix dans la réponse OpenAI: $body');
    }
    final message = (choices.first as Map<String, dynamic>)['message'] as Map<String, dynamic>?;
    final text = message?['content'] as String?;
    if (text == null) {
      throw Exception('Aucun contenu texte dans la réponse OpenAI: $body');
    }
    return text;
  }
}
