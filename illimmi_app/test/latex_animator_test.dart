import 'package:flutter_test/flutter_test.dart';
import 'package:illimmi_app/board_writter/latex_animator.dart';

void main() {
  group('LatexAnimator Human Order Fraction with Prefix', () {
    const equation = r'x_G = \dfrac{a x_A + b x_B}{a+b}';

    test('Phase 1 (early progress) writes prefix x_G = and phantomizes fraction', () {
      final res = LatexAnimator.generateProgressiveLatex(equation, 0.15);
      expect(res, contains('x_G'));
      expect(res, contains(r'\phantom{'));
    });

    test('Phase 2 (middle progress) writes numerator above bar with phantom denominator', () {
      final res = LatexAnimator.generateProgressiveLatex(equation, 0.50);
      expect(res, contains('x_G ='));
      expect(res, contains(r'\dfrac{'));
      expect(res, contains(r'\phantom{a+b}'));
    });

    test('Phase 3 (late progress) writes denominator below bar', () {
      final res = LatexAnimator.generateProgressiveLatex(equation, 0.85);
      expect(res, contains('x_G ='));
      expect(res, contains(r'\dfrac{a x_A + b x_B}{'));
      expect(res, contains('a'));
    });

    test('100% progress returns complete equation', () {
      final res = LatexAnimator.generateProgressiveLatex(equation, 1.0);
      expect(res, equals(equation));
    });
  });

  group('LatexAnimator Progressive Matrix Animation', () {
    const matrix = r'A = \begin{pmatrix} a & b \\ c & d \end{pmatrix}';

    test('reveals cells progressively', () {
      final resHalf = LatexAnimator.generateProgressiveLatex(matrix, 0.5);
      expect(resHalf, contains('a'));
      expect(resHalf, contains(r'\phantom{'));
    });
  });
}
