// element_painters/element_painter_factory.dart
import 'element_painter_interface.dart';
import 'line_element_painter.dart';
import 'path_element_painter.dart';
import 'curve_element_painter.dart';
import 'polygon_element_painter.dart';
import 'circle_element_painter.dart';
import 'ellipse_element_painter.dart';
import 'arc_element_painter.dart';
import 'elliptic_arc_element_painter.dart';
import 'repere2d_element_painter.dart';
import 'function2d_element_painter.dart';
import '../../models/basic_elements/draw_element.dart';

class ElementPainterFactory {
  static final List<ElementPainter> _painters = [
    LineElementPainter(),
    PathElementPainter(),
    CurveElementPainter(),
    PolygonElementPainter(),
    CircleElementPainter(),
    EllipseElementPainter(),
    ArcElementPainter(),
    EllipticArcElementPainter(),
    Repere2DElementPainter(),
    Function2DElementPainter(),
  ];

  static ElementPainter? getPainter(DrawElement element) {
    for (final painter in _painters) {
      if (painter.canPaint(element)) {
        return painter;
      }
    }
    return null;
  }

  static void registerPainter(ElementPainter painter) {
    _painters.add(painter);
  }
}