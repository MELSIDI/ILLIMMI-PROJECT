import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:uuid/uuid.dart';

import '../auth/auth_middleware.dart';
import '../db/database.dart';

const _jsonHeaders = {'Content-Type': 'application/json'};
const _uuid = Uuid();

/// `/history` : consultée par le client Flutter (`GET`) et alimentée
/// serveur-à-serveur par `generation-orchestrator` (`POST`) une fois un
/// cours généré — les deux routes exigent le même token Bearer utilisateur,
/// pas de secret séparé.
Router createHistoryRouter(AppDatabase database) {
  final router = Router();
  final protected = const Pipeline().addMiddleware(requireAuth());

  router.get(
    '/history',
    protected.addHandler((Request request) async {
      final userId = request.context['userId'] as String;
      final rows = database.db.select(
        'SELECT id, prompt, subject, script, audio_url, duration, created_at '
        'FROM course_history WHERE user_id = ? ORDER BY created_at DESC',
        [userId],
      );

      final entries = rows
          .map((row) => {
                'id': row['id'],
                'prompt': row['prompt'],
                'subject': row['subject'],
                'script': row['script'],
                'audioUrl': row['audio_url'],
                'duration': row['duration'],
                'createdAt': row['created_at'],
              })
          .toList();

      return Response.ok(jsonEncode(entries), headers: _jsonHeaders);
    }),
  );

  router.post(
    '/history',
    protected.addHandler((Request request) async {
      final userId = request.context['userId'] as String;

      final Map<String, dynamic> body;
      try {
        body = jsonDecode(await request.readAsString()) as Map<String, dynamic>;
      } catch (e) {
        return Response(400, body: jsonEncode({'error': 'invalid JSON body: $e'}), headers: _jsonHeaders);
      }

      final prompt = body['prompt'] as String?;
      final script = body['script'] as String?;
      final audioUrl = body['audioUrl'] as String?;
      final duration = (body['duration'] as num?)?.toDouble();
      if (prompt == null || script == null || audioUrl == null || duration == null) {
        return Response(
          400,
          body: jsonEncode({'error': 'missing required field: prompt/script/audioUrl/duration'}),
          headers: _jsonHeaders,
        );
      }
      final subject = body['subject'] as String?;

      final id = 'hist_${_uuid.v4()}';
      database.db.execute(
        'INSERT INTO course_history (id, user_id, prompt, subject, script, audio_url, duration, created_at) '
        'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [id, userId, prompt, subject, script, audioUrl, duration, DateTime.now().toIso8601String()],
      );

      return Response(201, body: jsonEncode({'id': id}), headers: _jsonHeaders);
    }),
  );

  return router;
}
