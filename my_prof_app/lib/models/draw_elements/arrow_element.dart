import 'line_element.dart';

class ArrowElement extends LineElement {
  ArrowElement({
    required super.id, 
    required super.startTime, 
    super.duration, 
    super.color, 
    required super.width, 
    super.from, 
    super.to,
    super.fromTextId,
    super.toTextId,
    super.toTextPattern,
  });
}


/*import 'line_element.dart';

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
}*/