import '../../hc_types.dart';
import '../basic_elements/draw_element.dart';

// NOUVEAU : Ellipse
class EllipseElement extends DrawElement {
  final Offset center;
  final double radiusX;
  final double radiusY;
  final double rotation; // Rotation en radians
  final Color? fillColor;
  final double? arrowAngle;
  final bool? arrowCounterClockwise;

  EllipseElement({
    required super.id,
    required super.startTime,
    super.duration,
    super.endTime,
    super.color,
    required super.width,
    required this.center,
    required this.radiusX,
    required this.radiusY,
    this.rotation = 0.0,
    this.fillColor,
    this.arrowAngle,
    this.arrowCounterClockwise,
  });
}