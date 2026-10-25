import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:uuid/uuid.dart';

import '../auth/jwt_service.dart';
import '../db/database.dart';
import '../db/sql_server_client.dart';

const _jsonHeaders = {
  'Content-Type': 'application/json',
  'Access-Control-Allow-Origin': '*',
};
const _uuid = Uuid();

Router createHistoryRouter(AppDatabase database) {
  final router = Router();

  String? tryExtractUserId(Request request) {
    final authHeader = request.headers['authorization'];
    if (authHeader != null && authHeader.startsWith('Bearer ')) {
      final token = authHeader.substring(7);
      try {
        return JwtService.verifyAndGetUserId(token);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  // GET /history : retourne l'historique du compte si token fourni, sinon l'historique invité/récent
  router.get('/history', (Request request) async {
    final userId = tryExtractUserId(request);
    final isGuestParam = request.url.queryParameters['guest'] == 'true';

    final List<Map<String, dynamic>> entries;
    if (userId != null && !isGuestParam) {
      final rows = database.db.select(
        'SELECT id, prompt, subject, script, audio_url, duration, created_at '
        'FROM course_history WHERE user_id = ? ORDER BY created_at DESC LIMIT 50',
        [userId],
      );
      entries = rows.map(_rowToMap).toList();
    } else {
      // Mode invité ou non connecté : retourne les derniers cours générés
      final rows = database.db.select(
        'SELECT id, prompt, subject, script, audio_url, duration, created_at '
        'FROM course_history ORDER BY created_at DESC LIMIT 50',
      );
      entries = rows.map(_rowToMap).toList();
    }

    return Response.ok(jsonEncode(entries), headers: _jsonHeaders);
  });

  // GET /history/recent : public, retourne les 20 cours les plus récents
  router.get('/history/recent', (Request request) async {
    final rows = database.db.select(
      'SELECT id, prompt, subject, script, audio_url, duration, created_at '
      'FROM course_history ORDER BY created_at DESC LIMIT 20',
    );
    final entries = rows.map(_rowToMap).toList();
    return Response.ok(jsonEncode(entries), headers: _jsonHeaders);
  });

  // POST /history : persistance systématique (authentifié ou invité)
  router.post('/history', (Request request) async {
    final Map<String, dynamic> body;
    try {
      body = jsonDecode(await request.readAsString()) as Map<String, dynamic>;
    } catch (e) {
      return Response(400, body: jsonEncode({'error': 'Corps JSON invalide: $e'}), headers: _jsonHeaders);
    }

    final prompt = body['prompt'] as String?;
    final script = body['script'] as String?;
    final audioUrl = body['audioUrl'] as String?;
    final duration = (body['duration'] as num?)?.toDouble();
    if (prompt == null || script == null || audioUrl == null || duration == null) {
      return Response(
        400,
        body: jsonEncode({'error': 'Champ requis manquant : prompt/script/audioUrl/duration'}),
        headers: _jsonHeaders,
      );
    }
    final subject = body['subject'] as String?;

    // Détermine le userId : token prioritaire, sinon body['userId'], sinon 'guest'
    final tokenUserId = tryExtractUserId(request);
    final userId = tokenUserId ?? (body['userId'] as String?) ?? 'guest';

    final id = 'hist_${_uuid.v4()}';
    final createdAt = DateTime.now().toIso8601String();

    await database.saveCourseHistory(
      id: id,
      userId: userId,
      prompt: prompt,
      subject: subject,
      script: script,
      audioUrl: audioUrl,
      duration: duration,
      createdAt: createdAt,
    );

    print('Cours persisté avec succès : id=$id, user=$userId, sujet=$subject');
    return Response(201, body: jsonEncode({'id': id, 'status': 'saved'}), headers: _jsonHeaders);
  });

  // DELETE /history/<id> : supprimer un cours de l'historique
  router.delete('/history/<id>', (Request request, String id) async {
    database.db.execute('DELETE FROM course_history WHERE id = ?', [id]);
    await database.sqlServer.execute("DELETE FROM course_history WHERE id = '${SqlServerClient.escape(id)}'");
    return Response.ok(jsonEncode({'deleted': id}), headers: _jsonHeaders);
  });

  return router;
}

Map<String, dynamic> _rowToMap(dynamic row) => {
  'id': row['id'],
  'prompt': row['prompt'],
  'subject': row['subject'],
  'script': row['script'],
  'audioUrl': row['audio_url'],
  'duration': row['duration'],
  'createdAt': row['created_at'],
};
