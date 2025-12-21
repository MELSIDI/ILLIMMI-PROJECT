// element_painters/repere2d_element_painter.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'element_painter_interface.dart';
import '../helpers/arrow_head_painter.dart';
import '../../models/basic_elements/draw_element.dart';
import '../../models/draw_elements/repere2d_element.dart'; 
import '../coordinate_system.dart';

class Repere2DElementPainter implements ElementPainter {
  @override
  bool canPaint(DrawElement element) => element is Repere2DElement;

  @override
  void paint(Canvas canvas, CoordinateSystem coordinateSystem, DrawElement element, double progress, Paint paint, List<DrawElement> allElements) {
    final repereElement = element as Repere2DElement;

    final xFirst = repereElement.id % 2 == 0;
    
    if (xFirst) {
      _drawXAxisFirst(canvas, coordinateSystem, repereElement, progress, paint);
    } else {
      _drawYAxisFirst(canvas, coordinateSystem, repereElement, progress, paint);
    }
  }

  void _drawXAxisFirst(Canvas canvas, CoordinateSystem coordinateSystem, Repere2DElement element, double progress, Paint paint) {
    // Axe X d'abord (première moitié), puis axe Y (deuxième moitié)
    if (progress > 0) {
      final xProgress = (progress * 2).clamp(0.0, 1.0);
      _drawXAxis(canvas, coordinateSystem, element, xProgress, paint);
    }
    
    if (progress > 0.5) {
      final yProgress = ((progress - 0.5) * 2).clamp(0.0, 1.0);
      _drawYAxis(canvas, coordinateSystem, element, yProgress, paint);
    }
  }

  void _drawYAxisFirst(Canvas canvas, CoordinateSystem coordinateSystem, Repere2DElement element, double progress, Paint paint) {
    // Axe Y d'abord (première moitié), puis axe X (deuxième moitié)
    if (progress > 0) {
      final yProgress = (progress * 2).clamp(0.0, 1.0);
      _drawYAxis(canvas, coordinateSystem, element, yProgress, paint);
    }
    
    if (progress > 0.5) {
      final xProgress = ((progress - 0.5) * 2).clamp(0.0, 1.0);
      _drawXAxis(canvas, coordinateSystem, element, xProgress, paint);
    }
  }

  void _drawXAxis(Canvas canvas, CoordinateSystem coordinateSystem, Repere2DElement element, double progress, Paint paint) {
    final xStart = element.origin.dx + element.xStart * element.scale;
    final xEnd = element.origin.dx + element.xEnd * element.scale;
    final xY = element.origin.dy;
    
    final currentXEnd = xStart + (xEnd - xStart) * progress;
    
    final xP1 = coordinateSystem.transformPoint(Offset(xStart, xY));
    final xP2 = coordinateSystem.transformPoint(Offset(currentXEnd, xY));
    canvas.drawLine(xP1, xP2, paint);
    
    if (progress >= 1.0) {
      ArrowHeadPainter.draw(canvas, paint, coordinateSystem, Offset(xEnd, xY), 0);
    }
  }

  void _drawYAxis(Canvas canvas, CoordinateSystem coordinateSystem, Repere2DElement element, double progress, Paint paint) {
    final yX = element.origin.dx;
    final yStart = element.origin.dy - element.yEnd * element.scale;
    final yEnd = element.origin.dy - element.yStart * element.scale;
    
    final currentYStart = yEnd - (yEnd - yStart) * progress;
    
    final yP1 = coordinateSystem.transformPoint(Offset(yX, yEnd));
    final yP2 = coordinateSystem.transformPoint(Offset(yX, currentYStart));
    canvas.drawLine(yP1, yP2, paint);
    
    if (progress >= 1.0) {
      ArrowHeadPainter.draw(canvas, paint, coordinateSystem, Offset(yX, yStart), -math.pi / 2);
    }
  }
}