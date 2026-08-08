import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'content_block.dart';

/// Client HTTP brut pour l'API Generative Language de Google (Gemini) — même
/// contrat que [ClaudeClient] (`../pipeline/claude_client.dart`), pas de SDK
/// officiel.
///
/// La clé est lue depuis la variable d'environnement `GEMINI_API_KEY` —
/// jamais en dur dans le code. Le modèle est surchargeable via `GEMINI_MODEL`
/// (défaut `gemini-2.5-flash`) : à vérifier/ajuster selon le modèle
/// effectivement disponible au moment de l'usage, les identifiants de modèle
/// évoluent plus vite que ce code.
class GeminiClient {
  static const String _defaultModel = 'gemini-2.5-flash';
  static const String _apiVersion = 'v1beta';

  String get model => Platform.environment['GEMINI_MODEL'] ?? _defaultModel;

  String get _endpoint =>
      'https://generativelanguage.googleapis.com/$_apiVersion/models/$model:generateContent';

  String get _apiKey {
    final key = Platform.environment['GEMINI_API_KEY'];
    if (key == null || key.isEmpty) {
      throw Exception(
        'GEMINI_API_KEY n\'est pas définie. '
        'Exporte-la dans ton environnement avant de lancer le service : '
        'export GEMINI_API_KEY="..."',
      );
    }
    return key;
  }

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'x-goog-api-key': _apiKey,
  };

  /// Complétion texte simple (pas de sortie JSON contrainte).
  Future<String> complete({
    required String system,
    required String userMessage,
    int maxTokens = 4096,
  }) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: _headers,
      body: jsonEncode({
        'systemInstruction': {
          'parts': [
            {'text': system},
          ],
        },
        'contents': [
          {
            'role': 'user',
            'parts': [
              {'text': userMessage},
            ],
          },
        ],
        'generationConfig': {'maxOutputTokens': maxTokens},
      }),
    );

    final body = _decodeOrThrow(response);
    return _extractText(body);
  }

  /// Complétion contrainte par un schéma JSON (`generationConfig.responseSchema`)
  /// — Gemini n'accepte qu'un sous-ensemble de JSON Schema (pas de `$schema`,
  /// `additionalProperties`, etc.) ; un schéma trop riche peut être rejeté ou
  /// simplifié silencieusement côté API.
  Future<Map<String, dynamic>> completeJson({
    required String system,
    required String userMessage,
    required Map<String, dynamic> schema,
    int maxTokens = 2048,
  }) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: _headers,
      body: jsonEncode({
        'systemInstruction': {
          'parts': [
            {'text': system},
          ],
        },
        'contents': [
          {
            'role': 'user',
            'parts': [
              {'text': userMessage},
            ],
          },
        ],
        'generationConfig': {
          'maxOutputTokens': maxTokens,
          'responseMimeType': 'application/json',
          'responseSchema': schema,
        },
      }),
    );

    final body = _decodeOrThrow(response);
    final text = _extractText(body);
    return jsonDecode(text) as Map<String, dynamic>;
  }

  /// Complétion multimodale (texte + images) contrainte par un schéma JSON —
  /// chaque [ImageBlock] devient une partie `inlineData` (base64), chaque
  /// [TextBlock] une partie `text`, dans l'ordre reçu.
  Future<Map<String, dynamic>> completeMultimodalJson({
    required String system,
    required List<ContentBlock> content,
    required Map<String, dynamic> schema,
    int maxTokens = 4096,
  }) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: _headers,
      body: jsonEncode({
        'systemInstruction': {
          'parts': [
            {'text': system},
          ],
        },
        'contents': [
          {'role': 'user', 'parts': content.map(_partFor).toList()},
        ],
        'generationConfig': {
          'maxOutputTokens': maxTokens,
          'responseMimeType': 'application/json',
          'responseSchema': schema,
        },
      }),
    );

    final body = _decodeOrThrow(response);
    final text = _extractText(body);
    return jsonDecode(text) as Map<String, dynamic>;
  }

  Map<String, dynamic> _partFor(ContentBlock block) => switch (block) {
    TextBlock() => {'text': block.text},
    ImageBlock() => {
      'inlineData': {'mimeType': block.mediaType, 'data': base64Encode(block.bytes)},
    },
  };

  Map<String, dynamic> _decodeOrThrow(http.Response response) {
    if (response.statusCode != 200) {
      throw Exception(
        'Erreur API Gemini (${response.statusCode}): ${response.body}',
      );
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  String _extractText(Map<String, dynamic> body) {
    final candidates = body['candidates'] as List?;
    if (candidates == null || candidates.isEmpty) {
      throw Exception('Aucun candidat dans la réponse Gemini: $body');
    }
    final parts = (candidates.first as Map<String, dynamic>)['content']?['parts'] as List?;
    if (parts == null || parts.isEmpty) {
      throw Exception('Aucune partie de contenu dans la réponse Gemini: $body');
    }
    return (parts.first as Map<String, dynamic>)['text'] as String;
  }
}
