import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/hyper_element.dart';

class BoardPainter extends CustomPainter {
  final List<DrawElement> drawElements;
  final double currentTime;
  final Color defaultColor;
  final bool showGrid;

  BoardPainter({
    required this.drawElements,
    required this.currentTime,
    this.defaultColor = Colors.black,
    this.showGrid = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Système de coordonnées 16:9 uniforme
    final aspectRatio = 16.0 / 9.0;
    final referenceWidth = 100.0 * aspectRatio;
    final referenceHeight = 100.0;
    
    final scaleX = size.width / referenceWidth;
    final scaleY = size.height / referenceHeight;
    final uniformScale = scaleX < scaleY ? scaleX : scaleY;
    
    final offsetX = (size.width - referenceWidth * uniformScale) / 2;
    final offsetY = (size.height - referenceHeight * uniformScale) / 2;
    
    final matrix = Matrix4.identity()
      ..translate(offsetX, offsetY)
      ..scale(uniformScale, uniformScale);

    if (showGrid) {
      _drawGrid(canvas, matrix, referenceWidth, referenceHeight);
    }

    for (final element in drawElements) {
      final progress = ((currentTime - element.startTime) / (element.duration > 0 ? element.duration : 1.0)).clamp(0.0, 1.0);
      
      if (progress <= 0.0) continue;
      
      final paint = Paint()
        ..strokeWidth = element.width
        ..color = element.color ?? defaultColor
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      if (element is LineElement) {
        _drawLine(canvas, paint, matrix, element, progress);
      } else if (element is PathElement) {
        _drawPath(canvas, paint, matrix, element, progress);
      } else if (element is CurveElement) {
        _drawCurve(canvas, paint, matrix, element, progress);
      } else if (element is PolygonElement) {
        _drawPolygon(canvas, paint, matrix, element, progress);
      } else if (element is CircleElement) {
        _drawCircle(canvas, paint, matrix, element, progress);
      } else if (element is EllipseElement) {
        _drawEllipse(canvas, paint, matrix, element, progress);
      } else if (element is EllipticArcElement) {
        _drawEllipticArc(canvas, paint, matrix, element, progress);
      } else if (element is ArcElement) {
        _drawArc(canvas, paint, matrix, element, progress);
      } else if (element is Repere2DElement) {
        _drawRepere2D(canvas, matrix, element, progress);
      } else if (element is Function2DElement) {
        for (final el in drawElements) {
          if (el is Repere2DElement && el.id == element.repereId) {
            _drawFunction2D(canvas, paint, matrix, element, el, progress);
            break;
          }
        }
      }
    }
  }

  void _drawLine(Canvas canvas, Paint paint, Matrix4 matrix, LineElement element, double progress) {
    final path = Path()
      ..moveTo(element.from.dx, element.from.dy)
      ..lineTo(element.to.dx, element.to.dy);

    _animatePath(canvas, paint, matrix, path, progress);

    if (element is ArrowElement && progress >= 1.0) {
      final angle = (element.to - element.from).direction;
      _drawArrowHead(canvas, paint, matrix, element.to, angle);
    }
  }

  void _drawPath(Canvas canvas, Paint paint, Matrix4 matrix, PathElement element, double progress) {
    if (element.points.isEmpty) return;
    
    final path = Path();
    path.moveTo(element.points.first.dx, element.points.first.dy);
    for (int i = 1; i < element.points.length; i++) {
      path.lineTo(element.points[i].dx, element.points[i].dy);
    }
    _animatePath(canvas, paint, matrix, path, progress);
  }

  void _drawCurve(Canvas canvas, Paint paint, Matrix4 matrix, CurveElement element, double progress) {
    if (element.points.length < 2) return;
    
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
    
    _animatePath(canvas, paint, matrix, path, progress);
    
    if (element.hasArrowAtEnd && progress >= 1.0) {
      final lastPoint = element.points.last;
      final secondLastPoint = element.points[element.points.length - 2];
      
      double angle = (lastPoint - secondLastPoint).direction;
      
      if (element.arrowCounterClockwise == false) {
        angle += math.pi;
      }
      
      _drawArrowHead(canvas, paint, matrix, lastPoint, angle);
    }
  }

  void _drawPolygon(Canvas canvas, Paint paint, Matrix4 matrix, PolygonElement element, double progress) {
    if (element.points.isEmpty) return;
    
    final path = Path();
    path.moveTo(element.points.first.dx, element.points.first.dy);
    for (int i = 1; i < element.points.length; i++) {
      path.lineTo(element.points[i].dx, element.points[i].dy);
    }
    path.close();
    
    _animatePath(canvas, paint, matrix, path, progress);

    if (element.fillColor != null && progress >= 1.0) {
      final fillPaint = Paint()
        ..color = element.fillColor!
        ..style = PaintingStyle.fill;
      canvas.drawPath(path.transform(matrix.storage), fillPaint);
    }
  }

  void _drawCircle(Canvas canvas, Paint paint, Matrix4 matrix, CircleElement element, double progress) {
    final rect = Rect.fromCircle(center: element.center, radius: element.radius);
    final topLeft = MatrixUtils.transformPoint(matrix, rect.topLeft);
    final bottomRight = MatrixUtils.transformPoint(matrix, rect.bottomRight);

    canvas.drawArc(
      Rect.fromPoints(topLeft, bottomRight),
      -math.pi / 2,
      (2 * math.pi) * progress,
      false,
      paint,
    );

    final sx = matrix.storage[0];
    final sy = matrix.storage[5];
    final radiusScaled = element.radius * ((sx + sy) / 2);

    if (element.fillColor != null && progress >= 1.0) {
      final fillPaint = Paint()
        ..color = element.fillColor!
        ..style = PaintingStyle.fill;
      final centerTrans = MatrixUtils.transformPoint(matrix, element.center);
      canvas.drawCircle(centerTrans, radiusScaled, fillPaint);
    }

    if (element.arrowAngle != null && progress >= 1.0) {
      final angleRad = (element.arrowAngle! - 90) * (math.pi / 180.0);
      final pointOnCircle = element.center + Offset.fromDirection(angleRad, element.radius);
      
      double arrowDirection;
      if (element.arrowCounterClockwise == true) {
        arrowDirection = angleRad + math.pi / 2;
      } else if (element.arrowCounterClockwise == false) {
        arrowDirection = angleRad - math.pi / 2;
      } else {
        arrowDirection = angleRad + math.pi / 2;
      }
      
      _drawArrowHead(canvas, paint, matrix, pointOnCircle, arrowDirection);
    }
  }

  void _drawEllipse(Canvas canvas, Paint paint, Matrix4 matrix, EllipseElement element, double progress) {
    canvas.save();
    
    final centerTrans = MatrixUtils.transformPoint(matrix, element.center);
    canvas.translate(centerTrans.dx, centerTrans.dy);
    canvas.rotate(element.rotation);
    
    final sx = matrix.storage[0];
    final sy = matrix.storage[5];
    
    final scaledRect = Rect.fromCenter(
      center: Offset.zero,
      width: element.radiusX * 2 * sx,
      height: element.radiusY * 2 * sy,
    );

    canvas.drawArc(
      scaledRect,
      -math.pi / 2,
      (2 * math.pi) * progress,
      false,
      paint,
    );

    if (element.fillColor != null && progress >= 1.0) {
      final fillPaint = Paint()
        ..color = element.fillColor!
        ..style = PaintingStyle.fill;
      canvas.drawOval(scaledRect, fillPaint);
    }

    if (element.arrowAngle != null && progress >= 1.0) {
      final angleRad = (element.arrowAngle! - 90) * (math.pi / 180.0);
      
      final x = element.radiusX * math.cos(angleRad) * sx;
      final y = element.radiusY * math.sin(angleRad) * sy;
      final pointOnEllipse = Offset(x, y);
      
      double tangentAngle = math.atan2(-element.radiusX * math.sin(angleRad), element.radiusY * math.cos(angleRad));
      
      double arrowDirection;
      if (element.arrowCounterClockwise == true) {
        arrowDirection = tangentAngle + element.rotation;
      } else if (element.arrowCounterClockwise == false) {
        arrowDirection = tangentAngle + math.pi + element.rotation;
      } else {
        arrowDirection = tangentAngle + element.rotation;
      }
      
      final arrowSize = paint.strokeWidth * 1.5;
      final arrowAngle = math.pi / 6;
      final p1 = Offset(
        pointOnEllipse.dx - arrowSize * math.cos(arrowDirection - arrowAngle),
        pointOnEllipse.dy - arrowSize * math.sin(arrowDirection - arrowAngle)
      );
      final p2 = pointOnEllipse;
      final p3 = Offset(
        pointOnEllipse.dx - arrowSize * math.cos(arrowDirection + arrowAngle),
        pointOnEllipse.dy - arrowSize * math.sin(arrowDirection + arrowAngle)
      );

      final arrowPath = Path()
        ..moveTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..lineTo(p3.dx, p3.dy);

      canvas.drawPath(arrowPath, paint);
    }

    canvas.restore();
  }

  void _drawArc(Canvas canvas, Paint paint, Matrix4 matrix, ArcElement element, double progress) {
    final rect = Rect.fromCircle(center: element.center, radius: element.radius);
    final topLeft = MatrixUtils.transformPoint(matrix, rect.topLeft);
    final bottomRight = MatrixUtils.transformPoint(matrix, rect.bottomRight);

    final startAngleRad = element.startAngle - math.pi / 2;
    final sweepAngleRad = element.sweepAngle;

    canvas.drawArc(
      Rect.fromPoints(topLeft, bottomRight),
      startAngleRad,
      sweepAngleRad * progress,
      false,
      paint,
    );

    if (element.fillColor != null && progress >= 1.0) {
      final fillPaint = Paint()
        ..color = element.fillColor!
        ..style = PaintingStyle.fill;
      canvas.drawArc(
        Rect.fromPoints(topLeft, bottomRight),
        startAngleRad,
        sweepAngleRad,
        true,
        fillPaint,
      );
    }

    if (element.hasArrowAtEnd && progress >= 1.0) {
      final endAngleRad = startAngleRad + sweepAngleRad;
      final pointOnCircle = element.center + Offset.fromDirection(endAngleRad, element.radius);
      
      double arrowDirection;
      if (element.arrowCounterClockwise == false) {
        arrowDirection = endAngleRad - math.pi / 2;
      } else {
        arrowDirection = endAngleRad + math.pi / 2;
      }
      
      _drawArrowHead(canvas, paint, matrix, pointOnCircle, arrowDirection);
    }
  }

  void _drawEllipticArc(Canvas canvas, Paint paint, Matrix4 matrix, EllipticArcElement element, double progress) {
    canvas.save();
    
    final centerTrans = MatrixUtils.transformPoint(matrix, element.center);
    canvas.translate(centerTrans.dx, centerTrans.dy);
    canvas.rotate(element.rotation);
    
    final sx = matrix.storage[0];
    final sy = matrix.storage[5];
    
    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: element.radiusX * 2 * sx,
      height: element.radiusY * 2 * sy,
    );

    final startAngleRad = element.startAngle - math.pi / 2;
    final sweepAngleRad = element.sweepAngle;

    canvas.drawArc(
      rect,
      startAngleRad,
      sweepAngleRad * progress,
      false,
      paint,
    );

    if (element.fillColor != null && progress >= 1.0) {
      final fillPaint = Paint()
        ..color = element.fillColor!
        ..style = PaintingStyle.fill;
      canvas.drawArc(rect, startAngleRad, sweepAngleRad, true, fillPaint);
    }

    if (element.hasArrowAtEnd && progress >= 1.0) {
      final endAngleRad = startAngleRad + sweepAngleRad;
      
      final x = element.radiusX * math.cos(endAngleRad + element.rotation) * sx;
      final y = element.radiusY * math.sin(endAngleRad + element.rotation) * sy;
      final pointOnEllipse = Offset(x, y);
      
      double tangentAngle = math.atan2(-element.radiusX * math.sin(endAngleRad), element.radiusY * math.cos(endAngleRad));
      
      double arrowDirection;
      if (element.arrowCounterClockwise == true) {
        arrowDirection = tangentAngle + math.pi + element.rotation;
      } else {
        arrowDirection = tangentAngle + element.rotation;
      }
      
      final arrowSize = paint.strokeWidth * 1.5;
      final arrowAngle = math.pi / 6;
      final p1 = Offset(
        pointOnEllipse.dx - arrowSize * math.cos(arrowDirection - arrowAngle),
        pointOnEllipse.dy - arrowSize * math.sin(arrowDirection - arrowAngle)
      );
      final p2 = pointOnEllipse;
      final p3 = Offset(
        pointOnEllipse.dx - arrowSize * math.cos(arrowDirection + arrowAngle),
        pointOnEllipse.dy - arrowSize * math.sin(arrowDirection + arrowAngle)
      );

      final arrowPath = Path()
        ..moveTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..lineTo(p3.dx, p3.dy);

      canvas.drawPath(arrowPath, paint);
    }

    canvas.restore();
  }

