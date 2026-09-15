import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'llm_client.dart';

/// Client HTTP brut pour l'API DeepSeek — implémente [LlmClient].
class DeepSeekClient implements LlmClient {
  static const String _defaultModel = 'deepseek-chat';
  static const String _endpoint = 'https://api.deepseek.com/chat/completions';

  String get model => Platform.environment['DEEPSEEK_MODEL'] ?? _defaultModel;

  String get _apiKey {
    final key = Platform.environment['DEEPSEEK_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception(
        'DEEPSEEK_API_KEY n\'est pas définie. '
        'Exporte-la dans ton environnement avant de lancer le service : '
        'export DEEPSEEK_API_KEY="..."',
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

  /// Complétion JSON — mode `json_object` (syntaxe garantie) + schéma injecté
  /// dans le prompt système (pas de validation stricte côté serveur, voir la
  /// limite documentée en tête de fichier).
  @override
  Future<Map<String, dynamic>> completeJson({
    required String system,
    required String userMessage,
    required Map<String, dynamic> schema,
    int maxTokens = 8192,
  }) async {
    final systemWithSchema =
        '$system\n\n'
        'Réponds uniquement avec un objet JSON valide respectant strictement '
        'ce schéma JSON, sans texte autour :\n${jsonEncode(schema)}';

    final response = await http.post(
      Uri.parse(_endpoint),
      headers: _headers,
      body: jsonEncode({
        'model': model,
        'max_tokens': maxTokens,
        'messages': [
          {'role': 'system', 'content': systemWithSchema},
          {'role': 'user', 'content': userMessage},
        ],
        'response_format': {'type': 'json_object'},
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
        'JSON invalide renvoyé par DeepSeek ($e). Texte reçu: $cleaned',
      );
    }
  }

  /// Non supporté : l'API DeepSeek n'accepte pas d'images en entrée. Existe
  /// pour garder le même contrat que [ClaudeClient]/`GeminiClient`/
  /// `OpenAiClient`, mais échoue explicitement plutôt que d'ignorer les
  /// images passées dans [content].
  @override
  Future<Map<String, dynamic>> completeMultimodalJson({
    required String system,
    required List<ContentBlock> content,
    required Map<String, dynamic> schema,
    int maxTokens = 4096,
  }) async {
    throw UnsupportedError(
      'DeepSeekClient.completeMultimodalJson : l\'API DeepSeek ne supporte '
      'pas les entrées image (pas d\'équivalent vision). Utilise ClaudeClient, '
      'GeminiClient ou OpenAiClient pour la vérification visuelle.',
    );
  }

  Map<String, dynamic> _decodeOrThrow(http.Response response) {
    if (response.statusCode != 200) {
      throw Exception(
        'Erreur API DeepSeek (${response.statusCode}): ${response.body}',
      );
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  String _extractText(Map<String, dynamic> body) {
    final choices = body['choices'] as List?;
    if (choices == null || choices.isEmpty) {
      throw Exception('Aucun choix dans la réponse DeepSeek: $body');
    }
    final message = (choices.first as Map<String, dynamic>)['message'] as Map<String, dynamic>?;
    final text = message?['content'] as String?;
    if (text == null) {
      throw Exception('Aucun contenu texte dans la réponse DeepSeek: $body');
    }
    return text;
  }
}
