import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:illimmi_app/board_writter/latex_widget.dart';

void main() {
  testWidgets('AdvancedTextWidget renders progressively for normal text', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AdvancedTextWidget(
            content: 'Bonjour tout le monde',
            progress: 0.5,
          ),
        ),
      ),
    );

    expect(find.byType(AdvancedTextWidget), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('AdvancedTextWidget renders progressively for fractions without error', (tester) async {
    for (final progress in [0.0, 0.25, 0.5, 0.75, 1.0]) {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdvancedTextWidget(
              content: r'Voici une fraction : $\frac{7}{10}$',
              progress: progress,
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('AdvancedTextWidget renders progressively for matrices without error', (tester) async {
    for (final progress in [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]) {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AdvancedTextWidget(
              content: r'Matrice $A = \begin{pmatrix} 1 & 2 \\ 3 & 4 \end{pmatrix}$',
              progress: progress,
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    }
  });
}
