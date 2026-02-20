// draw_parsers/draw_parser_factory.dart
import 'draw_parser_interface.dart';
import 'line_draw_parser.dart';
import 'path_draw_parser.dart';
import 'curve_draw_parser.dart';
import 'polygon_draw_parser.dart';
import 'circle_draw_parser.dart';
import 'ellipse_draw_parser.dart';
import 'arc_draw_parser.dart';
import 'elliptic_arc_draw_parser.dart';
import 'repere2d_draw_parser.dart';
import 'function2d_draw_parser.dart';

class DrawParserFactory {
  static final List<DrawParser> _parsers = [
    LineDrawParser(),
    PathDrawParser(),
    CurveDrawParser(),
    PolygonDrawParser(),
    CircleDrawParser(),
    EllipseDrawParser(),
    ArcDrawParser(),
    EllipticArcDrawParser(),
    Repere2DDrawParser(),
    Function2DDrawParser(),
  ];

  static DrawParser? getParser(String drawType) {
    for (final parser in _parsers) {
      if (parser.canParse(drawType)) {
        return parser;
      }
    }
    return null;
  }

  static void registerParser(DrawParser parser) {
    _parsers.add(parser);
  }
}