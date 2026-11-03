import '../hc_types.dart';
import '../models/basic_elements/mouse_event_element.dart';
import '../models/basic_elements/text_element.dart';
import '../models/course.dart';
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
import 'board_capture_planner.dart';

/// Sérialise un [CapturePoint] vers le contrat JSON neutre attendu par
/// `board-render-service` : l'état actif du tableau à cet instant
/// (`Course.queryAll`), un par type concret de [HyperElement] — même esprit
/// que `ElementPainterFactory` côté Flutter, mais pour la sérialisation.
///
/// `PlotElement` (rendu via webview côté lecteur) n'est volontairement pas
/// sérialisé : reproduire un rendu webview headless est hors scope de cette
/// vérification visuelle (voir world-model-visual-feedback.md, "Décisions").
Map<String, dynamic> serializeCapturePoint(Course course, CapturePoint point) {
  final active = course.queryAll(point.time);
  final elements = [...active.staticElement, ...active.dynamicElement];
  return {
    'time': point.time,
    'triggerElementIds': point.triggerElementIds,
    'elements': elements
        .map(_serializeElement)
        .whereType<Map<String, dynamic>>()
        .toList(),
  };
}

Map<String, dynamic> serializeCaptureBatch(Course course, CaptureBatch batch) {
  return {
    'points': batch.points.map((p) => serializeCapturePoint(course, p)).toList(),
  };
}

Map<String, dynamic>? _serializeElement(HyperElement element) {
  // Ordre important : ArrowElement étend LineElement.
  if (element is TextElement) return _textJson(element);
  if (element is CircleElement) return _circleJson(element);
  if (element is ArrowElement) return _lineJson(element, isArrow: true);
  if (element is LineElement) return _lineJson(element, isArrow: false);
  if (element is PathElement) return _pathJson(element);
  if (element is MouseEvent) return _mouseJson(element);
  if (element is ArcElement) return _arcJson(element);
  if (element is EllipticArcElement) return _ellipticArcJson(element);
  if (element is EllipseElement) return _ellipseJson(element);
  if (element is Function2DElement) return _function2dJson(element);
  if (element is PolygonElement) return _polygonJson(element);
  if (element is Repere2DElement) return _repere2dJson(element);
  return null;
}

Map<String, dynamic> _base(HyperElement e, String type) => {
  'type': type,
  'id': e.id,
  'startTime': e.startTime,
  'duration': e.duration,
  'endTime': e.endTime.isFinite ? e.endTime : null,
};

Map<String, dynamic> _offset(Offset o) => {'dx': o.dx, 'dy': o.dy};

Map<String, dynamic>? _color(Color? c) =>
    c == null ? null : {'red': c.red, 'green': c.green, 'blue': c.blue, 'opacity': c.opacity};

Map<String, dynamic> _textJson(TextElement e) => {
  ..._base(e, 'text'),
  'content': e.content,
  'position': _offset(e.position),
};

Map<String, dynamic> _circleJson(CircleElement e) => {
  ..._base(e, 'circle'),
  'color': _color(e.color),
  'width': e.width,
  'center': _offset(e.center),
  'radius': e.radius,
  'fillColor': _color(e.fillColor),
  'arrowAngle': e.arrowAngle,
  'arrowCounterClockwise': e.arrowCounterClockwise,
};

Map<String, dynamic> _lineJson(LineElement e, {required bool isArrow}) => {
  ..._base(e, 'line'),
  'isArrow': isArrow,
  'color': _color(e.color),
  'width': e.width,
  'from': e.from == null ? null : _offset(e.from!),
  'to': e.to == null ? null : _offset(e.to!),
  'fromTextId': e.fromTextId,
  'toTextId': e.toTextId,
  'toTextPattern': e.toTextPattern,
};

Map<String, dynamic> _pathJson(PathElement e) => {
  ..._base(e, 'path'),
  'color': _color(e.color),
  'width': e.width,
  'points': e.points.map(_offset).toList(),
};

Map<String, dynamic> _mouseJson(MouseEvent e) => {
  ..._base(e, 'mouse'),
  'points': e.points.map(_offset).toList(),
};

Map<String, dynamic> _arcJson(ArcElement e) => {
  ..._base(e, 'arc'),
  'color': _color(e.color),
  'width': e.width,
  'center': _offset(e.center),
  'radius': e.radius,
  'startAngle': e.startAngle,
  'sweepAngle': e.sweepAngle,
  'hasArrowAtEnd': e.hasArrowAtEnd,
  'arrowCounterClockwise': e.arrowCounterClockwise,
  'fillColor': _color(e.fillColor),
};

Map<String, dynamic> _ellipseJson(EllipseElement e) => {
  ..._base(e, 'ellipse'),
  'color': _color(e.color),
  'width': e.width,
  'center': _offset(e.center),
  'radiusX': e.radiusX,
  'radiusY': e.radiusY,
  'rotation': e.rotation,
  'fillColor': _color(e.fillColor),
  'arrowAngle': e.arrowAngle,
  'arrowCounterClockwise': e.arrowCounterClockwise,
};

Map<String, dynamic> _ellipticArcJson(EllipticArcElement e) => {
  ..._base(e, 'elliptic_arc'),
  'color': _color(e.color),
  'width': e.width,
  'center': _offset(e.center),
  'radiusX': e.radiusX,
  'radiusY': e.radiusY,
  'rotation': e.rotation,
  'startAngle': e.startAngle,
  'sweepAngle': e.sweepAngle,
  'hasArrowAtEnd': e.hasArrowAtEnd,
  'arrowCounterClockwise': e.arrowCounterClockwise,
  'fillColor': _color(e.fillColor),
};

Map<String, dynamic> _function2dJson(Function2DElement e) => {
  ..._base(e, 'function2d'),
  'color': _color(e.color),
  'width': e.width,
  'repereId': e.repereId,
  'expression': e.expression,
};

Map<String, dynamic> _polygonJson(PolygonElement e) => {
  ..._base(e, 'polygon'),
  'color': _color(e.color),
  'width': e.width,
  'points': e.points.map(_offset).toList(),
  'fillColor': _color(e.fillColor),
};

Map<String, dynamic> _repere2dJson(Repere2DElement e) => {
  ..._base(e, 'repere2d'),
  'color': _color(e.color),
  'width': e.width,
  'origin': _offset(e.origin),
  'xStart': e.xStart,
  'xEnd': e.xEnd,
  'yStart': e.yStart,
  'yEnd': e.yEnd,
  'scale': e.scale,
  'grid': e.grid,
  'gridAlpha': e.gridAlpha,
  'step': e.step,
  'showLabels': e.showLabels,
};
