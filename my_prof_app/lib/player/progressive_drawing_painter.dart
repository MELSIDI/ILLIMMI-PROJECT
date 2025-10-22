// lib/player/progressive_drawing_painter.dart

import 'package:flutter/material.dart';

class ProgressiveDrawingPainter extends CustomPainter {
  final Path path;
  final double progress; // Progrès de l'animation (0.0 à 1.0)

  ProgressiveDrawingPainter({required this.path, required this.progress, required bool isArrow});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    // 1. On calcule les métriques du chemin
    final pathMetrics = path.computeMetrics();

    // 2. On parcourt chaque contour du chemin (généralement un seul)
    for (final metric in pathMetrics) {
      // 3. On extrait un segment du chemin basé sur le progrès
      final extractedPath = metric.extractPath(0.0, metric.length * progress);
      
      // On met à l'échelle et on dessine le segment extrait
      final matrix = Matrix4.identity()..scale(size.width / 100, size.height / 100);
      canvas.drawPath(extractedPath.transform(matrix.storage), paint);
    }
  }

  @override
  bool shouldRepaint(covariant ProgressiveDrawingPainter oldDelegate) {
    // On redessine uniquement si le progrès a changé
    return oldDelegate.progress != progress || oldDelegate.path != path;
  }
}