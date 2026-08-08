import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

import '../lib/job/job_store.dart';
import '../lib/routes/courses_routes.dart';

Future<void> main() async {
  final jobStore = JobStore();
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  final router = Router()
    ..mount('/', createCoursesRouter(jobStore).call)
    ..get('/health', (Request request) => Response.ok('ok'));

  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(router.call);

  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, port);
  print('generation-orchestrator en écoute sur http://${server.address.host}:${server.port}');
}
