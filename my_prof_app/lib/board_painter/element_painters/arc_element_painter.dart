// element_painters/arc_element_painter.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'element_painter_interface.dart';
import '../helpers/arrow_head_painter.dart';
import '../../models/basic_elements/draw_element.dart'; 
import '../../models/draw_elements/arc_element.dart';
import '../coordinate_system.dart';

class ArcElementPainter implements ElementPainter {
  @override
  bool canPaint(DrawElement element) => element is ArcElement;

  @override
  void paint(Canvas canvas, CoordinateSystem coordinateSystem, DrawElement element, double progress, Paint paint, List<DrawElement> allElements) {
    final arcElement = element as ArcElement;

    _drawArcOutline(canvas, coordinateSystem, arcElement, progress, paint);
    _fillArcIfNeeded(canvas, coordinateSystem, arcElement, progress);
    _drawArrowIfNeeded(canvas, coordinateSystem, arcElement, progress, paint);
  }

  void _drawArcOutline(Canvas canvas, CoordinateSystem coordinateSystem, ArcElement element, double progress, Paint paint) {
    final rect = Rect.fromCircle(center: element.center, radius: element.radius);
    final topLeft = coordinateSystem.transformPoint(rect.topLeft);
    final bottomRight = coordinateSystem.transformPoint(rect.bottomRight);

    final startAngleRad = element.startAngle - math.pi / 2;
    final sweepAngleRad = element.sweepAngle;

    canvas.drawArc(
      Rect.fromPoints(topLeft, bottomRight),
      startAngleRad,
      sweepAngleRad * progress,
      false,
      paint,
    );
  }

  void _fillArcIfNeeded(Canvas canvas, CoordinateSystem coordinateSystem, ArcElement element, double progress) {
    if (element.fillColor != null && progress >= 1.0) {
      final fillPaint = Paint()
        ..color = element.fillColor!
        ..style = PaintingStyle.fill;
      
      final rect = Rect.fromCircle(center: element.center, radius: element.radius);
      final topLeft = coordinateSystem.transformPoint(rect.topLeft);
      final bottomRight = coordinateSystem.transformPoint(rect.bottomRight);
      final startAngleRad = element.startAngle - math.pi / 2;

      canvas.drawArc(
        Rect.fromPoints(topLeft, bottomRight),
        startAngleRad,
        element.sweepAngle,
        true,
        fillPaint,
      );
    }
  }

  void _drawArrowIfNeeded(Canvas canvas, CoordinateSystem coordinateSystem, ArcElement element, double progress, Paint paint) {
    if (element.hasArrowAtEnd && progress >= 1.0) {
      final startAngleRad = element.startAngle - math.pi / 2;
      final endAngleRad = startAngleRad + element.sweepAngle;
      final pointOnCircle = element.center + Offset.fromDirection(endAngleRad, element.radius);
      
      double arrowDirection;
      if (element.arrowCounterClockwise == false) {
        arrowDirection = endAngleRad - math.pi / 2;
      } else {
        arrowDirection = endAngleRad + math.pi / 2;
      }
      
      ArrowHeadPainter.draw(canvas, paint, coordinateSystem, pointOnCircle, arrowDirection);
    }
  }
}