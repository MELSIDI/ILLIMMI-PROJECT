import 'dart:convert';
import 'dart:io';

import 'package:generation_orchestrator/parsers/hypercourse_parser.dart';
import 'package:generation_orchestrator/pipeline/board_capture_planner.dart';
import 'package:generation_orchestrator/pipeline/board_capture_serializer.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Usage: dart run bin/render_course_to_images.dart <path_to_hc_file> [output_dir]');
    exit(1);
  }

  final hcPath = args[0];
  final hcFile = File(hcPath);
  if (!hcFile.existsSync()) {
    print('Error: file not found: $hcPath');
    exit(1);
  }

  final outputDir = Directory(
    args.length > 1
        ? args[1]
        : '${hcFile.parent.path}${Platform.pathSeparator}renders',
  );
  outputDir.createSync(recursive: true);

  print('====================================================');
  print('ILLIMMI Board Render Service — Headless Rendering');
  print('Course script: ${hcFile.path}');
  print('Output directory: ${outputDir.path}');
  print('====================================================');

  final script = hcFile.readAsStringSync();
  final parser = HypercourseParser(script);
  final course = await parser.parse();

  print('Course "${course.name}" parsed (${course.globalRegistry.length} elements).');

  final batches = planCaptures(course);
  if (batches.isEmpty) {
    print('No capture points found in course.');
    exit(0);
  }

  print('Planned ${batches.length} capture batch(es).');

  // Find illimmi_app root directory
  // Default assuming services/generation_orchestrator is at <root>/services/generation_orchestrator
  final currentDir = Directory.current.path;
  var illimmiAppDir = Platform.environment['ILLIMMI_APP_DIR'];
  if (illimmiAppDir == null) {
    final candidate = Directory('${Directory.current.parent.parent.path}${Platform.pathSeparator}illimmi_app');
    if (candidate.existsSync()) {
      illimmiAppDir = candidate.path;
    } else {
      illimmiAppDir = 'C:\\Users\\pc elqods\\Desktop\\ILLIMMI-PROJECT\\illimmi_app';
    }
  }

  print('Using illimmi_app directory: $illimmiAppDir');

  final allManifestEntries = <Map<String, dynamic>>[];
  var globalCaptureIndex = 0;

  for (var b = 0; b < batches.length; b++) {
    final batch = batches[b];
    print('Processing batch $b (${batch.points.length} scene captures)...');

    final batchSerialized = serializeCaptureBatch(course, batch);
    final requestFile = File('${outputDir.path}${Platform.pathSeparator}request_batch_$b.json');
    requestFile.writeAsStringSync(jsonEncode(batchSerialized));

    final batchOutputDir = Directory('${outputDir.path}${Platform.pathSeparator}batch_$b');
    batchOutputDir.createSync(recursive: true);

    final stopwatch = Stopwatch()..start();
    final result = await Process.run(
      'flutter',
      ['test', 'test/board_render_harness_test.dart'],
      workingDirectory: illimmiAppDir,
      environment: {
        'BOARD_RENDER_REQUEST_FILE': requestFile.absolute.path,
        'BOARD_RENDER_OUTPUT_DIR': batchOutputDir.absolute.path,
      },
      runInShell: true,
    );
    stopwatch.stop();

    if (result.exitCode != 0) {
      print('Flutter test failed (exit code ${result.exitCode}):');
      print('STDOUT:\n${result.stdout}');
      print('STDERR:\n${result.stderr}');
      exit(2);
    }

    print('Batch $b rendered in ${stopwatch.elapsedMilliseconds}ms.');

    final manifestFile = File('${batchOutputDir.path}${Platform.pathSeparator}manifest.json');
    if (manifestFile.existsSync()) {
      final manifest = jsonDecode(manifestFile.readAsStringSync()) as List;
      for (final entry in manifest) {
        final map = entry as Map<String, dynamic>;
        final srcFile = File('${batchOutputDir.path}${Platform.pathSeparator}${map['file']}');
        final targetFileName = 'scene_$globalCaptureIndex.png';
        final targetFile = File('${outputDir.path}${Platform.pathSeparator}$targetFileName');
        if (srcFile.existsSync()) {
          srcFile.copySync(targetFile.path);
        }
        allManifestEntries.add({
          'sceneIndex': globalCaptureIndex,
          'triggerElementIds': map['triggerElementIds'],
          'file': targetFileName,
          'fullPath': targetFile.path,
        });
        print('  -> Saved scene capture: ${targetFile.path}');
        globalCaptureIndex++;
      }
    }

    // Clean up temporary batch folder
    try {
      requestFile.deleteSync();
      batchOutputDir.deleteSync(recursive: true);
    } catch (_) {}
  }

  final finalManifest = File('${outputDir.path}${Platform.pathSeparator}render_manifest.json');
  finalManifest.writeAsStringSync(jsonEncode({
    'course': course.name,
    'totalScenes': globalCaptureIndex,
    'scenes': allManifestEntries,
  }));

  print('====================================================');
  print('Successfully rendered $globalCaptureIndex scene(s) into ${outputDir.path}');
  print('Manifest: ${finalManifest.path}');
  print('====================================================');
}
