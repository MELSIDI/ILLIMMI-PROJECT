// --- ÉLÉMENTS DE BASE ---
abstract class HyperElement {
  final int id;
  double startTime;
  double duration;

  // Ce endTime sera trés utils
  double
  endTime; // diffrent de startTime + duration car depant de la commande erase par defaut = infini

  HyperElement({
    required this.id,
    required this.startTime,
    this.duration = 0.0,
    this.endTime = double.infinity,
  });
}
