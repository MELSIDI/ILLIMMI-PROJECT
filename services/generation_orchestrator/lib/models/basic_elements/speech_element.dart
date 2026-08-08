import '../hyper_element.dart';

/// Sous-titre synchronisé : ne joue aucun son, affiché seulement si l'utilisateur active les
/// sous-titres. La narration audio provient toujours de `audio "<fichier>"` (header du cours).
class SpeechElement extends HyperElement {
  final String text;
  SpeechElement({
    required super.id,
    required super.startTime,
    super.duration,
    super.endTime,
    required this.text,
  });
}
