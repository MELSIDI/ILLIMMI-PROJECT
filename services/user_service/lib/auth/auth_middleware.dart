import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import 'jwt_service.dart';

const _jsonHeaders = {'Content-Type': 'application/json'};

/// Middleware shelf : exige un `Authorization: Bearer <token>` valide,
/// injecte `userId` dans le contexte de la requête pour les handlers en
/// aval, ou court-circuite avec 401 sinon.
Middleware requireAuth() {
  return (Handler innerHandler) {
    return (Request request) async {
      final header = request.headers['authorization'];
      if (header == null || !header.startsWith('Bearer ')) {
        return Response(401, body: jsonEncode({'error': 'missing bearer token'}), headers: _jsonHeaders);
      }

      final token = header.substring(7);
      try {
        final userId = JwtService.verifyAndGetUserId(token);
        return await innerHandler(request.change(context: {'userId': userId}));
      } on JWTExpiredException {
        return Response(401, body: jsonEncode({'error': 'token expired'}), headers: _jsonHeaders);
      } catch (_) {
        return Response(401, body: jsonEncode({'error': 'invalid token'}), headers: _jsonHeaders);
      }
    };
  };
}
