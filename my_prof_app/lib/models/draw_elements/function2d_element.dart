import '../basic_elements/draw_element.dart';

class Function2DElement extends DrawElement {
  final int repereId;       // ID du repère 2D à utiliser
  final String expression;  // Expression de la fonction (ex: "x^2", "sin(x)")

  Function2DElement({
    required super.id,
    required super.startTime,
    super.duration,
    super.color,
    required super.width,
    required this.repereId,
    required this.expression,
  });
}