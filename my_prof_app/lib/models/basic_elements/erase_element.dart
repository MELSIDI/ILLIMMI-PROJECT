import '../hyper_element.dart';

class EraseElement extends HyperElement {
  final List<int> idsToErase;
  EraseElement({
    required super.id, 
    required super.startTime, 
    super.duration,
    super.endTime,
    required this.idsToErase
  });
}