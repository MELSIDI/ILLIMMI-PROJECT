import 'package:flutter/material.dart';
import '../hyper_element.dart';

class MouseEvent extends HyperElement {
  final List<Offset> points;
  MouseEvent({
    required super.id, 
    required super.startTime, 
    super.duration, 
    required this.points
  });
}
