import 'package:flutter/material.dart';

import '../models/basic_elements/mouse_event_element.dart';
import '../models/basic_elements/text_element.dart';
import '../models/draw_elements/arc_element.dart';
import '../models/draw_elements/arrow_element.dart';
import '../models/draw_elements/circle_element.dart';
import '../models/draw_elements/ellipse_element.dart';
import '../models/draw_elements/elliptic_arc_element.dart';
import '../models/draw_elements/function2d_element.dart';
import '../models/draw_elements/line_element.dart';
import '../models/draw_elements/path_element.dart';
import '../models/draw_elements/polygon_element.dart';
import '../models/draw_elements/repere2d_element.dart';
import '../models/hyper_element.dart';

/// Désérialise le contrat JSON neutre produit côté `generation-orchestrator`
/// (`lib/pipeline/board_capture_serializer.dart`) vers les vraies classes
/// [HyperElement] d'illimmi_app — le seul but de ce fichier est de
/// reconstruire les objets attendus par `BoardPainter`/`LatexWidget`, jamais
/// de réimplémenter leur logique de rendu.
HyperElement? hyperElementFromJson(Map<String, dynamic> json) {
  final id = json['id'] as int;
  final startTime = _num(json['startTime']);
  final duration = _num(json['duration']);
  final endTime = _endTime(json);

  switch (json['type'] as String) {
    case 'text':
      return TextElement(
        id: id,
        startTime: startTime,
        duration: duration,
        endTime: endTime,
        content: json['content'] as String,
        position: _offset(json['position']),
      );
    case 'circle':
      return CircleElement(
        id: id,
        startTime: startTime,
        duration: duration,
        endTime: endTime,
        color: _color(json['color']),
        width: _num(json['width']),
        center: _offset(json['center']),
        radius: _num(json['radius']),
        fillColor: _color(json['fillColor']),
        arrowAngle: _numOrNull(json['arrowAngle']),
        arrowCounterClockwise: json['arrowCounterClockwise'] as bool?,
      );
    case 'line':
      final from = json['from'] == null ? null : _offset(json['from']);
      final to = json['to'] == null ? null : _offset(json['to']);
      final fromTextId = json['fromTextId'] as int?;
      final toTextId = json['toTextId'] as int?;
      final toTextPattern = json['toTextPattern'] as String?;
      final color = _color(json['color']);
      final width = _num(json['width']);
      return (json['isArrow'] as bool? ?? false)
          ? ArrowElement(
              id: id,
              startTime: startTime,
              duration: duration,
              endTime: endTime,
              color: color,
              width: width,
              from: from,
              to: to,
              fromTextId: fromTextId,
              toTextId: toTextId,
              toTextPattern: toTextPattern,
            )
          : LineElement(
              id: id,
              startTime: startTime,
              duration: duration,
              endTime: endTime,
              color: color,
              width: width,
              from: from,
              to: to,
              fromTextId: fromTextId,
              toTextId: toTextId,
              toTextPattern: toTextPattern,
            );
    case 'path':
      return PathElement(
        id: id,
        startTime: startTime,
        duration: duration,
        endTime: endTime,
        color: _color(json['color']),
        width: _num(json['width']),
        points: _offsetList(json['points']),
      );
    case 'mouse':
      return MouseEvent(
        id: id,
        startTime: startTime,
        duration: duration,
        endTime: endTime,
        points: _offsetList(json['points']),
      );
    case 'arc':
      return ArcElement(
        id: id,
        startTime: startTime,
        duration: duration,
        endTime: endTime,
        color: _color(json['color']),
        width: _num(json['width']),
        center: _offset(json['center']),
        radius: _num(json['radius']),
        startAngle: _num(json['startAngle']),
        sweepAngle: _num(json['sweepAngle']),
        hasArrowAtEnd: json['hasArrowAtEnd'] as bool? ?? false,
        arrowCounterClockwise: json['arrowCounterClockwise'] as bool?,
        fillColor: _color(json['fillColor']),
      );
    case 'ellipse':
      return EllipseElement(
        id: id,
        startTime: startTime,
        duration: duration,
        endTime: endTime,
        color: _color(json['color']),
        width: _num(json['width']),
        center: _offset(json['center']),
        radiusX: _num(json['radiusX']),
        radiusY: _num(json['radiusY']),
        rotation: _numOrNull(json['rotation']) ?? 0.0,
        fillColor: _color(json['fillColor']),
        arrowAngle: _numOrNull(json['arrowAngle']),
        arrowCounterClockwise: json['arrowCounterClockwise'] as bool?,
      );
    case 'elliptic_arc':
      return EllipticArcElement(
        id: id,
        startTime: startTime,
        duration: duration,
        endTime: endTime,
        color: _color(json['color']),
        width: _num(json['width']),
        center: _offset(json['center']),
        radiusX: _num(json['radiusX']),
        radiusY: _num(json['radiusY']),
        rotation: _numOrNull(json['rotation']) ?? 0.0,
        startAngle: _num(json['startAngle']),
        sweepAngle: _num(json['sweepAngle']),
        hasArrowAtEnd: json['hasArrowAtEnd'] as bool? ?? false,
        arrowCounterClockwise: json['arrowCounterClockwise'] as bool?,
        fillColor: _color(json['fillColor']),
      );
    case 'function2d':
      return Function2DElement(
        id: id,
        startTime: startTime,
        duration: duration,
        endTime: endTime,
        color: _color(json['color']),
        width: _num(json['width']),
        repereId: json['repereId'] as int,
        expression: json['expression'] as String,
      );
    case 'polygon':
      return PolygonElement(
        id: id,
        startTime: startTime,
        duration: duration,
        endTime: endTime,
        color: _color(json['color']),
        width: _num(json['width']),
        points: _offsetList(json['points']),
        fillColor: _color(json['fillColor']),
      );
    case 'repere2d':
      return Repere2DElement(
        id: id,
        startTime: startTime,
        duration: duration,
        endTime: endTime,
        color: _color(json['color']),
        width: _num(json['width']),
        origin: _offset(json['origin']),
        xStart: _num(json['xStart']),
        xEnd: _num(json['xEnd']),
        yStart: _num(json['yStart']),
        yEnd: _num(json['yEnd']),
        scale: _numOrNull(json['scale']) ?? 10.0,
      );
    default:
      return null;
  }
}

double _num(dynamic value) => (value as num).toDouble();

double? _numOrNull(dynamic value) => value == null ? null : (value as num).toDouble();

double _endTime(Map<String, dynamic> json) =>
    json['endTime'] == null ? double.infinity : _num(json['endTime']);

Offset _offset(dynamic json) {
  final m = json as Map<String, dynamic>;
  return Offset(_num(m['dx']), _num(m['dy']));
}

List<Offset> _offsetList(dynamic json) => (json as List).map(_offset).toList();

Color? _color(dynamic json) {
  if (json == null) return null;
  final m = json as Map<String, dynamic>;
  return Color.fromRGBO(
    m['red'] as int,
    m['green'] as int,
    m['blue'] as int,
    _num(m['opacity']),
  );
}
