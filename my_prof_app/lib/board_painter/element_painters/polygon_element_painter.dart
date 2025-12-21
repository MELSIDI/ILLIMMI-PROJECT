// element_painters/polygon_element_painter.dart
import 'element_painter_interface.dart';
import '../helpers/path_animation.dart';
import '../../models/basic_elements/draw_element.dart';
import '../../models/draw_elements/polygon_element.dart'; 
import '../coordinate_system.dart';
import 'package:flutter/material.dart';

class PolygonElementPainter implements ElementPainter {
  @override
  bool canPaint(DrawElement element) => element is PolygonElement;

  @override
  void paint(Canvas canvas, CoordinateSystem coordinateSystem, DrawElement element, double progress, Paint paint, List<DrawElement> allElements) {
    final polygonElement = element as PolygonElement;
    
    if (polygonElement.points.isEmpty) return;
    
    final path = _createPolygonPath(polygonElement);
    PathAnimation.animatePath(canvas, paint, coordinateSystem, path, progress);
    
    _fillPolygonIfNeeded(canvas, coordinateSystem, polygonElement, progress, path);
  }

  Path _createPolygonPath(PolygonElement element) {
    final path = Path();
    path.moveTo(element.points.first.dx, element.points.first.dy);
    for (int i = 1; i < element.points.length; i++) {
      path.lineTo(element.points[i].dx, element.points[i].dy);
    }
    path.close();
    return path;
  }

  void _fillPolygonIfNeeded(Canvas canvas, CoordinateSystem coordinateSystem, PolygonElement element, double progress, Path path) {
    if (element.fillColor != null && progress >= 1.0) {
      final fillPaint = Paint()
        ..color = element.fillColor!
        ..style = PaintingStyle.fill;
      canvas.drawPath(path.transform(coordinateSystem.matrix.storage), fillPaint);
    }
  }
}