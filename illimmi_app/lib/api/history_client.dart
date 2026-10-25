import 'dart:convert';

import 'package:http/http.dart' as http;

import 'generation_client.dart';

/// Une entrée d'historique — enveloppe [GenerationResult] (déjà utilisé pour
/// le résultat d'une génération en direct) plutôt que de dupliquer un
/// modèle parallèle : `result` est directement rejouable dans `CoursePlayer`
/// sans repasser par `generation-orchestrator`.
class HistoryEntry {
  final String id;
  final String prompt;
  final String? subject;
  final DateTime createdAt;
  final GenerationResult result;

  HistoryEntry({
    required this.id,
    required this.prompt,
    required this.subject,
    required this.createdAt,
    required this.result,
  });

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => HistoryEntry(
    id: json['id'] as String,
    prompt: json['prompt'] as String,
    subject: json['subject'] as String?,
    createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    result: GenerationResult(
      script: json['script'] as String,
      audioUrl: json['audioUrl'] as String,
      duration: (json['duration'] as num).toDouble(),
    ),
  );
}

/// Client HTTP vers `user-service` pour l'historique des cours générés.
/// Supporte à la fois les utilisateurs connectés et le mode invité.
class HistoryClient {
  final String baseUrl;

  HistoryClient({this.baseUrl = 'http://localhost:8081'});

  Future<List<HistoryEntry>> getHistory([String? token]) async {
    final uri = (token != null && token.isNotEmpty)
        ? Uri.parse('$baseUrl/history')
        : Uri.parse('$baseUrl/history?guest=true');

    final response = await http.get(
      uri,
      headers: {
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Échec de récupération de l\'historique (${response.statusCode}): ${response.body}',
      );
    }

    final list = jsonDecode(response.body) as List;
    return list.map((e) => HistoryEntry.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> deleteHistory(String id, [String? token]) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/history/$id'),
      headers: {
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Échec de suppression (${response.statusCode}): ${response.body}');
    }
  }
}
