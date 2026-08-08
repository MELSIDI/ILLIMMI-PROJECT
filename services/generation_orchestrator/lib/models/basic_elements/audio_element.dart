import '../hyper_element.dart';

class AudioElement extends HyperElement {
  final String text;
  String path;
  bool isPlayed;
  AudioElement({
    required super.id,
    required super.startTime,
    super.duration,
    super.endTime,
    required this.text,
    required this.path,
    this.isPlayed = false,
  });
}
