import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

import '../lib/db/database.dart';
import '../lib/routes/auth_routes.dart';
import '../lib/routes/history_routes.dart';

Future<void> main() async {
  final database = AppDatabase.open(Platform.environment['DB_PATH'] ?? 'illimmi_users.db');
  final port = int.parse(Platform.environment['PORT'] ?? '8081');

  final router = Router()
    ..mount('/', createAuthRouter(database).call)
    ..mount('/', createHistoryRouter(database).call)
    ..get('/health', (Request request) => Response.ok('ok'));

  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(router.call);

  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, port);
  print('user-service en écoute sur http://${server.address.host}:${server.port}');
}
