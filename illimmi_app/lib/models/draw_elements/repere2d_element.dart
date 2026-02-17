import 'package:flutter/material.dart';
import '../basic_elements/draw_element.dart';

class Repere2DElement extends DrawElement {
  final Offset origin;      // Position du repère sur le canvas
  final double xStart;        // Borne min de x
  final double xEnd;        // Borne max de x
  final double yStart;        // Borne min de y
  final double yEnd;        // Borne max de y
  final double scale;       // Échelle : 1 unité math = scale pixels

  Repere2DElement({
    required super.id,
    required super.startTime,
    super.duration,
    super.endTime,
    super.color,
    super.width = 1.5,
    required this.origin,
    required this.xStart,
    required this.xEnd,
    required this.yStart,
    required this.yEnd,
    this.scale = 10.0,
  });
}