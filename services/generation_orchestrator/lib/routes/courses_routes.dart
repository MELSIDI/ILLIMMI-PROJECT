import 'dart:convert';

import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

import '../auth/jwt_verifier.dart';
import '../job/job_store.dart';

Router createCoursesRouter(JobStore jobStore) {
  final router = Router();

  router.post('/courses/generate', (Request request) async {
    final Map<String, dynamic> body;
    try {
      body = jsonDecode(await request.readAsString()) as Map<String, dynamic>;
    } catch (e) {
      return Response(400, body: jsonEncode({'error': 'Corps JSON invalide: $e'}));
    }

    final prompt = body['prompt'] as String?;
    if (prompt == null || prompt.trim().isEmpty) {
      return Response(400, body: jsonEncode({'error': 'Champ requis: prompt'}));
    }

    // Auth optionnelle : un token absent, invalide ou expiré ne bloque
    // jamais la génération — on retombe simplement en mode invité.
    String? userId;
    String? token;
    final authHeader = request.headers['authorization'];
    if (authHeader != null && authHeader.startsWith('Bearer ')) {
      token = authHeader.substring(7);
      try {
        userId = JwtVerifier.verifyAndGetUserId(token);
      } catch (_) {
        userId = null;
        token = null;
      }
    }

    final jobId = jobStore.startJob(prompt, userId: userId, authToken: token);
    return Response(
      202,
      body: jsonEncode({'jobId': jobId}),
      headers: {'Content-Type': 'application/json'},
    );
  });

  router.get('/courses/<jobId>/status', (Request request, String jobId) {
    final job = jobStore.get(jobId);
    if (job == null) {
      return Response.notFound(jsonEncode({'error': 'Job inconnu: $jobId'}));
    }
    return Response.ok(
      jsonEncode(job.toStatusJson()),
      headers: {'Content-Type': 'application/json'},
    );
  });

  router.get('/courses/<jobId>', (Request request, String jobId) {
    final job = jobStore.get(jobId);
    if (job == null) {
      return Response.notFound(jsonEncode({'error': 'Job inconnu: $jobId'}));
    }
    if (job.status == 'error') {
      return Response.internalServerError(
        body: jsonEncode({'error': job.error}),
        headers: {'Content-Type': 'application/json'},
      );
    }
    if (job.status != 'done') {
      return Response(
        409,
        body: jsonEncode({'status': job.status, 'message': job.message}),
        headers: {'Content-Type': 'application/json'},
      );
    }
    return Response.ok(
      jsonEncode(job.toResultJson()),
      headers: {'Content-Type': 'application/json'},
    );
  });

  return router;
}
