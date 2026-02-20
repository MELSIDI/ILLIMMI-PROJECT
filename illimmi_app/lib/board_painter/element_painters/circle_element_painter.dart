// element_painters/circle_element_painter.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../models/hyper_element.dart';
import 'element_painter_interface.dart';
import '../helpers/arrow_head_painter.dart';
//import '../helpers/path_animation.dart';
import '../../models/basic_elements/draw_element.dart';
import '../../models/draw_elements/circle_element.dart';
import '../coordinate_system.dart';

class CircleElementPainter implements ElementPainter {
  @override
  bool canPaint(DrawElement element) => element is CircleElement;

  @override
  void paint(Canvas canvas, CoordinateSystem coordinateSystem, DrawElement element, double progress, Paint paint, List<HyperElement> allElements) {
    final circleElement = element as CircleElement;

    _drawCircleOutline(canvas, coordinateSystem, circleElement, progress, paint);
    _fillCircleIfNeeded(canvas, coordinateSystem, circleElement, progress);
    _drawArrowIfNeeded(canvas, coordinateSystem, circleElement, progress, paint);
  }

  void _drawCircleOutline(Canvas canvas, CoordinateSystem coordinateSystem, CircleElement element, double progress, Paint paint) {
    final rect = Rect.fromCircle(center: element.center, radius: element.radius);
    final topLeft = coordinateSystem.transformPoint(rect.topLeft);
    final bottomRight = coordinateSystem.transformPoint(rect.bottomRight);

    canvas.drawArc(
      Rect.fromPoints(topLeft, bottomRight),
      -math.pi / 2,
      (2 * math.pi) * progress,
      false,
      paint,
    );
  }

  void _fillCircleIfNeeded(Canvas canvas, CoordinateSystem coordinateSystem, CircleElement element, double progress) {
    if (element.fillColor != null && progress >= 1.0) {
      final fillPaint = Paint()
        ..color = element.fillColor!
        ..style = PaintingStyle.fill;
      final centerTrans = coordinateSystem.transformPoint(element.center);
      final radiusScaled = coordinateSystem.transformScale(element.radius);
      canvas.drawCircle(centerTrans, radiusScaled, fillPaint);
    }
  }

  void _drawArrowIfNeeded(Canvas canvas, CoordinateSystem coordinateSystem, CircleElement element, double progress, Paint paint) {
    if (element.arrowAngle != null && progress >= 1.0) {
      final angleRad = (element.arrowAngle! - 90) * (math.pi / 180.0);
      final pointOnCircle = element.center + Offset.fromDirection(angleRad, element.radius);
      
      double arrowDirection;
      if (element.arrowCounterClockwise == true) {
        arrowDirection = angleRad + math.pi / 2;
      } else if (element.arrowCounterClockwise == false) {
        arrowDirection = angleRad - math.pi / 2;
      } else {
        arrowDirection = angleRad + math.pi / 2;
      }
      
      ArrowHeadPainter.draw(canvas, paint, coordinateSystem, pointOnCircle, arrowDirection);
    }
  }
}