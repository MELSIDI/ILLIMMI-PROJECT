// helpers/grid_painter.dart
import 'package:flutter/material.dart';
import '../coordinate_system.dart';

class GridPainter {
  static void draw(Canvas canvas, CoordinateSystem coordinateSystem, double width, double height) {
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    _drawVerticalLines(canvas, coordinateSystem, width, height, gridPaint);
    _drawHorizontalLines(canvas, coordinateSystem, width, height, gridPaint);
    _drawAxes(canvas, coordinateSystem, width, height);
  }

  static void _drawVerticalLines(Canvas canvas, CoordinateSystem coordinateSystem, double width, double height, Paint paint) {
    for (double x = 0; x <= width; x += 10) {
      final p1 = coordinateSystem.transformPoint(Offset(x, 0));
      final p2 = coordinateSystem.transformPoint(Offset(x, height));
      canvas.drawLine(p1, p2, paint);
    }
  }

  static void _drawHorizontalLines(Canvas canvas, CoordinateSystem coordinateSystem, double width, double height, Paint paint) {
    for (double y = 0; y <= height; y += 10) {
      final p1 = coordinateSystem.transformPoint(Offset(0, y));
      final p2 = coordinateSystem.transformPoint(Offset(width, y));
      canvas.drawLine(p1, p2, paint);
    }
  }

  static void _drawAxes(Canvas canvas, CoordinateSystem coordinateSystem, double width, double height) {
    final axisPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final xStart = coordinateSystem.transformPoint(Offset(0, height / 2));
    final xEnd = coordinateSystem.transformPoint(Offset(width, height / 2));
    canvas.drawLine(xStart, xEnd, axisPaint);

    final yStart = coordinateSystem.transformPoint(Offset(width / 2, 0));
    final yEnd = coordinateSystem.transformPoint(Offset(width / 2, height));
    canvas.drawLine(yStart, yEnd, axisPaint);
  }
}