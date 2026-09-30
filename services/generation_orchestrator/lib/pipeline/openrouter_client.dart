import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'llm_client.dart';

/// Client HTTP pour l'API Chat Completions d'OpenRouter — implémente [LlmClient].
/// Supporte les modèles comme google/gemini-2.5-flash, openai/gpt-4o-mini, anthropic/claude-3.5-sonnet, etc.
class OpenRouterClient implements LlmClient {
  static const String _defaultModel = 'google/gemini-2.5-flash';
  static const String _endpoint = 'https://openrouter.ai/api/v1/chat/completions';

  String get model => Platform.environment['OPENROUTER_MODEL'] ?? _defaultModel;

  String get _apiKey {
    final key = Platform.environment['OPENROUTER_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception(
        'OPENROUTER_API_KEY n\'est pas définie. '
        'Exporte-la dans ton environnement ou dans le fichier .env : '
        'OPENROUTER_API_KEY="sk-or-v1-..."',
      );
    }
    return key;
  }

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $_apiKey',
    'HTTP-Referer': 'https://illimmi.app',
    'X-Title': 'ILLIMMI',
  };

  /// Plafonne le nombre max de tokens pour éviter le rejet OpenRouter
  /// "You requested up to 65535 tokens, but can only afford X".
  int _effectiveMaxTokens(int maxTokens) => maxTokens > 8192 ? 8192 : maxTokens;

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
        'max_tokens': _effectiveMaxTokens(maxTokens),
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
  /// mode strict) — garantit une sortie JSON conforme au schéma.
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
        'max_tokens': _effectiveMaxTokens(maxTokens),
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
        'max_tokens': _effectiveMaxTokens(maxTokens),
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
        'JSON invalide renvoyé par OpenRouter ($e). Texte reçu: $cleaned',
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
        'Erreur API OpenRouter (${response.statusCode}): ${response.body}',
      );
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  String _extractText(Map<String, dynamic> body) {
    final choices = body['choices'] as List?;
    if (choices == null || choices.isEmpty) {
      throw Exception('Aucun choix dans la réponse OpenRouter: $body');
    }
    final message = (choices.first as Map<String, dynamic>)['message'] as Map<String, dynamic>?;
    final text = message?['content'] as String?;
    if (text == null) {
      throw Exception('Aucun contenu texte dans la réponse OpenRouter: $body');
    }
    return text;
  }
}
