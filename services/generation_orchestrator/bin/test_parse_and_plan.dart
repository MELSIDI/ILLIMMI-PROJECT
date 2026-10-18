import 'dart:convert';
import 'dart:io';

import 'package:generation_orchestrator/parsers/hypercourse_parser.dart';
import 'package:generation_orchestrator/pipeline/board_capture_planner.dart';
import 'package:generation_orchestrator/pipeline/board_capture_serializer.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Usage: dart run bin/test_parse_and_plan.dart <path_to_hc_file>');
    exit(1);
  }

  final file = File(args[0]);
  if (!file.existsSync()) {
    print('File not found: ${args[0]}');
    exit(1);
  }

  final script = file.readAsStringSync();
  print('Reading ${file.path} (${script.length} chars)...');

  try {
    final parser = HypercourseParser(script);
    final course = await parser.parse();
    print('Parsed course: "${course.name}", duration: ${course.config.duration}s, elements: ${course.globalRegistry.length}');

    final batches = planCaptures(course);
    print('Planned capture batches: ${batches.length}');
    var totalPoints = 0;
    for (var b = 0; b < batches.length; b++) {
      print('  Batch $b: ${batches[b].points.length} points');
      for (var p = 0; p < batches[b].points.length; p++) {
        final pt = batches[b].points[p];
        print('    Point $p @ t=${pt.time}s: triggers=${pt.triggerElementIds}, mutable=${pt.mutableElementIds}');
        totalPoints++;
      }
    }

    if (batches.isNotEmpty) {
      final serialized = serializeCaptureBatch(course, batches.first);
      final jsonStr = jsonEncode(serialized);
      print('Serialized first batch: ${jsonStr.length} chars');
      print('Points count: ${(serialized['points'] as List).length}');
    }

    print('SUCCESS!');
  } catch (e, st) {
    print('ERROR parsing/planning: $e\n$st');
    exit(2);
  }
}
