// helpers/path_animation.dart
import 'package:flutter/material.dart';
import '../coordinate_system.dart';

class PathAnimation {
  static void animatePath(Canvas canvas, Paint paint, CoordinateSystem coordinateSystem, Path path, double progress) {
    final pathMetricsList = path.computeMetrics().toList();
    if (pathMetricsList.isEmpty) return;
    
    final totalLength = pathMetricsList.fold<double>(0.0, (sum, m) => sum + m.length);
    if (totalLength <= 0) return;
    
    final targetLength = totalLength * progress;
    double accumulated = 0.0;
    
    for (final metric in pathMetricsList) {
      if (metric.length <= 0) continue;
      if (accumulated >= targetLength) break;
      
      final remaining = targetLength - accumulated;
      final extractEnd = remaining < metric.length ? remaining : metric.length;
      final extractedPath = metric.extractPath(0.0, extractEnd);
      canvas.drawPath(extractedPath.transform(coordinateSystem.matrix.storage), paint);
      
      accumulated += metric.length;
    }
  }
}