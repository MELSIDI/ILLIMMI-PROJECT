import 'package:flutter/material.dart';
import '../basic_elements/draw_element.dart';

class LineElement extends DrawElement {
  final Offset from;
  final Offset to;
  LineElement({
    required super.id, 
    required super.startTime, 
    super.duration, 
    super.color, 
    required super.width, 
    required this.from, 
    required this.to
  });
}