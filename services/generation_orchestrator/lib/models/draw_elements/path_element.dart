import '../../hc_types.dart';
import '../basic_elements/draw_element.dart';

class PathElement extends DrawElement {
  final List<Offset> points;
  PathElement({
    required super.id, 
    required super.startTime, 
    super.duration, 
    super.endTime,
    super.color, 
    required super.width, 
    required this.points
  });
}