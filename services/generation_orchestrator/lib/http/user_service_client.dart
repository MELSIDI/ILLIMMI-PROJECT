import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

/// Client HTTP vers le microservice `user-service`, pour persister
/// l'historique d'un cours une fois généré. Appelé serveur-à-serveur par
/// `JobStore`, jamais par le client Flutter directement.
class UserServiceClient {
  final String baseUrl;

  UserServiceClient({String? baseUrl})
    : baseUrl =
          baseUrl ??
          Platform.environment['USER_SERVICE_URL'] ??
          'http://localhost:8081';

  Future<void> postHistory({
    required String token,
    required String prompt,
    required String subject,
    required String script,
    required String audioUrl,
    required double duration,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/history'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'prompt': prompt,
        'subject': subject,
        'script': script,
        'audioUrl': audioUrl,
        'duration': duration,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception(
        'user-service /history a échoué (${response.statusCode}): ${response.body}',
      );
    }
  }
}
