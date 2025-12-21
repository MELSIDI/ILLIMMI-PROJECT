import 'line_element.dart';

class ArrowElement extends LineElement {
  ArrowElement({
    required super.id, 
    required super.startTime, 
    super.duration, 
    super.color, 
    required super.width, 
    required super.from, 
    required super.to
  });
}