// helpers/arrow_head_painter.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../coordinate_system.dart';

class ArrowHeadPainter {
  static void draw(
    Canvas canvas,
    Paint paint,
    CoordinateSystem coordinateSystem,
    Offset position,
    double angle, {
    double? arrowSize,
    double arrowAngle = math.pi / 6,
  }) {
    arrowSize ??= paint.strokeWidth * 1.5;
    final p1 = Offset(
      position.dx - arrowSize * math.cos(angle - arrowAngle),
      position.dy - arrowSize * math.sin(angle - arrowAngle),
    );
    final p2 = Offset(position.dx, position.dy);
    final p3 = Offset(
      position.dx - arrowSize * math.cos(angle + arrowAngle),
      position.dy - arrowSize * math.sin(angle + arrowAngle),
    );

    final arrowPath = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy)
      ..lineTo(p3.dx, p3.dy);

    final arrowPaint = Paint()
      ..color = paint.color
      ..strokeWidth = paint.strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = paint.strokeCap;

    canvas.drawPath(arrowPath.transform(coordinateSystem.matrix.storage), arrowPaint);
  }
}