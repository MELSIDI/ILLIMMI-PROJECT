// element_painters/function2d_element_painter.dart
import 'package:flutter/material.dart';
//import 'dart:math' as math;
import '../../models/hyper_element.dart';
import 'element_painter_interface.dart';
import '../helpers/path_animation.dart';
import '../helpers/function_evaluator.dart';
import '../../models/basic_elements/draw_element.dart';
import '../../models/draw_elements/function2d_element.dart';  
import '../../models/draw_elements/repere2d_element.dart';  
import '../coordinate_system.dart';

class Function2DElementPainter implements ElementPainter {
  @override
  bool canPaint(DrawElement element) => element is Function2DElement;

  @override
  void paint(
    Canvas canvas, 
    CoordinateSystem coordinateSystem, 
    DrawElement element, 
    double progress, 
    Paint paint,
    List<HyperElement> allElements, // Reçoit tous les éléments
  ) {
    final functionElement = element as Function2DElement;
    final drawElements = allElements.whereType<DrawElement>().toList();
    
    // Trouver le repère associé dans tous les éléments
    final repere = _findRepere(drawElements, functionElement.repereId);
    if (repere == null) return;
    
    final path = _createFunctionPath(functionElement, repere);
    if (path != null) {
      PathAnimation.animatePath(canvas, paint, coordinateSystem, path, progress);
    }
  }

  Repere2DElement? _findRepere(List<DrawElement> drawElements, int repereId) {
    for (final element in drawElements) {
      if (element is Repere2DElement && element.id == repereId) {
        return element;
      }
    }
    return null;
  }

  Path? _createFunctionPath(Function2DElement element, Repere2DElement repere) {
    final path = Path();
    bool firstPoint = true;
    int pointsAdded = 0;
    
    final numPoints = 200;
    final step = (repere.xEnd - repere.xStart) / numPoints;
    
    for (int i = 0; i <= numPoints; i++) {
      final x = repere.xStart + i * step;
      final y = FunctionEvaluator.evaluate(element.expression, x);
      
      if (y.isNaN || y.isInfinite) continue;
      if (y < repere.yStart || y > repere.yEnd) continue;
      
      // Conversion des coordonnées mathématiques en coordonnées canvas
      final canvasX = repere.origin.dx + x * repere.scale;
      final canvasY = repere.origin.dy - y * repere.scale; // Inversion Y

      if (firstPoint) {
        path.moveTo(canvasX, canvasY);
        firstPoint = false;
      } else {
        path.lineTo(canvasX, canvasY);
      }
      pointsAdded++;
    }
    
    return pointsAdded > 0 ? path : null;
  }
}