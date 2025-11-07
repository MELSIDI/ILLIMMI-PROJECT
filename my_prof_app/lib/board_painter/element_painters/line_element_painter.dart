// element_painters/line_element_painter.dart
import 'element_painter_interface.dart';
import '../helpers/path_animation.dart';
import '../helpers/arrow_head_painter.dart';
import '../../models/basic_elements/draw_element.dart';
import '../../models/draw_elements/line_element.dart'; 
import '../../models/draw_elements/arrow_element.dart'; 
import '../coordinate_system.dart';
import 'package:flutter/material.dart';

class LineElementPainter implements ElementPainter {
  @override
  bool canPaint(DrawElement element) => element is LineElement;

  @override
  void paint(Canvas canvas, CoordinateSystem coordinateSystem, DrawElement element, double progress, Paint paint, List<DrawElement> allElements) {
    final lineElement = element as LineElement;

    final path = Path()
      ..moveTo(lineElement.from.dx, lineElement.from.dy)
      ..lineTo(lineElement.to.dx, lineElement.to.dy);

    PathAnimation.animatePath(canvas, paint, coordinateSystem, path, progress);

    if (lineElement is ArrowElement && progress >= 1.0) {
      final angle = (lineElement.to - lineElement.from).direction;
      ArrowHeadPainter.draw(canvas, paint, coordinateSystem, lineElement.to, angle);
    }
  }
}