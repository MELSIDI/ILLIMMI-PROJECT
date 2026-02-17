// element_painters/elliptic_arc_element_painter.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../models/hyper_element.dart';
import 'element_painter_interface.dart';
import '../helpers/arrow_head_painter.dart';
import '../../models/basic_elements/draw_element.dart';
import '../../models/draw_elements/elliptic_arc_element.dart'; 
import '../coordinate_system.dart';

class EllipticArcElementPainter implements ElementPainter {
  @override
  bool canPaint(DrawElement element) => element is EllipticArcElement;

  @override
  void paint(Canvas canvas, CoordinateSystem coordinateSystem, DrawElement element, double progress, Paint paint, List<HyperElement> allElements) {
    final ellipticArcElement = element as EllipticArcElement;

    canvas.save();
    
    _setupCanvasTransform(canvas, coordinateSystem, ellipticArcElement);
    _drawEllipticArcOutline(canvas, ellipticArcElement, progress, paint);
    _fillEllipticArcIfNeeded(canvas, ellipticArcElement, progress);
    _drawArrowIfNeeded(canvas, ellipticArcElement, progress, paint);

    canvas.restore();
  }

  void _setupCanvasTransform(Canvas canvas, CoordinateSystem coordinateSystem, EllipticArcElement element) {
    final centerTrans = coordinateSystem.transformPoint(element.center);
    canvas.translate(centerTrans.dx, centerTrans.dy);
    canvas.rotate(element.rotation);
  }

  void _drawEllipticArcOutline(Canvas canvas, EllipticArcElement element, double progress, Paint paint) {
    final rect = _createScaledRect(element);
    final startAngleRad = element.startAngle - math.pi / 2;
    final sweepAngleRad = element.sweepAngle;

    canvas.drawArc(
      rect,
      startAngleRad,
      sweepAngleRad * progress,
      false,
      paint,
    );
  }

  Rect _createScaledRect(EllipticArcElement element) {
    return Rect.fromCenter(
      center: Offset.zero,
      width: element.radiusX * 2,
      height: element.radiusY * 2,
    );
  }

  void _fillEllipticArcIfNeeded(Canvas canvas, EllipticArcElement element, double progress) {
    if (element.fillColor != null && progress >= 1.0) {
      final fillPaint = Paint()
        ..color = element.fillColor!
        ..style = PaintingStyle.fill;
      final startAngleRad = element.startAngle - math.pi / 2;
      canvas.drawArc(_createScaledRect(element), startAngleRad, element.sweepAngle, true, fillPaint);
    }
  }

  void _drawArrowIfNeeded(Canvas canvas, EllipticArcElement element, double progress, Paint paint) {
    if (element.hasArrowAtEnd && progress >= 1.0) {
      final startAngleRad = element.startAngle - math.pi / 2;
      final endAngleRad = startAngleRad + element.sweepAngle;
      
      final x = element.radiusX * math.cos(endAngleRad);
      final y = element.radiusY * math.sin(endAngleRad);
      final pointOnEllipse = Offset(x, y);
      
      double tangentAngle = math.atan2(-element.radiusX * math.sin(endAngleRad), element.radiusY * math.cos(endAngleRad));
      
      double arrowDirection;
      if (element.arrowCounterClockwise == true) {
        arrowDirection = tangentAngle + math.pi;
      } else {
        arrowDirection = tangentAngle;
      }
      
      ArrowHeadPainter.draw(
        canvas, 
        paint, 
        CoordinateSystem(Size.zero), // Pas de transformation supplémentaire
        pointOnEllipse, 
        arrowDirection,
      );
    }
  }
}