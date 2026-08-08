import '../../hc_types.dart';
import '../basic_elements/draw_element.dart';

// NOUVEAU : Chemin courbe (Bézier)
class CurveElement extends DrawElement {
  final List<Offset> points; // Points de contrôle
  final bool smooth; // true = courbe lisse (Catmull-Rom), false = Bézier cubique
  final bool hasArrowAtEnd;
  final bool? arrowCounterClockwise; // true = sens trigo (+), false = sens horaire (-)
  
  CurveElement({
    required super.id, 
    required super.startTime, 
    super.duration,
    super.endTime, 
    super.color, 
    required super.width, 
    required this.points,
    this.smooth = true,
    this.hasArrowAtEnd = false,
    this.arrowCounterClockwise,
  });
}
