// element_painters/repere2d_element_painter.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../models/hyper_element.dart';
import 'element_painter_interface.dart';
import '../helpers/arrow_head_painter.dart';
import '../../models/basic_elements/draw_element.dart';
import '../../models/draw_elements/repere2d_element.dart'; 
import '../coordinate_system.dart';

class Repere2DElementPainter implements ElementPainter {
  @override
  bool canPaint(DrawElement element) => element is Repere2DElement;

  @override
  void paint(
    Canvas canvas,
    CoordinateSystem coordinateSystem,
    DrawElement element,
    double progress,
    Paint paint,
    List<HyperElement> allElements,
  ) {
    final repereElement = element as Repere2DElement;

    // 1. Grille d'arrière-plan (moins opaque, moins dense que les axes)
    if (repereElement.grid && progress > 0.05) {
      _drawGrid(canvas, coordinateSystem, repereElement, progress, paint);
    }

    // 2. Axes principaux (animés avec progression)
    final xFirst = repereElement.id % 2 == 0;
    if (xFirst) {
      _drawXAxisFirst(canvas, coordinateSystem, repereElement, progress, paint);
    } else {
      _drawYAxisFirst(canvas, coordinateSystem, repereElement, progress, paint);
    }

    // 3. Graduations sur les axes (tirets et labels optionnels)
    if (repereElement.step > 0 && progress >= 0.5) {
      final gradProgress = ((progress - 0.5) * 2).clamp(0.0, 1.0);
      _drawGraduations(canvas, coordinateSystem, repereElement, gradProgress, paint);
    }
  }

  void _drawGrid(
    Canvas canvas,
    CoordinateSystem coordinateSystem,
    Repere2DElement element,
    double progress,
    Paint paint,
  ) {
    final step = element.step > 0 ? element.step : 1.0;
    final baseOpacity = (paint.color.opacity * element.gridAlpha).clamp(0.05, 1.0);
    final currentOpacity = (baseOpacity * progress).clamp(0.0, 1.0);

    final gridPaint = Paint()
      ..color = paint.color.withOpacity(currentOpacity)
      ..strokeWidth = math.max(0.5, paint.strokeWidth * 0.45)
      ..style = PaintingStyle.stroke;

    final xStart = element.origin.dx + element.xStart * element.scale;
    final xEnd = element.origin.dx + element.xEnd * element.scale;
    final yTop = element.origin.dy - element.yEnd * element.scale;
    final yBottom = element.origin.dy - element.yStart * element.scale;

    // Lignes verticales de la grille
    final firstXMultiple = (element.xStart / step).ceil();
    final lastXMultiple = (element.xEnd / step).floor();
    for (int k = firstXMultiple; k <= lastXMultiple; k++) {
      final mathX = k * step;
      final canvasX = element.origin.dx + mathX * element.scale;
      final p1 = coordinateSystem.transformPoint(Offset(canvasX, yTop));
      final p2 = coordinateSystem.transformPoint(Offset(canvasX, yBottom));
      canvas.drawLine(p1, p2, gridPaint);
    }

    // Lignes horizontales de la grille
    final firstYMultiple = (element.yStart / step).ceil();
    final lastYMultiple = (element.yEnd / step).floor();
    for (int k = firstYMultiple; k <= lastYMultiple; k++) {
      final mathY = k * step;
      final canvasY = element.origin.dy - mathY * element.scale;
      final p1 = coordinateSystem.transformPoint(Offset(xStart, canvasY));
      final p2 = coordinateSystem.transformPoint(Offset(xEnd, canvasY));
      canvas.drawLine(p1, p2, gridPaint);
    }
  }

  void _drawGraduations(
    Canvas canvas,
    CoordinateSystem coordinateSystem,
    Repere2DElement element,
    double progress,
    Paint paint,
  ) {
    final step = element.step > 0 ? element.step : 1.0;
    final tickHalf = 0.8; // Demi-longueur du tiret de graduation (1.6u total)

    final tickPaint = Paint()
      ..color = paint.color.withOpacity((paint.color.opacity * progress).clamp(0.0, 1.0))
      ..strokeWidth = math.max(0.8, paint.strokeWidth * 0.85)
      ..style = PaintingStyle.stroke;

    // Graduations sur l'axe X (sauf à l'origine x=0)
    final firstXMultiple = (element.xStart / step).ceil();
    final lastXMultiple = (element.xEnd / step).floor();
    for (int k = firstXMultiple; k <= lastXMultiple; k++) {
      if (k == 0) continue; // Origine
      final mathX = k * step;
      final canvasX = element.origin.dx + mathX * element.scale;
      final p1 = coordinateSystem.transformPoint(Offset(canvasX, element.origin.dy - tickHalf));
      final p2 = coordinateSystem.transformPoint(Offset(canvasX, element.origin.dy + tickHalf));
      canvas.drawLine(p1, p2, tickPaint);

      if (element.showLabels && progress >= 0.95) {
        _drawLabel(canvas, coordinateSystem, '$k', Offset(canvasX, element.origin.dy + 1.2), paint.color);
      }
    }

    // Graduations sur l'axe Y (sauf à l'origine y=0)
    final firstYMultiple = (element.yStart / step).ceil();
    final lastYMultiple = (element.yEnd / step).floor();
    for (int k = firstYMultiple; k <= lastYMultiple; k++) {
      if (k == 0) continue; // Origine
      final mathY = k * step;
      final canvasY = element.origin.dy - mathY * element.scale;
      final p1 = coordinateSystem.transformPoint(Offset(element.origin.dx - tickHalf, canvasY));
      final p2 = coordinateSystem.transformPoint(Offset(element.origin.dx + tickHalf, canvasY));
      canvas.drawLine(p1, p2, tickPaint);

      if (element.showLabels && progress >= 0.95) {
        _drawLabel(canvas, coordinateSystem, '$k', Offset(element.origin.dx - 2.0, canvasY - 0.6), paint.color);
      }
    }
  }

  void _drawLabel(
    Canvas canvas,
    CoordinateSystem coordinateSystem,
    String text,
    Offset canvasPos,
    Color color,
  ) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(
        color: color.withOpacity(0.85),
        fontSize: math.max(8.0, coordinateSystem.transformScale(2.2)),
        fontWeight: FontWeight.w500,
      ),
    );
    final tp = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();
    final p = coordinateSystem.transformPoint(canvasPos);
    tp.paint(canvas, Offset(p.dx - tp.width / 2, p.dy));
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
