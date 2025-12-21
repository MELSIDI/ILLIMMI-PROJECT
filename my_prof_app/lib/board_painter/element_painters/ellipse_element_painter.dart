// element_painters/ellipse_element_painter.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'element_painter_interface.dart';
import '../helpers/arrow_head_painter.dart';
import '../../models/basic_elements/draw_element.dart';
import '../../models/draw_elements/ellipse_element.dart'; 
import '../coordinate_system.dart';

class EllipseElementPainter implements ElementPainter {
  @override
  bool canPaint(DrawElement element) => element is EllipseElement;

  @override
  void paint(Canvas canvas, CoordinateSystem coordinateSystem, DrawElement element, double progress, Paint paint, List<DrawElement> allElements) {
    final ellipseElement = element as EllipseElement;

    canvas.save();
    
    _setupCanvasTransform(canvas, coordinateSystem, ellipseElement);
    _drawEllipseOutline(canvas, ellipseElement, progress, paint);
    _fillEllipseIfNeeded(canvas, ellipseElement, progress);
    _drawArrowIfNeeded(canvas, ellipseElement, progress, paint);

    canvas.restore();
  }

  void _setupCanvasTransform(Canvas canvas, CoordinateSystem coordinateSystem, EllipseElement element) {
    final centerTrans = coordinateSystem.transformPoint(element.center);
    canvas.translate(centerTrans.dx, centerTrans.dy);
    canvas.rotate(element.rotation);
  }

  void _drawEllipseOutline(Canvas canvas, EllipseElement element, double progress, Paint paint) {
    final scaledRect = _createScaledRect(element);
    canvas.drawArc(
      scaledRect,
      -math.pi / 2,
      (2 * math.pi) * progress,
      false,
      paint,
    );
  }

  Rect _createScaledRect(EllipseElement element) {
    return Rect.fromCenter(
      center: Offset.zero,
      width: element.radiusX * 2,
      height: element.radiusY * 2,
    );
  }

  void _fillEllipseIfNeeded(Canvas canvas, EllipseElement element, double progress) {
    if (element.fillColor != null && progress >= 1.0) {
      final fillPaint = Paint()
        ..color = element.fillColor!
        ..style = PaintingStyle.fill;
      canvas.drawOval(_createScaledRect(element), fillPaint);
    }
  }

  void _drawArrowIfNeeded(Canvas canvas, EllipseElement element, double progress, Paint paint) {
    if (element.arrowAngle != null && progress >= 1.0) {
      final angleRad = (element.arrowAngle! - 90) * (math.pi / 180.0);
      
      final x = element.radiusX * math.cos(angleRad);
      final y = element.radiusY * math.sin(angleRad);
      final pointOnEllipse = Offset(x, y);
      
      double tangentAngle = math.atan2(-element.radiusX * math.sin(angleRad), element.radiusY * math.cos(angleRad));
      
      double arrowDirection;
      if (element.arrowCounterClockwise == true) {
        arrowDirection = tangentAngle;
      } else if (element.arrowCounterClockwise == false) {
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