// board_painter.dart
// board_painter.dart
import 'package:flutter/material.dart';
import '../../models/basic_elements/draw_element.dart';
import '../models/hyper_element.dart';
import 'coordinate_system.dart';
import 'element_painters/element_painter_factory.dart';
import 'helpers/grid_painter.dart';

class BoardPainter extends CustomPainter {
  final List<HyperElement> allElements;
  final double currentTime;
  final Color defaultColor;
  final bool showGrid;
  final bool isStatic;

  BoardPainter({
    required this.allElements,
    required this.currentTime,
    this.defaultColor = const Color(0xFFF2F6F3),
    this.showGrid = false,
    this.isStatic = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final coordinateSystem = CoordinateSystem(size);

    if (showGrid) {
      GridPainter.draw(
        canvas,
        coordinateSystem,
        coordinateSystem.referenceWidth,
        coordinateSystem.referenceHeight,
      );
    }

    for (final element in allElements.whereType<DrawElement>()) {
      _paintElement(canvas, coordinateSystem, element);
    }
  }

  void _paintElement(
    Canvas canvas,
    CoordinateSystem coordinateSystem,
    DrawElement element,
  ) {
    final double progress;
    if (isStatic) {
      progress = 1.0; // Affichage statique : on affiche tout
    } else {
      progress = _calculateProgress(element);
    }
    if (progress <= 0.0) return;

    final paint = _createPaint(element);
    final painter = ElementPainterFactory.getPainter(element);

    // Passe tous les éléments au painter pour le contexte
    painter?.paint(
      canvas,
      coordinateSystem,
      element,
      progress,
      paint,
      allElements,
    );
  }

  double _calculateProgress(DrawElement element) {
    return ((currentTime - element.startTime) /
            (element.duration > 0 ? element.duration : 1.0))
        .clamp(0.0, 1.0);
  }

  Paint _createPaint(DrawElement element) {
    return Paint()
      ..strokeWidth = element.width
      ..color = element.color ?? defaultColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  @override
  bool shouldRepaint(covariant BoardPainter oldDelegate) => true;
}
