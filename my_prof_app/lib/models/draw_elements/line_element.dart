import 'package:flutter/material.dart';
import '../basic_elements/draw_element.dart';

class LineElement extends DrawElement {
  final Offset? from;
  final Offset? to;
  
  // Nouvelles propriétés pour le pointage textuel
  final int? fromTextId;
  final int? toTextId;
  final String? toTextPattern;
  
  LineElement({
    required super.id, 
    required super.startTime, 
    super.duration, 
    super.color, 
    required super.width, 
    this.from, 
    this.to,
    this.fromTextId,
    this.toTextId,
    this.toTextPattern,
  }) {
    // Validation : soit on a des coordonnées directes, soit des références textuelles
    assert(
      (from != null && to != null) || (fromTextId != null && toTextId != null),
      'LineElement doit avoir soit des coordonnées (from/to) soit des références textuelles (fromTextId/toTextId)',
    );
  }
  
  /// Indique si cette ligne utilise des références textuelles
  bool get usesTextReferences => fromTextId != null || toTextId != null;
}


/*import 'package:flutter/material.dart';
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
}*/