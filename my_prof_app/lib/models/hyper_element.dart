// --- ÉLÉMENTS DE BASE ---
abstract class HyperElement {
  final int id;
  final double startTime;
  final double duration;
  HyperElement({
    required this.id, 
    required this.startTime, 
    this.duration = 0.0
  });
}