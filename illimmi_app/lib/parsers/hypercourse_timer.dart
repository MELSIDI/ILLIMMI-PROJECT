import '../models/hyper_element.dart';

class HypercourseTimer {
  /// Calcule la durée totale d'un cours à partir de ses éléments
  static double calculateTotalDuration(List<HyperElement> elements, {double margin = 2.0}) {
    if (elements.isEmpty) return 0.0;
    
    double maxTime = 0.0;
    
    for (var element in elements) {
      final endTime = element.startTime + element.duration;
      if (endTime > maxTime) {
        maxTime = endTime;
      }
    }
    
    // Ajouter une marge de sécurité
    return maxTime + margin;
  }
  
  /// Affiche les statistiques d'un cours
  static void printCourseStats(List<HyperElement> elements) {
    print('📊 === STATISTIQUES DU COURS ===');
    print('📊 Nombre total d\'éléments: ${elements.length}');
    
    final duration = calculateTotalDuration(elements, margin: 0);
    print('📊 Durée calculée: ${duration.toStringAsFixed(2)}s');
    
    // Compter par type
    final typeCount = <String, int>{};
    for (var element in elements) {
      final type = element.runtimeType.toString();
      typeCount[type] = (typeCount[type] ?? 0) + 1;
    }
    
    print('📊 Répartition par type:');
    typeCount.forEach((type, count) {
      print('   - $type: $count');
    });
    
    // Trouver les éléments les plus tardifs
    final sortedElements = List<HyperElement>.from(elements)
      ..sort((a, b) => (a.startTime + a.duration).compareTo(b.startTime + b.duration));
    
    print('📊 5 derniers éléments:');
    for (var i = elements.length - 5; i < elements.length && i >= 0; i++) {
      final el = sortedElements[i];
      final endTime = el.startTime + el.duration;
      print('   - ID ${el.id}: ${el.runtimeType} @ ${el.startTime}s (fin: ${endTime}s)');
    }
    
    print('📊 ================================');
  }
}