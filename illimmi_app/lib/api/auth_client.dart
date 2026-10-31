import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthResult {
  final String token;
  final String userId;
  final String role;

  AuthResult({required this.token, required this.userId, this.role = 'user'});

  factory AuthResult.fromJson(Map<String, dynamic> json) =>
      AuthResult(
        token: json['token'] as String,
        userId: json['userId'] as String,
        role: json['role'] as String? ?? 'user',
      );
}

/// Client HTTP vers le microservice `user-service` (inscription/connexion).
class AuthClient {
  final String baseUrl;

  AuthClient({this.baseUrl = 'http://localhost:8081'});

  Future<AuthResult> signup(String email, String password) =>
      _authRequest('/auth/signup', email, password);

  Future<AuthResult> login(String email, String password) =>
      _authRequest('/auth/login', email, password);

  Future<AuthResult> _authRequest(String path, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      throw Exception(body['error'] as String? ?? 'Erreur d\'authentification.');
    }

    return AuthResult.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
