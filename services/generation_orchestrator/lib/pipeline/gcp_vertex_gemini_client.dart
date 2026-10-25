import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'llm_client.dart';

/// Client Gemini orienté Google Cloud Platform (GCP Vertex AI / BigQuery).
///
/// Ce client utilise directement les crédits GCP ($300 offerts, crédits BigQuery / entreprise)
/// rattachés au compte de facturation (GCP Billing Account) du projet GCP.
///
/// Variables d'environnement supportées :
/// - `GCP_PROJECT_ID` ou `BIGQUERY_PROJECT_ID` : ID du projet Google Cloud (Obligatoire).
/// - `GCP_ACCESS_TOKEN` ou `BIGQUERY_ACCESS_TOKEN` : Jeton OAuth2 Bearer (`gcloud auth print-access-token`) (Obligatoire).
/// - `GCP_LOCATION` : Région GCP (défaut : `us-central1`).
/// - `GEMINI_MODEL` : Modèle Gemini (défaut : `gemini-3.8-flash`).
/// - `USE_BIGQUERY_SQL` : `true` pour exécuter la requête via SQL BigQuery `ML.GENERATE_TEXT`, `false` (défaut) pour l'API Vertex AI.
class GcpVertexGeminiClient implements LlmClient {
  static const String _defaultModel = 'gemini-3.8-flash';
  static const String _defaultLocation = 'us-central1';



  String get model => Platform.environment['GEMINI_MODEL'] ?? _defaultModel;
  String get location => Platform.environment['GCP_LOCATION'] ?? _defaultLocation;

  String get projectId {
    final pid = Platform.environment['GCP_PROJECT_ID'] ??
        Platform.environment['BIGQUERY_PROJECT_ID'];
    if (pid == null || pid.isEmpty) {
      throw Exception(
        'GCP_PROJECT_ID (ou BIGQUERY_PROJECT_ID) n\'est pas définie. '
        'Définis votre ID de projet Google Cloud pour utiliser vos crédits GCP (\$300).\n'
        'Exemple: export GCP_PROJECT_ID="mon-projet-gcp"',
      );
    }
    return pid;
  }

  String get accessToken {
    final token = Platform.environment['GCP_ACCESS_TOKEN'] ??
        Platform.environment['BIGQUERY_ACCESS_TOKEN'];
    if (token == null || token.isEmpty) {
      throw Exception(
        'GCP_ACCESS_TOKEN (ou BIGQUERY_ACCESS_TOKEN) n\'est pas définie. '
        'Générez un jeton GCP avec gcloud :\n'
        'export GCP_ACCESS_TOKEN=\$(gcloud auth print-access-token)',
      );
    }
    return token;
  }

  /// Endpoint direct Vertex AI (Déduit les requêtes du solde GCP / \$300 crédits)
  String get _vertexEndpoint =>
      'https://$location-aiplatform.googleapis.com/v1/projects/$projectId/locations/$location/publishers/google/models/$model:generateContent';

  /// Endpoint SQL BigQuery REST API
  String get _bigqueryEndpoint =>
      'https://bigquery.googleapis.com/bigquery/v2/projects/$projectId/queries';

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

  bool get _useBigQuerySql =>
      (Platform.environment['USE_BIGQUERY_SQL'] ?? '').toLowerCase() == 'true';

