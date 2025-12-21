// element_painters/element_painter_interface.dart
import 'package:flutter/material.dart';
import '../coordinate_system.dart';
import '../../models/basic_elements/draw_element.dart';

abstract class ElementPainter {
  bool canPaint(DrawElement element);
  void paint(
    Canvas canvas,
    CoordinateSystem coordinateSystem,
    DrawElement element,
    double progress,
    Paint paint,
    List<DrawElement> allElements, // Ajout de tous les éléments pour le contexte
  );
}