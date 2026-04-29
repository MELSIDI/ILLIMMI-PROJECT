// element_painters/curve_element_painter.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../models/hyper_element.dart';
import 'element_painter_interface.dart';
import '../helpers/path_animation.dart';
import '../helpers/arrow_head_painter.dart';
import '../../models/basic_elements/draw_element.dart';
import '../../models/draw_elements/curve_element.dart';
import '../coordinate_system.dart';

class CurveElementPainter implements ElementPainter {
  @override
  bool canPaint(DrawElement element) => element is CurveElement;

  @override
  void paint(Canvas canvas, CoordinateSystem coordinateSystem, DrawElement element, double progress, Paint paint, List<HyperElement> allElements) {
    final curveElement = element as CurveElement;
    
    if (curveElement.points.length < 2) return;
    
    final path = _createCurvePath(curveElement);
    PathAnimation.animatePath(canvas, paint, coordinateSystem, path, progress);
    
    _drawArrowIfNeeded(canvas, coordinateSystem, curveElement, progress, paint);
  }

  Path _createCurvePath(CurveElement element) {
    final path = Path();
    
    if (element.smooth) {
      path.moveTo(element.points.first.dx, element.points.first.dy);
      
      for (int i = 0; i < element.points.length - 1; i++) {
        final p0 = i > 0 ? element.points[i - 1] : element.points[i];
        final p1 = element.points[i];
        final p2 = element.points[i + 1];
        final p3 = i < element.points.length - 2 ? element.points[i + 2] : element.points[i + 1];
        
        final cp1x = p1.dx + (p2.dx - p0.dx) / 6;
        final cp1y = p1.dy + (p2.dy - p0.dy) / 6;
        final cp2x = p2.dx - (p3.dx - p1.dx) / 6;
        final cp2y = p2.dy - (p3.dy - p1.dy) / 6;
        
        path.cubicTo(cp1x, cp1y, cp2x, cp2y, p2.dx, p2.dy);
      }
    } else {
      if (element.points.length == 4) {
        path.moveTo(element.points[0].dx, element.points[0].dy);
        path.cubicTo(
          element.points[1].dx, element.points[1].dy,
          element.points[2].dx, element.points[2].dy,
          element.points[3].dx, element.points[3].dy,
        );
      } else {
        path.moveTo(element.points.first.dx, element.points.first.dy);
        for (int i = 1; i < element.points.length - 1; i += 2) {
          if (i + 1 < element.points.length) {
            path.quadraticBezierTo(
              element.points[i].dx, element.points[i].dy,
              element.points[i + 1].dx, element.points[i + 1].dy,
            );
          }
        }
      }
    }
    
    return path;
  }

  void _drawArrowIfNeeded(Canvas canvas, CoordinateSystem coordinateSystem, CurveElement element, double progress, Paint paint) {
    if (element.hasArrowAtEnd && progress >= 1.0) {
      final lastPoint = element.points.last;
      final secondLastPoint = element.points[element.points.length - 2];
      
      double angle = (lastPoint - secondLastPoint).direction;
      
      if (element.arrowCounterClockwise == false) {
        angle += math.pi;
      }
      
      ArrowHeadPainter.draw(canvas, paint, coordinateSystem, lastPoint, angle);
    }
  }
}