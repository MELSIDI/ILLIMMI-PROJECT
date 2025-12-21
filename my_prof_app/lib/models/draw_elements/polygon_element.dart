import 'package:flutter/material.dart';
import '../basic_elements/draw_element.dart';

class PolygonElement extends DrawElement {
  final List<Offset> points;
  final Color? fillColor;
  PolygonElement({
    required super.id,
    required super.startTime,
    super.duration, 
    super.color, 
    required super.width, 
    required this.points, 
    this.fillColor
  });
}