import '../models/basic_elements/erase_element.dart';
import '../models/basic_elements/speech_element.dart';
import '../models/course.dart';

/// Un instant où le tableau doit être capturé, avec le ou les éléments dont
/// l'achèvement (`startTime + duration`) déclenche cette capture — plusieurs
/// éléments peuvent finir exactement au même instant, auquel cas ils
/// partagent une seule image plutôt que d'en produire des doublons.
class CapturePoint {
  final double time;
  final List<int> triggerElementIds;
  CapturePoint({required this.time, required this.triggerElementIds});
}

/// Un lot de [CapturePoint] à envoyer ensemble à Claude pour vérification.
class CaptureBatch {
  final List<CapturePoint> points;
  CaptureBatch(this.points);
}

/// Plafond du nombre d'images par appel de vérification — voir
/// `world-model-visual-feedback.md`, section "Décisions".
const int maxCapturePointsPerBatch = 15;

/// Calcule le plan de capture d'un [Course] déjà parsé : un point de capture
/// par instant distinct de fin d'apparition d'élément (`startTime +
/// duration`), regroupé en lots aux frontières d'`erase` et plafonné à
/// [maxCapturePointsPerBatch] points par lot.
List<CaptureBatch> planCaptures(Course course) {
  final Map<double, List<int>> pointsByTime = {};
  for (final element in course.globalRegistry.values) {
    // `erase` ne déclenche jamais de capture (ce n'est pas un élément visuel
    // apparaissant sur le tableau) ; `speech` est un sous-titre optionnel,
    // jamais rendu par BoardPainter/CoursePlayer.
    if (element is EraseElement || element is SpeechElement) continue;
    final captureTime = element.startTime + element.duration;
    pointsByTime.putIfAbsent(captureTime, () => []).add(element.id);
  }

  final points = pointsByTime.entries
      .map((e) => CapturePoint(time: e.key, triggerElementIds: e.value..sort()))
      .toList()
    ..sort((a, b) => a.time.compareTo(b.time));

  if (points.isEmpty) return [];

  final sceneBoundaries = course.globalRegistry.values
      .whereType<EraseElement>()
      .map((e) => e.startTime)
      .toSet()
      .toList()
    ..sort();

  final batches = <CaptureBatch>[];
  var current = <CapturePoint>[];

  void flushCurrent() {
    for (var i = 0; i < current.length; i += maxCapturePointsPerBatch) {
      final end = (i + maxCapturePointsPerBatch < current.length)
          ? i + maxCapturePointsPerBatch
          : current.length;
      batches.add(CaptureBatch(current.sublist(i, end)));
    }
    current = [];
  }

  var boundaryIndex = 0;
  for (final point in points) {
    while (boundaryIndex < sceneBoundaries.length &&
        point.time >= sceneBoundaries[boundaryIndex]) {
      flushCurrent();
      boundaryIndex++;
    }
    current.add(point);
  }
  flushCurrent();

  return batches;
}
