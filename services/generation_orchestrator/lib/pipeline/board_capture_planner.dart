import '../models/basic_elements/erase_element.dart';
import '../models/basic_elements/speech_element.dart';
import '../models/course.dart';

/// Un instant où le tableau doit être capturé (juste avant un `erase` ou à la
/// fin du cours), représentant l'état final complet d'une scène.
class CapturePoint {
  final double time;

  /// Tous les éléments visuels actifs sur le tableau lors de cette capture.
  final List<int> triggerElementIds;

  /// Éléments introduits dans cette scène et devant être vérifiés/corrigés.
  final List<int> mutableElementIds;

  /// Éléments ayant survécu d'une scène précédente et déjà validés.
  /// Leur position géographique ne doit PAS être modifiée.
  final List<int> immutableElementIds;

  CapturePoint({
    required this.time,
    required this.triggerElementIds,
    List<int>? mutableElementIds,
    List<int>? immutableElementIds,
  })  : mutableElementIds = mutableElementIds ?? triggerElementIds,
        immutableElementIds = immutableElementIds ?? const [];
}

/// Un lot de [CapturePoint] à envoyer ensemble à Claude pour vérification.
class CaptureBatch {
  final List<CapturePoint> points;
  CaptureBatch(this.points);
}

/// Plafond du nombre d'images par appel de vérification — voir
/// `world-model-visual-feedback.md`, section "Décisions".
const int maxCapturePointsPerBatch = 15;

/// Calcule le plan de capture d'un [Course] déjà parsé selon la stratégie pré-erase :
/// une capture d'écran par scène, juste avant chaque commande `erase`
/// (à `t = max(startTime + duration)` des éléments de la scène), plus une capture
/// finale. Le nombre total d'images produites est égal au nombre de commandes
/// `erase` + 1.
List<CaptureBatch> planCaptures(Course course) {
  final eraseElements = course.globalRegistry.values
      .whereType<EraseElement>()
      .toList()
    ..sort((a, b) => a.startTime.compareTo(b.startTime));

  final sceneStartTimes = <double>[0.0];
  for (final erase in eraseElements) {
    if (!sceneStartTimes.contains(erase.startTime)) {
      sceneStartTimes.add(erase.startTime);
    }
  }

  final points = <CapturePoint>[];
  final verifiedElementIds = <int>{};

  for (var i = 0; i < sceneStartTimes.length; i++) {
    final startTime = sceneStartTimes[i];
    final endTime = (i + 1 < sceneStartTimes.length)
        ? sceneStartTimes[i + 1]
        : double.infinity;

    final sceneElements = course.globalRegistry.values.where((element) {
      if (element is EraseElement || element is SpeechElement) return false;
      return element.startTime >= startTime && element.startTime < endTime;
    }).toList();

    if (sceneElements.isEmpty) continue;

    var captureTime = 0.0;
    for (final element in sceneElements) {
      final endTimeOfElement = element.startTime + element.duration;
      if (endTimeOfElement > captureTime) {
        captureTime = endTimeOfElement;
      }
    }

    final activeAtCapture = course.queryAll(captureTime);
    final activeElements = [...activeAtCapture.staticElement, ...activeAtCapture.dynamicElement]
        .where((e) => e is! EraseElement && e is! SpeechElement)
        .toList();

    final triggerIds = activeElements.map((e) => e.id).toSet().toList()..sort();
    if (triggerIds.isEmpty) continue;

    final mutableIds = <int>[];
    final immutableIds = <int>[];

    for (final id in triggerIds) {
      if (verifiedElementIds.contains(id)) {
        immutableIds.add(id);
      } else {
        mutableIds.add(id);
      }
    }

    verifiedElementIds.addAll(triggerIds);

    points.add(
      CapturePoint(
        time: captureTime,
        triggerElementIds: triggerIds,
        mutableElementIds: mutableIds,
        immutableElementIds: immutableIds,
      ),
    );
  }

  if (points.isEmpty) return [];

  final batches = <CaptureBatch>[];
  for (var i = 0; i < points.length; i += maxCapturePointsPerBatch) {
    final end = (i + maxCapturePointsPerBatch < points.length)
        ? i + maxCapturePointsPerBatch
        : points.length;
    batches.add(CaptureBatch(points.sublist(i, end)));
  }

  return batches;
}

