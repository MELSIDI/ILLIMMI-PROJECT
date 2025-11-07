import '../hyper_element.dart';

class SpeechElement extends HyperElement {
  final String text;
  SpeechElement({
    required super.id, 
    required super.startTime, 
    super.duration, 
    required this.text
  });
}