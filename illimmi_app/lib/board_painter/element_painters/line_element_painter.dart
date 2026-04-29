// element_painters/line_element_painter.dart (Enhanced)
import 'package:illimmi_app/models/basic_elements/text_element.dart';
import 'package:illimmi_app/models/hyper_element.dart';

import 'element_painter_interface.dart';
import '../helpers/path_animation.dart';
import '../helpers/arrow_head_painter.dart';
import '../../models/basic_elements/draw_element.dart';
//import '../../models/basic_elements/text_element.dart';
import '../../models/draw_elements/line_element.dart';
import '../../models/draw_elements/arrow_element.dart';
import '../coordinate_system.dart';
import '../helpers/text_pattern_finder.dart';
import 'package:flutter/material.dart';

class LineElementPainter implements ElementPainter {
  @override
  bool canPaint(DrawElement element) => element is LineElement;

  @override
  void paint(
    Canvas canvas,
    CoordinateSystem coordinateSystem,
    DrawElement element,
    double progress,
    Paint paint,
    List<HyperElement> allElements,
  ) {
    final lineElement = element as LineElement;

    // Déterminer les points de départ et d'arrivée
    Offset? fromPoint;
    Offset? toPoint;

    if (lineElement.usesTextReferences) {
      // Calculer les positions à partir des références textuelles
      final positions = _resolveTextReferences(
        lineElement,
        allElements.whereType<TextElement>().toList(),
      );
      fromPoint = positions['from'];
      toPoint = positions['to'];

      // Si les positions ne peuvent pas être résolues, ne rien dessiner
      if (fromPoint == null || toPoint == null) {
        print(
          '⚠️ Impossible de résoudre les références textuelles pour LineElement ${lineElement.id}',
        );
        return;
      }
    } else {
      // Utiliser les coordonnées directes
      fromPoint = lineElement.from;
      toPoint = lineElement.to;
    }

    final path = Path()
      ..moveTo(fromPoint!.dx, fromPoint.dy)
      ..lineTo(toPoint!.dx, toPoint.dy);

    PathAnimation.animatePath(canvas, paint, coordinateSystem, path, progress);

    if (lineElement is ArrowElement && progress >= 1.0) {
      final angle = (toPoint - fromPoint).direction;
      ArrowHeadPainter.draw(canvas, paint, coordinateSystem, toPoint, angle);
    }
  }

  /// Résout les références textuelles pour obtenir les coordonnées réelles
  /// Les coordonnées retournées sont dans le système de référence 16:9 (0-177.78, 0-100)
  Map<String, Offset?> _resolveTextReferences(
    LineElement lineElement,
    List<TextElement> textElements,
  ) {
    Offset? fromPoint;
    Offset? toPoint;

    // Trouver les TextElement source et cible
    TextElement? fromText;
    TextElement? toText;

    if (lineElement.fromTextId != null) {
      fromText = TextPatternFinder.findTextElementById(
        textElements,
        lineElement.fromTextId!,
      );
    }

    if (lineElement.toTextId != null) {
      toText = TextPatternFinder.findTextElementById(
        textElements,
        lineElement.toTextId!,
      );
    }

    // Si on a les deux textes, calculer le point de départ intelligent
    if (fromText != null && toText != null) {
      // Utiliser la méthode intelligente qui adapte le point de départ selon la direction
      fromPoint = TextPatternFinder.findTextStartPosition(
        fromText,
        toText,
        24.0,
      );
      print(
        '📍 Point de départ intelligent (fromText id=${fromText.id}): $fromPoint',
      );

      // Trouver la position du pattern dans le texte cible (centre du pattern)
      toPoint = TextPatternFinder.findPatternPosition(
        toText,
        lineElement.toTextPattern ?? '',
        24.0,
      );
      print('📍 Point d\'arrivée (toText id=${toText.id}): $toPoint');
    } else {
      print('⚠️ Impossible de trouver les TextElement source ou cible');
    }

    return {'from': fromPoint, 'to': toPoint};
  }
}

/*// element_painters/line_element_painter.dart
import 'element_painter_interface.dart';
import '../helpers/path_animation.dart';
import '../helpers/arrow_head_painter.dart';
import '../../models/basic_elements/draw_element.dart';
import '../../models/draw_elements/line_element.dart'; 
import '../../models/draw_elements/arrow_element.dart'; 
import '../coordinate_system.dart';
import 'package:flutter/material.dart';

class LineElementPainter implements ElementPainter {
  @override
  bool canPaint(DrawElement element) => element is LineElement;

  @override
  void paint(Canvas canvas, CoordinateSystem coordinateSystem, DrawElement element, double progress, Paint paint, List<DrawElement> allElements) {
    final lineElement = element as LineElement;

    final path = Path()
      ..moveTo(lineElement.from.dx, lineElement.from.dy)
      ..lineTo(lineElement.to.dx, lineElement.to.dy);

    PathAnimation.animatePath(canvas, paint, coordinateSystem, path, progress);

    if (lineElement is ArrowElement && progress >= 1.0) {
      final angle = (lineElement.to - lineElement.from).direction;
      ArrowHeadPainter.draw(canvas, paint, coordinateSystem, lineElement.to, angle);
    }
  }
}*/
