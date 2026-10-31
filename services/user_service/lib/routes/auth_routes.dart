import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:uuid/uuid.dart';

import '../auth/jwt_service.dart';
import '../auth/password_hasher.dart';
import '../db/database.dart';

const _jsonHeaders = {'Content-Type': 'application/json'};
const _uuid = Uuid();

Response _errorResponse(int status, String message) =>
    Response(status, body: jsonEncode({'error': message}), headers: _jsonHeaders);

Router createAuthRouter(AppDatabase database) {
  final router = Router();

  router.post('/auth/signup', (Request request) async {
    final Map<String, dynamic> body;
    try {
      body = jsonDecode(await request.readAsString()) as Map<String, dynamic>;
    } catch (e) {
      return _errorResponse(400, 'invalid JSON body: $e');
    }

    final email = body['email'] as String?;
    final password = body['password'] as String?;
    if (email == null || email.isEmpty) return _errorResponse(400, 'missing field: email');
    if (password == null || password.isEmpty) return _errorResponse(400, 'missing field: password');

    final existing = database.db.select('SELECT id FROM users WHERE email = ?', [email]);
    if (existing.isNotEmpty) {
      return _errorResponse(409, 'email already registered');
    }

    final id = 'user_${_uuid.v4()}';
    final passwordHash = PasswordHasher.hash(password);
    final isDevEmail = email.endsWith('@illimmi.ai') || email.endsWith('@illimmi.dev');
    final role = (body['role'] as String?) ?? (isDevEmail ? 'ai_engineer' : 'user');
    await database.saveUser(
      id: id,
      email: email,
      passwordHash: passwordHash,
      role: role,
      createdAt: DateTime.now().toIso8601String(),
    );

    final token = JwtService.issue(id, email, role: role);
    return Response(201, body: jsonEncode({'token': token, 'userId': id, 'email': email, 'role': role}), headers: _jsonHeaders);
  });

  router.post('/auth/login', (Request request) async {
    final Map<String, dynamic> body;
    try {
      body = jsonDecode(await request.readAsString()) as Map<String, dynamic>;
    } catch (e) {
      return _errorResponse(400, 'invalid JSON body: $e');
    }

    final email = body['email'] as String?;
    final password = body['password'] as String?;
    if (email == null || password == null) {
      return _errorResponse(400, 'missing field: email/password');
    }

    final rows = database.db.select('SELECT id, password_hash, role FROM users WHERE email = ?', [email]);
    if (rows.isEmpty) return _errorResponse(401, 'invalid credentials');

    final row = rows.first;
    if (!PasswordHasher.verify(password, row['password_hash'] as String)) {
      return _errorResponse(401, 'invalid credentials');
    }

    final userId = row['id'] as String;
    final role = (row['role'] as String?) ?? 'user';
    final token = JwtService.issue(userId, email, role: role);
    return Response.ok(jsonEncode({'token': token, 'userId': userId, 'email': email, 'role': role}), headers: _jsonHeaders);
  });

  router.get('/auth/me', (Request request) async {
    final authHeader = request.headers['Authorization'] ?? request.headers['authorization'];
    if (authHeader == null || !authHeader.startsWith('Bearer ')) {
      return _errorResponse(401, 'missing or invalid authorization header');
    }
    final token = authHeader.substring(7).trim();
    try {
      final claims = JwtService.verifyAndGetClaims(token);
      return Response.ok(jsonEncode({
        'userId': claims['sub'],
        'email': claims['email'],
        'role': claims['role'] ?? 'user',
      }), headers: _jsonHeaders);
    } catch (_) {
      return _errorResponse(401, 'invalid token');
    }
  });

  return router;
}
