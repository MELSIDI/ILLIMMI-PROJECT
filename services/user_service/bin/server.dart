import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

import 'package:user_service/db/database.dart';
import 'package:user_service/routes/auth_routes.dart';
import 'package:user_service/routes/history_routes.dart';

void _loadEnvFile() {
  final candidates = [
    File('.env'),
    File('../../.env'),
    File('../.env'),
  ];
  for (final file in candidates) {
    if (file.existsSync()) {
      for (final line in file.readAsLinesSync()) {
        final trimmed = line.trim();
        if (trimmed.isEmpty || trimmed.startsWith('#') || !trimmed.contains('=')) continue;
        final idx = trimmed.indexOf('=');
        final key = trimmed.substring(0, idx).trim();
        final value = trimmed.substring(idx + 1).trim().replaceAll(RegExp(r'''^['"]|['"]$'''), '');
        if (!Platform.environment.containsKey(key)) {
          Platform.environment[key] = value;
        }
      }
      break;
    }
  }
  // Défaut sécurisé de secours si non spécifié
  Platform.environment.putIfAbsent('AUTH_JWT_SECRET', () => 'illimmi_jwt_secret_dev_2026_super_secure');
}

Middleware corsHeaders() => (innerHandler) {
  return (Request request) async {
    if (request.method == 'OPTIONS') {
      return Response.ok('', headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Origin, Content-Type, Authorization',
      });
    }
    final response = await innerHandler(request);
    return response.change(headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Origin, Content-Type, Authorization',
    });
  };
};

Future<void> main() async {
  _loadEnvFile();
  final database = AppDatabase.open(Platform.environment['DB_PATH']);
  final port = int.parse(Platform.environment['PORT'] ?? '8081');

  final router = Router()
    ..mount('/', createAuthRouter(database).call)
    ..mount('/', createHistoryRouter(database).call)
    ..get('/health', (Request request) => Response.ok('ok'));

  final handler = const Pipeline()
      .addMiddleware(corsHeaders())
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, port);
  print('user-service en écoute sur http://${server.address.host}:${server.port}');
}
