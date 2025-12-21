import 'package:flutter/material.dart';
import '../basic_elements/draw_element.dart';

// NOUVEAU : Arc elliptique
class EllipticArcElement extends DrawElement {
  final Offset center;
  final double radiusX;
  final double radiusY;
  final double rotation;
  final double startAngle;
  final double sweepAngle;
  final bool hasArrowAtEnd;
  final bool? arrowCounterClockwise;
  final Color? fillColor;

  EllipticArcElement({
    required super.id,
    required super.startTime,
    super.duration,
    super.color,
    required super.width,
    required this.center,
    required this.radiusX,
    required this.radiusY,
    this.rotation = 0.0,
    required this.startAngle,
    required this.sweepAngle,
    this.hasArrowAtEnd = false,
    this.arrowCounterClockwise,
    this.fillColor,
  });
}
