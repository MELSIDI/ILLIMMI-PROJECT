import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'llm_client.dart';

export 'content_block.dart';

/// Client HTTP brut pour l'API Messages de Claude — implémente le contrat unifié [LlmClient].
///
/// La clé est lue depuis la variable d'environnement `ANTHROPIC_API_KEY`.
class ClaudeClient implements LlmClient {
  static const String model = 'claude-sonnet-5';
  static const String _endpoint = 'https://api.anthropic.com/v1/messages';
  static const String _apiVersion = '2023-06-01';

  String get _apiKey {
    final key = Platform.environment['ANTHROPIC_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception(
        'ANTHROPIC_API_KEY n\'est pas définie. '
        'Exporte-la dans ton environnement avant de lancer le service : '
        'export ANTHROPIC_API_KEY="sk-ant-..."',
      );
    }
    return key;
  }

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'x-api-key': _apiKey,
    'anthropic-version': _apiVersion,
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
        'system': system,
        'messages': [
          {'role': 'user', 'content': userMessage},
        ],
      }),
    );

    final body = _decodeOrThrow(response);
    return _extractText(body);
  }

  /// Complétion contrainte par un schéma JSON (`output_config.format`) —
  /// garantit une sortie JSON valide, pas besoin de parser une réponse texte
  /// à l'aveugle.
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
        'system': system,
        'output_config': {
          'format': {'type': 'json_schema', 'schema': schema},
        },
        'messages': [
          {'role': 'user', 'content': userMessage},
        ],
      }),
    );

    final body = _decodeOrThrow(response);
    final text = _extractText(body);
    return _parseJson(text);
  }

  /// Complétion multimodale (texte + images) contrainte par un schéma JSON —
  /// même contrat que [completeJson], sauf que `content` est un tableau de
  /// [ContentBlock] au lieu d'une string, pour pouvoir joindre des captures
  /// du tableau à vérifier au script Hypercourse correspondant.
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
        'system': system,
        'output_config': {
          'format': {'type': 'json_schema', 'schema': schema},
        },
        'messages': [
          {'role': 'user', 'content': content.map((b) => b.toJson()).toList()},
        ],
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
        'JSON invalide renvoyé par Claude ($e). Texte reçu: $cleaned',
      );
    }
  }

  Map<String, dynamic> _decodeOrThrow(http.Response response) {
    if (response.statusCode != 200) {
      throw Exception(
        'Erreur API Claude (${response.statusCode}): ${response.body}',
      );
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  String _extractText(Map<String, dynamic> body) {
    final content = body['content'] as List;
    final textBlock = content.firstWhere(
      (block) => block['type'] == 'text',
      orElse: () => throw Exception(
        'Aucun bloc texte dans la réponse Claude: $body',
      ),
    );
    return textBlock['text'] as String;
  }
}
