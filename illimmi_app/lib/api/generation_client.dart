import 'dart:convert';

import 'package:http/http.dart' as http;

class JobStatus {
  final String status;
  final String message;

  JobStatus({required this.status, required this.message});

  factory JobStatus.fromJson(Map<String, dynamic> json) => JobStatus(
    status: json['status'] as String,
    message: json['message'] as String? ?? '',
  );
}

class GenerationResult {
  final String script;
  final String audioUrl;
  final double duration;

  GenerationResult({
    required this.script,
    required this.audioUrl,
    required this.duration,
  });

  factory GenerationResult.fromJson(Map<String, dynamic> json) => GenerationResult(
    script: json['script'] as String,
    audioUrl: json['audioUrl'] as String,
    duration: (json['duration'] as num).toDouble(),
  );
}

/// Client HTTP vers le microservice `generation-orchestrator`, qui orchestre
/// la génération d'un cours à partir d'un prompt (Layer1 → Layer2 → Layer3 →
/// assemblage → validation), en remplacement de l'ancien `CourseGenerator`
/// in-process.
class GenerationClient {
  final String baseUrl;

  GenerationClient({this.baseUrl = 'http://localhost:8080'});

  Future<String> startGeneration(String prompt, {String? token, String? level}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/courses/generate'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'prompt': prompt,
        if (level != null && level.isNotEmpty) 'level': level,
      }),
    );
    if (response.statusCode != 202) {
      throw Exception(
        'Échec du démarrage de la génération (${response.statusCode}): ${response.body}',
      );
    }
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    return body['jobId'] as String;
  }

  Future<JobStatus> getStatus(String jobId) async {
    final response = await http.get(Uri.parse('$baseUrl/courses/$jobId/status'));
    if (response.statusCode != 200) {
      throw Exception(
        'Échec de la récupération du statut (${response.statusCode}): ${response.body}',
      );
    }
    return JobStatus.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<GenerationResult> getResult(String jobId) async {
    final response = await http.get(Uri.parse('$baseUrl/courses/$jobId'));
    if (response.statusCode != 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(body['error'] as String? ?? 'Erreur inconnue de génération.');
    }
    return GenerationResult.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
