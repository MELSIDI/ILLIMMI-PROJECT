import 'package:flutter/material.dart';
import 'parser/hypercourse_parser.dart';
import 'parser/hypercourse_timer.dart';
import 'player/course_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //debugShowMaterialGrid: true,
      title: 'Hypercourse Debug',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const HypercourseDebugPage(),
    );
  }
}

class HypercourseDebugPage extends StatelessWidget {
  const HypercourseDebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Script de test simple
    const script = r'''
      hypergeneration "Démonstration fonctions 2D" {
  
  # ============================================
  # 1. CRÉER UN REPÈRE 2D (ID pair = X d'abord)
  # ============================================
  draw 2drep id 100
    start 0s
    for 2s
    at (88.89, 50)
    color (100, 100, 100, 0.6)
    width 1.5
    scale = 8
    x_range = [-6, 6]
    y_range = [-4, 4];
  
  # ============================================
  # 2. TRACER sin(x) dans ce repère
  # ============================================
  draw 2dfunc id 101
    start 2s
    for 3s
    color (255, 50, 50, 1.0)
    width 3
    at 100
    y = sin(x);
  
  # ============================================
  # 3. TRACER cos(x) dans le même repère
  # ============================================
  draw 2dfunc id 102
    start 3s
    for 3s
    color (50, 150, 255, 1.0)
    width 3
    at 100
    y = cos(x);
  
  # ============================================
  # 4. TRACER x^2 dans le même repère
  # ============================================
  draw 2dfunc id 103
    start 5s
    for 3s
    color (50, 200, 50, 1.0)
    width 2.5
    at 100
    y = x * x;
  
  # ============================================
  # 5. CRÉER UN SECOND REPÈRE (ID impair = Y d'abord)
  # ============================================
  draw 2drep id 201
    start 8s
    for 2s
    at (140, 80)
    color (150, 50, 200, 0.6)
    width 1.2
    scale = 5
    x_range = [-3, 3]
    y_range = [-2, 2];
  
  # ============================================
  # 6. TRACER exp(x) dans le second repère
  # ============================================
  draw 2dfunc id 202
    start 10s
    for 3s
    color (255, 150, 0, 1.0)
    width 2.5
    at 201
    y = exp(x);
  
  # ============================================
  # 7. TRACER ln(x+3) dans le second repère
  # ============================================
  draw 2dfunc id 203
    start 11s
    for 3s
    color (200, 0, 200, 1.0)
    width 2.5
    at 201
    y = ln(x + 3);
  
  # ============================================
  # 8. Effacer tout le premier repère
  # ============================================
  erase id 999
    start 15s
    for 1s
    at [100, 101, 102, 103];
}
    ''';

    try {
      print('🚀 Début du parsing...');
      final parser = HypercourseParser(script);
      final elements = parser.parse();
      
      print('✅ Parsing réussi !');
      
      // Afficher les statistiques
      HypercourseTimer.printCourseStats(elements);
      
      // Calculer la durée totale
      final totalDuration = HypercourseTimer.calculateTotalDuration(elements);
      
      print('🎬 Lancement du player avec durée: ${totalDuration}s');
      
      return CoursePlayer(
        elements: elements,
        totalDuration: totalDuration,
      );
    } catch (e, stackTrace) {
      print('❌ Erreur: $e');
      print('Stack trace: $stackTrace');
      
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 20),
                const Text(
                  'Erreur de parsing',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  e.toString(),
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

