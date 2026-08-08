import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

/// Chemin vers le projet `illimmi_app` — c'est lui qui possède le vrai code
/// de rendu (`BoardPainter`/`LatexWidget`/`ArrowHeadPainter`) et le harnais
/// `test/board_render_harness_test.dart` qu'on invoque en subprocess. Ce
/// service ne fait que router une requête HTTP vers ce harnais ; il ne rend
/// jamais rien lui-même.
String get _illimmiAppDir =>
    Platform.environment['ILLIMMI_APP_DIR'] ?? p.join('..', '..', 'illimmi_app');

/// Un process `flutter test` par lot de capture (pas de process tenu "chaud"
/// entre deux lots) — c'est la version de référence explicitement flaggée
/// comme point à optimiser plus tard dans
/// generation-orchestrator/world-model-visual-feedback.md ("Mécanisme
/// d'exécution headless").
Future<Response> _render(Request request) async {
  final body = await request.readAsString();
  final tempDir = await Directory.systemTemp.createTemp('board_render_');
  final requestFile = File(p.join(tempDir.path, 'request.json'));
  final outputDir = Directory(p.join(tempDir.path, 'out'));

  try {
    await requestFile.writeAsString(body);
    await outputDir.create(recursive: true);

    final result = await Process.run(
      'flutter',
      ['test', 'integration_test/board_render_harness_test.dart'],
      workingDirectory: _illimmiAppDir,
      environment: {
        'BOARD_RENDER_REQUEST_FILE': requestFile.path,
        'BOARD_RENDER_OUTPUT_DIR': outputDir.path,
      },
      // `flutter` est un script (`flutter.bat` sous Windows, un shell script
      // ailleurs) : sans `runInShell`, `Process.run` ne le trouve pas même
      // s'il est dans le PATH (seuls les vrais exécutables sont résolus).
      runInShell: true,
    );

    if (result.exitCode != 0) {
      return Response.internalServerError(
        body: jsonEncode({
          'error': 'flutter test a échoué (code ${result.exitCode})',
          'stdout': result.stdout.toString(),
          'stderr': result.stderr.toString(),
        }),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final manifestFile = File(p.join(outputDir.path, 'manifest.json'));
    final manifest = jsonDecode(await manifestFile.readAsString()) as List;

    final images = await Future.wait(
      manifest.map((entry) async {
        final map = entry as Map<String, dynamic>;
        final pngFile = File(p.join(outputDir.path, map['file'] as String));
        final bytes = await pngFile.readAsBytes();
        return {
          'triggerElementIds': map['triggerElementIds'],
          'imageBase64': base64Encode(bytes),
        };
      }),
    );

    return Response.ok(
      jsonEncode({'images': images}),
      headers: {'Content-Type': 'application/json'},
    );
  } catch (e) {
    return Response.internalServerError(
      body: jsonEncode({'error': e.toString()}),
      headers: {'Content-Type': 'application/json'},
    );
  } finally {
    await tempDir.delete(recursive: true);
  }
}

Response _health(Request request) =>
    Response.ok(jsonEncode({'status': 'ok'}), headers: {'Content-Type': 'application/json'});

void main() async {
  final router = Router()
    ..post('/render', _render)
    ..get('/health', _health);

  final port = int.parse(Platform.environment['PORT'] ?? '5001');
  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(router.call);
  await shelf_io.serve(handler, InternetAddress.anyIPv4, port);
  print('board-render-service écoute sur le port $port (ILLIMMI_APP_DIR=$_illimmiAppDir)');
}
