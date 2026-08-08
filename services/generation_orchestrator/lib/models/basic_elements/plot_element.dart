import '../../hc_types.dart';
import '../hyper_element.dart';

class PlotElement extends HyperElement {
  final Offset position;
  final String code;
  PlotElement({
    required super.id, 
    required super.startTime, 
    super.duration,
    super.endTime,  
    required this.position, 
    required this.code
  });
}