  void _animatePath(Canvas canvas, Paint paint, Matrix4 matrix, Path path, double progress) {
    final pathMetricsList = path.computeMetrics().toList();
    
    if (pathMetricsList.isEmpty) return;
    
    final metric = pathMetricsList.first;
    
    if (metric.length <= 0) return;
    
    final extractedPath = metric.extractPath(0.0, metric.length * progress);
    canvas.drawPath(extractedPath.transform(matrix.storage), paint);
  }

  void _drawArrowHead(Canvas canvas, Paint paint, Matrix4 matrix, Offset position, double angle) {
    final arrowSize = paint.strokeWidth * 1.5;
    final arrowAngle = math.pi / 6;
    final p1 = Offset(
      position.dx - arrowSize * math.cos(angle - arrowAngle), 
      position.dy - arrowSize * math.sin(angle - arrowAngle)
    );
    final p2 = Offset(position.dx, position.dy);
    final p3 = Offset(
      position.dx - arrowSize * math.cos(angle + arrowAngle), 
      position.dy - arrowSize * math.sin(angle + arrowAngle)
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

    canvas.drawPath(arrowPath.transform(matrix.storage), arrowPaint);
  }

  void _drawGrid(Canvas canvas, Matrix4 matrix, double width, double height) {
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    for (double x = 0; x <= width; x += 10) {
      final p1 = MatrixUtils.transformPoint(matrix, Offset(x, 0));
      final p2 = MatrixUtils.transformPoint(matrix, Offset(x, height));
      canvas.drawLine(p1, p2, gridPaint);
    }

    for (double y = 0; y <= height; y += 10) {
      final p1 = MatrixUtils.transformPoint(matrix, Offset(0, y));
      final p2 = MatrixUtils.transformPoint(matrix, Offset(width, y));
      canvas.drawLine(p1, p2, gridPaint);
    }

    final axisPaint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final xStart = MatrixUtils.transformPoint(matrix, Offset(0, height / 2));
    final xEnd = MatrixUtils.transformPoint(matrix, Offset(width, height / 2));
    canvas.drawLine(xStart, xEnd, axisPaint);

    final yStart = MatrixUtils.transformPoint(matrix, Offset(width / 2, 0));
    final yEnd = MatrixUtils.transformPoint(matrix, Offset(width / 2, height));
    canvas.drawLine(yStart, yEnd, axisPaint);
  }

  // === DESSINER LE REPÈRE 2D AVEC FLÈCHES ET ANIMATION ===
  void _drawRepere2D(Canvas canvas, Matrix4 matrix, Repere2DElement element, double progress) {
    final paint = Paint()
      ..strokeWidth = element.width
      ..color = element.color ?? Colors.grey.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Déterminer l'ordre aléatoire basé sur l'ID (pour cohérence)
    final bool xFirst = element.id % 2 == 0;
    
    // Coordonnées des axes
    final xStart = element.origin.dx + element.xStart * element.scale;
    final xEnd = element.origin.dx + element.xEnd * element.scale;
    final xY = element.origin.dy;
    
    final yX = element.origin.dx;
    final yStart = element.origin.dy - element.yEnd * element.scale;
    final yEnd = element.origin.dy - element.yStart * element.scale;

    if (xFirst) {
      // Axe X d'abord (première moitié), puis axe Y (deuxième moitié)
      
      // Axe X : progression de 0 à 0.5
      if (progress > 0) {
        final xProgress = (progress * 2).clamp(0.0, 1.0);
        final currentXEnd = xStart + (xEnd - xStart) * xProgress;
        
        final xP1 = MatrixUtils.transformPoint(matrix, Offset(xStart, xY));
        final xP2 = MatrixUtils.transformPoint(matrix, Offset(currentXEnd, xY));
        canvas.drawLine(xP1, xP2, paint);
        
        // Flèche seulement quand l'axe est complètement tracé
        if (xProgress >= 1.0) {
          _drawArrowHead(canvas, paint, matrix, Offset(xEnd, xY), 0);
        }
      }
      
      // Axe Y : progression de 0.5 à 1.0
      if (progress > 0.5) {
        final yProgress = ((progress - 0.5) * 2).clamp(0.0, 1.0);
        final currentYStart = yEnd - (yEnd - yStart) * yProgress;
        
        final yP1 = MatrixUtils.transformPoint(matrix, Offset(yX, yEnd));
        final yP2 = MatrixUtils.transformPoint(matrix, Offset(yX, currentYStart));
        canvas.drawLine(yP1, yP2, paint);
        
        // Flèche seulement quand l'axe est complètement tracé
        if (yProgress >= 1.0) {
          _drawArrowHead(canvas, paint, matrix, Offset(yX, yStart), -math.pi / 2);
        }
      }
    } else {
      // Axe Y d'abord (première moitié), puis axe X (deuxième moitié)
      
      // Axe Y : progression de 0 à 0.5
      if (progress > 0) {
        final yProgress = (progress * 2).clamp(0.0, 1.0);
        final currentYStart = yEnd - (yEnd - yStart) * yProgress;
        
        final yP1 = MatrixUtils.transformPoint(matrix, Offset(yX, yEnd));
        final yP2 = MatrixUtils.transformPoint(matrix, Offset(yX, currentYStart));
        canvas.drawLine(yP1, yP2, paint);
        
        // Flèche seulement quand l'axe est complètement tracé
        if (yProgress >= 1.0) {
          _drawArrowHead(canvas, paint, matrix, Offset(yX, yStart), -math.pi / 2);
        }
      }
      
      // Axe X : progression de 0.5 à 1.0
      if (progress > 0.5) {
        final xProgress = ((progress - 0.5) * 2).clamp(0.0, 1.0);
        final currentXEnd = xStart + (xEnd - xStart) * xProgress;
        
        final xP1 = MatrixUtils.transformPoint(matrix, Offset(xStart, xY));
        final xP2 = MatrixUtils.transformPoint(matrix, Offset(currentXEnd, xY));
        canvas.drawLine(xP1, xP2, paint);
        
        // Flèche seulement quand l'axe est complètement tracé
        if (xProgress >= 1.0) {
          _drawArrowHead(canvas, paint, matrix, Offset(xEnd, xY), 0);
        }
      }
    }
  }

  // === FONCTION 2D CORRIGÉE ===
  void _drawFunction2D(Canvas canvas, Paint paint, Matrix4 matrix, Function2DElement element, Repere2DElement repere, double progress) {
    final path = Path();
    bool firstPoint = true;
    int pointsAdded = 0;
    
    final numPoints = 200;
    final step = (repere.xEnd - repere.xStart) / numPoints;
    
    for (int i = 0; i <= numPoints; i++) {
      final x = repere.xStart + i * step;
      
      // 🔥 CORRECTION CRITIQUE : Passer x à l'évaluation !
      final y = _evaluateFunction(element.expression, x);
      
      if (y.isNaN || y.isInfinite) continue;
      if (y < repere.yStart || y > repere.yEnd) continue;
      
      // Coordonnées canvas
      final canvasX = repere.origin.dx + x * repere.scale;
      final canvasY = repere.origin.dy - y * repere.scale;

      if (firstPoint) {
        path.moveTo(canvasX, canvasY);
        firstPoint = false;
      } else {
        path.lineTo(canvasX, canvasY);
      }
      pointsAdded++;
    }
    
    if (pointsAdded > 0) {
      _animatePath(canvas, paint, matrix, path, progress);
    }
  }

  // Évaluer la fonction avec une valeur de x
  double _evaluateFunction(String expr, double xValue) {
    expr = expr.trim();
    
    // Remplacer x par sa valeur
    String replaced = expr.replaceAllMapped(
      RegExp(r'\bx\b'),
      (match) => '($xValue)'
    );
    
    try {
      return _evalExpression(replaced);
    } catch (e) {
      return double.nan;
    }
  }

  double _evalExpression(String expr) {
    expr = expr.trim();
    
    // Enlever les parenthèses externes
    while (expr.startsWith('(') && expr.endsWith(')') && _matchingParen(expr, 0) == expr.length - 1) {
      expr = expr.substring(1, expr.length - 1).trim();
    }
    
    // Fonctions mathématiques
    if (expr.startsWith('sin(')) {
      final inner = _extractFunctionArg(expr, 'sin');
      return math.sin(_evalExpression(inner));
    }
    if (expr.startsWith('cos(')) {
      final inner = _extractFunctionArg(expr, 'cos');
      return math.cos(_evalExpression(inner));
    }
    if (expr.startsWith('tan(')) {
      final inner = _extractFunctionArg(expr, 'tan');
      return math.tan(_evalExpression(inner));
    }
    if (expr.startsWith('sqrt(')) {
      final inner = _extractFunctionArg(expr, 'sqrt');
      return math.sqrt(_evalExpression(inner));
    }
    if (expr.startsWith('exp(')) {
      final inner = _extractFunctionArg(expr, 'exp');
      return math.exp(_evalExpression(inner));
    }
    if (expr.startsWith('abs(')) {
      final inner = _extractFunctionArg(expr, 'abs');
      return _evalExpression(inner).abs();
    }
    if (expr.startsWith('ln(') || expr.startsWith('log(')) {
      final funcName = expr.startsWith('ln(') ? 'ln' : 'log';
      final inner = _extractFunctionArg(expr, funcName);
      return math.log(_evalExpression(inner));
    }
    
    // Constantes
    if (expr == 'pi') return math.pi;
    if (expr == 'e') return math.e;
    
    // Opérateurs binaires (priorité basse)
    int opPos = _findOperatorOutsideParens(expr, ['+', '-']);
    if (opPos != -1) {
      final left = expr.substring(0, opPos).trim();
      final right = expr.substring(opPos + 1).trim();
      final op = expr[opPos];
      
      if (op == '+') {
        return _evalExpression(left) + _evalExpression(right);
      } else {
        return _evalExpression(left) - _evalExpression(right);
      }
    }
    
    // Multiplication et division
    opPos = _findOperatorOutsideParens(expr, ['*', '/']);
    if (opPos != -1) {
      final left = expr.substring(0, opPos).trim();
      final right = expr.substring(opPos + 1).trim();
      final op = expr[opPos];
      
      if (op == '*') {
        return _evalExpression(left) * _evalExpression(right);
      } else {
        final divisor = _evalExpression(right);
        if (divisor == 0) return double.infinity;
        return _evalExpression(left) / divisor;
      }
    }
    
    // Puissance
    opPos = _findOperatorOutsideParens(expr, ['^']);
    if (opPos != -1) {
      final left = expr.substring(0, opPos).trim();
      final right = expr.substring(opPos + 1).trim();
      return math.pow(_evalExpression(left), _evalExpression(right)).toDouble();
    }
    
    // Nombre simple
    final num = double.tryParse(expr);
    if (num != null) return num;
    
    throw Exception('Expression non reconnue: "$expr"');
  }

  String _extractFunctionArg(String expr, String funcName) {
    final start = funcName.length + 1;
    final end = _matchingParen(expr, funcName.length);
    return expr.substring(start, end);
  }

  int _matchingParen(String expr, int openPos) {
    int level = 0;
    for (int i = openPos; i < expr.length; i++) {
      if (expr[i] == '(') level++;
      if (expr[i] == ')') {
        level--;
        if (level == 0) return i;
      }
    }
    return expr.length - 1;
  }

  int _findOperatorOutsideParens(String expr, List<String> operators) {
    int level = 0;
    for (int i = expr.length - 1; i >= 0; i--) {
      if (expr[i] == ')') level++;
      if (expr[i] == '(') level--;
      
      if (level == 0 && operators.contains(expr[i])) {
        if (expr[i] == '-' && i == 0) continue;
        if (expr[i] == '-' && i > 0 && '(+-*/^'.contains(expr[i-1])) continue;
        
        return i;
      }
    }
    return -1;
  }
  
  @override
  bool shouldRepaint(covariant BoardPainter oldDelegate) => true;
}