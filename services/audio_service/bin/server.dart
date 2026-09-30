import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

import '../lib/align/aligner_factory.dart';
import '../lib/routes/narrate_route.dart';
import '../lib/tts/composite_tts_service.dart';
import '../lib/tts/openrouter_tts_service.dart';
import '../lib/tts/piper_service.dart';

Future<void> main() async {
  final piper = PiperServices();
  final hasOpenRouter = (Platform.environment['OPENROUTER_API_KEY'] ?? '').isNotEmpty;
  final openRouter = hasOpenRouter ? OpenRouterTtsService() : null;

  final ttsEngine = CompositeTtsService(
    localPiper: piper,
    openRouter: openRouter,
  );

  final aligner = createAligner();
  final publicBaseUrl =
      Platform.environment['PUBLIC_BASE_URL'] ?? 'http://localhost:8082';
  final port = int.parse(Platform.environment['PORT'] ?? '8082');

  final router = Router()
    ..post('/narrate', createNarrateHandler(
      ttsEngine: ttsEngine,
      aligner: aligner,
      publicBaseUrl: publicBaseUrl,
    ))
    ..get('/health', (Request request) => Response.ok('ok'))
    ..mount('/audios', createStaticHandler(ttsEngine.outputDir, listDirectories: false));

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, port);
  print('audio-service en écoute sur http://${server.address.host}:${server.port}');
}
