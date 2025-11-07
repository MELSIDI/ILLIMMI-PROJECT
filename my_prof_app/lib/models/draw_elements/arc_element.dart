import 'package:flutter/material.dart';
import '../basic_elements/draw_element.dart';

class ArcElement extends DrawElement {
  final Offset center;
  final double radius;
  final double startAngle;
  final double sweepAngle;
  final bool hasArrowAtEnd;
  final bool? arrowCounterClockwise; // true = sens trigo (+), false = sens horaire (-)
  final Color? fillColor;

  ArcElement({
    required super.id, 
    required super.startTime, 
    super.duration, 
    super.color, 
    required super.width, 
    required this.center, 
    required this.radius, 
    required this.startAngle, 
    required this.sweepAngle, 
    this.hasArrowAtEnd = false,
    this.arrowCounterClockwise,
    this.fillColor
  });
}