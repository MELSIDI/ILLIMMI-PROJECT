import 'package:flutter/material.dart';
import '../hyper_element.dart';

// --- ÉLÉMENTS DE DESSIN (STRUCTURÉS) ---
abstract class DrawElement extends HyperElement {
  final Color? color;
  final double width;
  DrawElement({
    required super.id, 
    required super.startTime, 
    this.color, 
    this.width = 2.5,
  });
}