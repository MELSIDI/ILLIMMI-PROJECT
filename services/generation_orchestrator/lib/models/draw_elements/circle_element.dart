import '../../hc_types.dart';
import '../basic_elements/draw_element.dart';

class CircleElement extends DrawElement {
  final Offset center;
  final double radius;
  final Color? fillColor;
  final double? arrowAngle;
  final bool? arrowCounterClockwise; // true = sens trigo (+), false = sens horaire (-)

  CircleElement({
    required super.id, 
    required super.startTime, 
    super.duration,
    super.endTime, 
    super.color, 
    required super.width, 
    required this.center, 
    required this.radius, 
    this.fillColor, 
    this.arrowAngle, 
    this.arrowCounterClockwise
  });
}