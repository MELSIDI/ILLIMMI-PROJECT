// element_painters/path_element_painter.dart
import '../../models/hyper_element.dart';
import 'element_painter_interface.dart';
import '../helpers/path_animation.dart';
import '../../models/basic_elements/draw_element.dart';
import '../../models/draw_elements/path_element.dart'; 
import '../coordinate_system.dart';
import 'package:flutter/material.dart';

class PathElementPainter implements ElementPainter {
  @override
  bool canPaint(DrawElement element) => element is PathElement;

  @override
  void paint(Canvas canvas, CoordinateSystem coordinateSystem, DrawElement element, double progress, Paint paint, List<HyperElement> allElements) {
    final pathElement = element as PathElement;
    
    if (pathElement.points.isEmpty) return;
    
    final path = Path();
    path.moveTo(pathElement.points.first.dx, pathElement.points.first.dy);
    for (int i = 1; i < pathElement.points.length; i++) {
      path.lineTo(pathElement.points[i].dx, pathElement.points[i].dy);
    }
    
    PathAnimation.animatePath(canvas, paint, coordinateSystem, path, progress);
  }
}