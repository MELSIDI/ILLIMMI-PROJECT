// helpers/path_animation.dart
import 'package:flutter/material.dart';
import '../coordinate_system.dart';

class PathAnimation {
  static void animatePath(Canvas canvas, Paint paint, CoordinateSystem coordinateSystem, Path path, double progress) {
    final pathMetricsList = path.computeMetrics().toList();
    
    if (pathMetricsList.isEmpty) return;
    
    final metric = pathMetricsList.first;
    
    if (metric.length <= 0) return;
    
    final extractedPath = metric.extractPath(0.0, metric.length * progress);
    canvas.drawPath(extractedPath.transform(coordinateSystem.matrix.storage), paint);
  }
}