  @override
  Future<String> complete({
    required String system,
    required String userMessage,
    int maxTokens = 8192,
  }) async {
    if (_useBigQuerySql) {
      return _completeViaBigQuerySql(system: system, userMessage: userMessage, maxTokens: maxTokens);
    }

    final response = await http.post(
      Uri.parse(_vertexEndpoint),
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
    int maxTokens = 8192,
  }) async {
    final sanitizedSchema = _sanitizeSchema(schema);

    if (_useBigQuerySql) {
      final promptWithSchema = '$userMessage\n\nFormat direct de réponse requis: JSON strict respectant le schéma.';
      final rawText = await _completeViaBigQuerySql(
        system: system,
        userMessage: promptWithSchema,
        maxTokens: maxTokens,
      );
      return jsonDecode(_cleanJsonText(rawText)) as Map<String, dynamic>;
    }

    final response = await http.post(
      Uri.parse(_vertexEndpoint),
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
    return jsonDecode(_cleanJsonText(text)) as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> completeMultimodalJson({
    required String system,
    required List<ContentBlock> content,
    required Map<String, dynamic> schema,
    int maxTokens = 8192,
  }) async {
    final sanitizedSchema = _sanitizeSchema(schema);
    final response = await http.post(
      Uri.parse(_vertexEndpoint),
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
    return jsonDecode(_cleanJsonText(text)) as Map<String, dynamic>;
  }

  /// Implémentation via l'API BigQuery ML `ML.GENERATE_TEXT`
  Future<String> _completeViaBigQuerySql({
    required String system,
    required String userMessage,
    int maxTokens = 4096,
  }) async {
    final dataset = Platform.environment['BIGQUERY_DATASET'] ?? 'llm_dataset';
    final modelName = Platform.environment['BIGQUERY_MODEL_NAME'] ?? 'gemini_model';
    final fullPrompt = '$system\n\n$userMessage';

    final sqlQuery = '''
      SELECT ml_generate_text_result 
      FROM ML.GENERATE_TEXT(
        MODEL `$projectId.$dataset.$modelName`,
        (SELECT @prompt AS prompt),
        STRUCT(0.2 AS temperature, @max_tokens AS max_output_tokens)
      )
    ''';

    final response = await http.post(
      Uri.parse(_bigqueryEndpoint),
      headers: _headers,
      body: jsonEncode({
        'query': sqlQuery,
        'queryParameters': [
          {
            'name': 'prompt',
            'parameterType': {'type': 'STRING'},
            'parameterValue': {'value': fullPrompt},
          },
          {
            'name': 'max_tokens',
            'parameterType': {'type': 'INT64'},
            'parameterValue': {'value': maxTokens.toString()},
          },
        ],
        'useLegacySql': false,
      }),
    );

    final body = _decodeOrThrow(response);
    final rows = body['rows'] as List?;
    if (rows == null || rows.isEmpty) {
      throw Exception('Aucune ligne retournée par BigQuery ML: $body');
    }

    final firstRow = rows.first as Map<String, dynamic>;
    final fList = firstRow['f'] as List?;
    if (fList == null || fList.isEmpty) {
      throw Exception('Format de réponse BigQuery inattendu: $body');
    }

    final resultJsonStr = (fList.first as Map<String, dynamic>)['v'] as String;
    final parsedResult = jsonDecode(resultJsonStr) as Map<String, dynamic>;
    return _extractText(parsedResult);
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
            'inlineData': {
              'mimeType': block.mediaType,
              'data': base64Encode(block.bytes),
            },
          },
      };

  Map<String, dynamic> _decodeOrThrow(http.Response response) {
    if (response.statusCode != 200) {
      throw Exception(
        'Erreur API GCP/Vertex/BigQuery (${response.statusCode}): ${response.body}',
      );
    }
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  String _extractText(Map<String, dynamic> body) {
    final candidates = body['candidates'] as List?;
    if (candidates == null || candidates.isEmpty) {
      throw Exception('Aucun candidat dans la réponse Gemini GCP: $body');
    }
    final parts = (candidates.first as Map<String, dynamic>)['content']?['parts'] as List?;
    if (parts == null || parts.isEmpty) {
      throw Exception('Aucune partie de contenu dans la réponse Gemini GCP: $body');
    }
    return (parts.first as Map<String, dynamic>)['text'] as String;
  }

  String _cleanJsonText(String raw) {
    var text = raw.trim();
    if (text.startsWith('```json')) {
      text = text.substring(7);
    } else if (text.startsWith('```')) {
      text = text.substring(3);
    }
    if (text.endsWith('```')) {
      text = text.substring(0, text.length - 3);
    }
    return text.trim();
  }
}

/// Alias pour la dénomination BigQueryGeminiClient
typedef BigQueryGeminiClient = GcpVertexGeminiClient;
