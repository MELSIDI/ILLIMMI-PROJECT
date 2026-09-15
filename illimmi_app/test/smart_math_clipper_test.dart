import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:illimmi_app/board_writter/smart_math_clipper.dart';
import 'package:illimmi_app/board_writter/latex_widget.dart';

void main() {
  group('MathZoneAnalyzer & SmartMathClipper', () {
    test('Analyzes fraction with prefix correctly', () {
      final zone = MathZoneAnalyzer.buildZone(r'x_G = \dfrac{a x_A + b x_B}{a+b}');
      expect(zone, isA<CompositeSequenceZone>());

      final clipper = SmartMathClipper(rootZone: zone, progress: 0.5);
      final clipPath = clipper.getClip(const Size(200, 100));
      expect(clipPath, isNotNull);
    });

    test('Analyzes matrix correctly', () {
      final zone = MathZoneAnalyzer.buildZone(r'A = \begin{pmatrix} 1 & 2 \\ 3 & 4 \end{pmatrix}');
      expect(zone, isA<CompositeSequenceZone>());

      final clipper = SmartMathClipper(rootZone: zone, progress: 0.7);
      final clipPath = clipper.getClip(const Size(300, 200));
      expect(clipPath, isNotNull);
    });

    test('Analyzes square root correctly', () {
      final zone = MathZoneAnalyzer.buildZone(r'f(x) = \sqrt{\frac{a}{b}}');
      expect(zone, isA<CompositeSequenceZone>());

      final clipper = SmartMathClipper(rootZone: zone, progress: 0.4);
      final clipPath = clipper.getClip(const Size(150, 80));
      expect(clipPath, isNotNull);
    });
  });

  group('LatexWidget Rendering with SmartMathClipper', () {
    testWidgets('Renders fraction smoothly at various progress intervals', (tester) async {
      for (final p in [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AdvancedTextWidget(
                content: r'$$x_G = \dfrac{a x_A + b x_B}{a+b}$$',
                progress: p,
              ),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('Renders matrix smoothly at various progress intervals', (tester) async {
      for (final p in [0.0, 0.25, 0.5, 0.75, 1.0]) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AdvancedTextWidget(
                content: r'$$M = \begin{pmatrix} \frac{1}{2} & \frac{\sqrt{3}}{2} \\ -\frac{\sqrt{3}}{2} & \frac{1}{2} \end{pmatrix}$$',
                progress: p,
              ),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
      }
    });
  });
}
