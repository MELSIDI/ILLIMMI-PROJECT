import 'package:flutter/material.dart';
import '../hyper_element.dart';

class TextElement extends HyperElement {
  final String content;
  final Offset position;
  TextElement({
    required super.id, 
    required super.startTime, 
    super.duration,
    super.endTime,  
    required this.content, 
    required this.position
  });
}