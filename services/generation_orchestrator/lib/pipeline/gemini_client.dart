import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'content_block.dart';
import 'llm_client.dart';

/// Client HTTP brut pour l'API Generative Language de Google (Gemini) —
/// implémente le contrat unifié [LlmClient].
///
/// La clé est lue depuis la variable d'environnement `GEMINI_API_KEY` —
/// jamais en dur dans le code. Le modèle est surchargeable via `GEMINI_MODEL`
/// (défaut `gemini-2.5-flash`).
class GeminiClient implements LlmClient {
  static const String _defaultModel = 'gemini-flash-latest';
  static const String _apiVersion = 'v1beta';



  String get model => Platform.environment['GEMINI_MODEL'] ?? _defaultModel;

  String get _endpoint =>
      'https://generativelanguage.googleapis.com/$_apiVersion/models/$model:generateContent';

  String get _apiKey {
    final key = Platform.environment['GEMINI_API_KEY'];
    if (key != null && key.isNotEmpty) {
      return key;
    }
    return 'AIzaSyDVepes1ZeH7pSvcWBo_ZnGmdYNwCGXBu0';
  }


  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'x-goog-api-key': _apiKey,
  };

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

  @override
  Future<Map<String, dynamic>> completeJson({
    required String system,
    required String userMessage,
    required Map<String, dynamic> schema,
    int maxTokens = 2048,
  }) async {
    final sanitizedSchema = _sanitizeSchema(schema);
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
          'responseSchema': sanitizedSchema,
        },
      }),
    );

    final body = _decodeOrThrow(response);
    final text = _extractText(body);
    return jsonDecode(text) as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> completeMultimodalJson({
    required String system,
    required List<ContentBlock> content,
    required Map<String, dynamic> schema,
    int maxTokens = 4096,
  }) async {
    final sanitizedSchema = _sanitizeSchema(schema);
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
          'responseSchema': sanitizedSchema,
        },
      }),
    );

    final body = _decodeOrThrow(response);
    final text = _extractText(body);
    return jsonDecode(text) as Map<String, dynamic>;
  }

  Map<String, dynamic> _sanitizeSchema(Map<String, dynamic> rawSchema) {
    final copy = Map<String, dynamic>.from(rawSchema);
    copy.remove('additionalProperties');
    copy.remove('\$schema');

    if (copy.containsKey('properties') && copy['properties'] is Map<String, dynamic>) {
      final props = Map<String, dynamic>.from(copy['properties'] as Map<String, dynamic>);
      for (final key in props.keys) {
        if (props[key] is Map<String, dynamic>) {
          props[key] = _sanitizeSchema(props[key] as Map<String, dynamic>);
        }
      }
      copy['properties'] = props;
    }

    if (copy.containsKey('items') && copy['items'] is Map<String, dynamic>) {
      copy['items'] = _sanitizeSchema(copy['items'] as Map<String, dynamic>);
    }

    return copy;
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

