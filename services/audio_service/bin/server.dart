import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

import 'package:audio_service/align/aligner_factory.dart';
import 'package:audio_service/routes/narrate_route.dart';
import 'package:audio_service/tts/composite_tts_service.dart';
import 'package:audio_service/tts/openrouter_tts_service.dart';
import 'package:audio_service/tts/piper_service.dart';

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
}

Middleware corsHeaders() => (innerHandler) {
  return (Request request) async {
    if (request.method == 'OPTIONS') {
      return Response.ok('', headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Origin, Content-Type, Authorization, Range',
        'Access-Control-Expose-Headers': 'Content-Length, Content-Range',
      });
    }
    final response = await innerHandler(request);
    return response.change(headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
      'Access-Control-Allow-Headers': 'Origin, Content-Type, Authorization, Range',
      'Access-Control-Expose-Headers': 'Content-Length, Content-Range',
    });
  };
};

Future<void> main() async {
  _loadEnvFile();
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
      .addMiddleware(corsHeaders())
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final server = await shelf_io.serve(handler, InternetAddress.anyIPv4, port);
  print('audio-service en écoute sur http://${server.address.host}:${server.port}');
}
