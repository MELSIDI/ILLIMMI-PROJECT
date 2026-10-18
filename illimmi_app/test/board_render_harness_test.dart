import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:illimmi_app/models/hyper_element.dart';
import 'package:illimmi_app/render_harness/board_capture_deserializer.dart';
import 'package:illimmi_app/render_harness/board_capture_widget.dart';
import 'package:illimmi_app/render_harness/load_bundled_fonts.dart';
import 'package:illimmi_app/theme/board_theme.dart';

const double _renderWidth = 1600;
const double _renderHeight = 900;

void main() {
  testWidgets('rend un lot de captures depuis BOARD_RENDER_REQUEST_FILE', (tester) async {
    final requestPath = Platform.environment['BOARD_RENDER_REQUEST_FILE'];
    final outputDir = Platform.environment['BOARD_RENDER_OUTPUT_DIR'];
    if (requestPath == null || outputDir == null) {
      // In normal test runs without environment variables, pass silently
      return;
    }

    final requestJson =
        jsonDecode(File(requestPath).readAsStringSync()) as Map<String, dynamic>;
    final points = requestJson['points'] as List;

    Directory(outputDir).createSync(recursive: true);
    await loadBundledFonts();

    tester.view.physicalSize = const Size(_renderWidth, _renderHeight);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final globalTheme = requestJson['theme'] as String?;
    final manifest = <Map<String, dynamic>>[];

    for (var index = 0; index < points.length; index++) {
      final point = points[index] as Map<String, dynamic>;
      final elements = (point['elements'] as List)
          .map((e) => hyperElementFromJson(e as Map<String, dynamic>))
          .whereType<HyperElement>()
          .toList();

      final pointTheme = (point['theme'] as String?) ?? globalTheme;
      final boardTheme = BoardTheme.fromString(pointTheme);

      final boundaryKey = GlobalKey();
      await tester.pumpWidget(
        buildCaptureWidget(
          elements: elements,
          renderWidth: _renderWidth,
          renderHeight: _renderHeight,
          repaintBoundaryKey: boundaryKey,
          theme: boardTheme,
        ),
      );
      // Laisse `flutter_math_fork` construire les formules LaTeX et le
      // moteur poser un premier frame avant capture.
      await tester.pump();
      await tester.pump();

      final pngBytes = await tester.runAsync(() async {
        final boundary =
            boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
        final image = await boundary.toImage(pixelRatio: 1.0);
        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        return byteData!.buffer.asUint8List();
      });

      final fileName = '$index.png';
      File('$outputDir/$fileName').writeAsBytesSync(pngBytes!);
      manifest.add({
        'index': index,
        'triggerElementIds': point['triggerElementIds'],
        'file': fileName,
      });
    }

    File('$outputDir/manifest.json').writeAsStringSync(jsonEncode(manifest));
  });
}
