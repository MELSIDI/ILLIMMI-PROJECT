import '../hyper_element.dart';

class SpeechElement extends HyperElement {
  final String text;
  String? audioPath;
  bool isPlayed;
  SpeechElement({
    required super.id,
    required super.startTime,
    super.duration,
    super.endTime,
    required this.text,
    this.audioPath,
    this.isPlayed = false,
  });
}
