import 'package:flutter/material.dart';
import 'parsers/hypercourse_parser.dart';
import 'parsers/hypercourse_timer.dart';
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
      course "Théorème de Thalès" {
    # ═══════════════════════════════════════
    # SECTION 1 : INTRODUCTION
    # ═══════════════════════════════════════

    draw 2drep id 100
  start 0s for 2s
  at (88.89, 50)
  color (100, 100, 100, 0.7)
  scale = 8
  x_range = [-6, 6]
  y_range = [-4, 4];

# Fonction dans le repère
draw 2dfunc id 101
  start 2s for 3s
  color (255, 50, 50, 1.0)
  width 3
  at 100
  y = sin(x);
    
    # Titre principal
    text id 1 start 1s for 2s at (88.89, 10)
         ''[bold][color=#2C3E50]Le Théorème de Thalès[/color][/bold]'' ;
    
    # Sous-titre
    text id 2 start 3s for 2s at (88.89, 18)
         ''[italic]Proportionnalité dans les triangles[/italic]'' ;
    
    # ═══════════════════════════════════════
    # SECTION 2 : CONSTRUCTION DU TRIANGLE ABC
    # ═══════════════════════════════════════
    
    # Triangle ABC (grand triangle)
    draw polygone id 10 start 5s for 2s 
                  color (52, 152, 219, 1) 
                  width 3 
                  fillcolor (52, 152, 219, 0.15) 
                  at [(30, 80), (88.89, 30), (147.78, 80)] ;
    
    # Points A, B, C
    draw circle id 11 start 7s 
                color (52, 152, 219, 1) 
                width 2 
                fillcolor (52, 152, 219, 1) 
                radius 2 
                at (30, 80) ;
    
    text id 12 start 7.5s at (23, 82)
         ''[bold]$A$[/bold]'' ;
    
    draw circle id 13 start 7s 
                color (52, 152, 219, 1) 
                width 2 
                fillcolor (52, 152, 219, 1) 
                radius 2 
                at (88.89, 30) ;
    
    text id 14 start 7.5s at (88.89, 24)
         ''[bold]$B$[/bold]'' ;
    
    draw circle id 15 start 7s 
                color (52, 152, 219, 1) 
                width 2 
                fillcolor (52, 152, 219, 1) 
                radius 2 
                at (147.78, 80) ;
    
    text id 16 start 7.5s at (152, 82)
         ''[bold]$C$[/bold]'' ;
    
    # ═══════════════════════════════════════
    # SECTION 3 : POINTS M ET N (PARALLÈLE)
    # ═══════════════════════════════════════
    
    # Point M sur AB
    draw circle id 20 start 9s 
                color (231, 76, 60, 1) 
                width 2 
                fillcolor (231, 76, 60, 1) 
                radius 2 
                at (50, 63) ;
    
    text id 21 start 9.5s at (43, 65)
         ''[bold][color=#E74C3C]$M$[/color][/bold]'' ;
    
    # Point N sur BC
    draw circle id 22 start 9s 
                color (231, 76, 60, 1) 
                width 2 
                fillcolor (231, 76, 60, 1) 
                radius 2 
                at (127.78, 63) ;
    
    text id 23 start 9.5s at (133, 65)
         ''[bold][color=#E74C3C]$N$[/color][/bold]'' ;
    
    # Ligne MN (parallèle à AC)
    draw arrow id 24 start 11s for 2s 
              color (46, 204, 113, 1) 
              width 3 
              at [(50, 63), (127.78, 63)] ;
    
    text id 25 start 13s at (88.89, 68)
         ''[color=#2ECC71]$(MN)$ parallèle à $(AC)$[/color]'' ;
    
    # ═══════════════════════════════════════
    # SECTION 4 : ANNOTATIONS DES LONGUEURS
    # ═══════════════════════════════════════
    
    # Segment AM
    draw line id 30 start 15s 
              color (155, 89, 182, 0.6) 
              width 2 
              at [(30, 80), (50, 63)] ;
    
    text id 31 start 15.5s at (35, 70)
         ''[color=#9B59B6]$a$[/color]'' ;
    
    # Segment MB
    draw line id 32 start 16s 
              color (155, 89, 182, 0.6) 
              width 2 
              at [(50, 63), (88.89, 30)] ;
    
    text id 33 start 16.5s at (65, 43)
         ''[color=#9B59B6]$b$[/color]'' ;
    
    # Segment CN
    draw line id 34 start 17s 
              color (243, 156, 18, 0.6) 
              width 2 
              at [(147.78, 80), (127.78, 63)] ;
    
    text id 35 start 17.5s at (141, 70)
         ''[color=#F39C12]$c$[/color]'' ;
    
    # Segment NB
    draw line id 36 start 18s 
              color (243, 156, 18, 0.6) 
              width 2 
              at [(127.78, 63), (88.89, 30)] ;
    
    text id 37 start 18.5s at (112, 43)
         ''[color=#F39C12]$d$[/color]'' ;
    
    # ═══════════════════════════════════════
    # SECTION 5 : ÉNONCÉ DU THÉORÈME
    # ═══════════════════════════════════════
    
    # Cadre pour l'énoncé
    draw polygone id 40 start 20s for 1s 
                  color (52, 73, 94, 1) 
                  width 2 
                  fillcolor (236, 240, 241, 0.9) 
                  at [(10, 88), (167.78, 88), (167.78, 98), (10, 98)] ;
    
    # Énoncé du théorème
    text id 41 start 21s for 3s at (88.89, 93)
         ''Si $(MN) \parallel (AC)$, alors : $\frac{AM}{AB} = \frac{AN}{AC} = \frac{MN}{AC}$'' ;
    
    # ═══════════════════════════════════════
    # SECTION 6 : FORMULE DÉTAILLÉE
    # ═══════════════════════════════════════
    
    # Flèche pointant vers la formule
    draw arrow id 50 start 24s 
               color (231, 76, 60, 1) 
               width 2 
               at [(88.89, 86), (88.89, 78)] ;
    
    # Formule avec les longueurs
    text id 51 start 25s for 3s at (88.89, 75)
         ''$$\frac{a}{a+b} = \frac{c}{c+d}$$'' ;
    
    # ═══════════════════════════════════════
    # SECTION 7 : EXEMPLE NUMÉRIQUE
    # ═══════════════════════════════════════
    
    # Effacer les éléments précédents
    erase id 900 start 29s for 1s at [30, 31, 32, 33, 34, 35, 36, 37, 40, 41, 50, 51] ;
    
    # Titre exemple
    text id 60 start 30s at (88.89, 15)
         ''[bold]Exemple numérique[/bold]'' ;
    
    # Valeurs numériques sur AM
    text id 61 start 31s at (35, 70)
         ''[color=#9B59B6][bold]$3$ cm[/bold][/color]'' ;
    
    # Valeurs sur MB
    text id 62 start 31.5s at (65, 43)
         ''[color=#9B59B6][bold]$6$ cm[/bold][/color]'' ;
    
    # Valeurs sur CN
    text id 63 start 32s at (141, 70)
         ''[color=#F39C12][bold]$4$ cm[/bold][/color]'' ;
    
    # Question : trouver d
    text id 64 start 33s at (112, 43)
         ''[color=#F39C12][bold]$d = ?$[/bold][/color]'' ;
    
    # ═══════════════════════════════════════
    # SECTION 8 : RÉSOLUTION
    # ═══════════════════════════════════════
    
    # Cadre de résolution
    draw polygone id 70 start 35s for 1s 
                  color (52, 73, 94, 1) 
                  width 2 
                  fillcolor (236, 240, 241, 0.9) 
                  at [(130, 20), (167.78, 20), (167.78, 50), (130, 50)] ;
    
    # Étape 1 : proportion
    text id 71 start 36s at (149, 25)
         ''$\frac{3}{3+6} = \frac{4}{4+d}$'' ;
    
    # Étape 2 : simplification
    text id 72 start 38s at (149, 32)
         ''$\frac{3}{9} = \frac{4}{4+d}$'' ;
    
    # Étape 3 : simplification de 3/9
    text id 73 start 40s at (149, 39)
         ''$\frac{1}{3} = \frac{4}{4+d}$'' ;
    
    # Étape 4 : produit en croix
    text id 74 start 42s at (149, 46)
         ''$4+d = 12$'' ;
    
    # ═══════════════════════════════════════
    # SECTION 9 : SOLUTION FINALE
    # ═══════════════════════════════════════
    
    # Cadre solution
    draw polygone id 80 start 44s for 1.5s 
                  color (46, 204, 113, 1) 
                  width 3 
                  fillcolor (46, 204, 113, 0.2) 
                  at [(10, 88), (167.78, 88), (167.78, 98), (10, 98)] ;
    
    # Solution
    text id 81 start 45s for 3s at (88.89, 93)
         ''[bold][color=#2ECC71]Solution : $d = 8$ cm[/color][/bold]'' ;
    
    # Afficher la valeur sur le triangle
    erase id 901 start 47s at [64] ;
    
    text id 82 start 47.5s at (112, 43)
         ''[color=#F39C12][bold]$8$ cm[/bold][/color]'' ;
    
    # Animation de curseur montrant la solution
    mouse move id 600 start 47s for 2s 
               at [(149, 46), (112, 43)] ;
    
    # ═══════════════════════════════════════
    # SECTION 10 : VÉRIFICATION
    # ═══════════════════════════════════════
    
    # Titre vérification
    text id 90 start 50s at (88.89, 5)
         ''[bold]Vérification[/bold]'' ;
    
    # Calcul côté gauche
    text id 91 start 51s at (40, 93)
         ''$\frac{3}{9} = \frac{1}{3}$'' ;
    
    # Calcul côté droit
    text id 92 start 52s at (137, 93)
         ''$\frac{4}{12} = \frac{1}{3}$'' ;
    
    # Signe égal avec validation
    draw circle id 93 start 53s for 1s 
                color (46, 204, 113, 1) 
                width 3 
                radius 8 
                at (88.89, 93) ;
    
    text id 94 start 53.5s at (88.89, 93)
         ''[bold][color=#2ECC71]✓[/color][/bold]'' ;
    
    # ═══════════════════════════════════════
    # SECTION 11 : CONCLUSION
    # ═══════════════════════════════════════
    
    # Effacer la vérification
    erase id 902 start 56s for 1s at [80, 81, 90, 91, 92, 93, 94] ;
    
    # Message final
    draw polygone id 100 start 57s for 1.5s 
                  color (155, 89, 182, 1) 
                  width 3 
                  fillcolor (155, 89, 182, 0.15) 
                  at [(15, 85), (162.78, 85), (162.78, 98), (15, 98)] ;
    
    text id 101 start 58s for 3s at (88.89, 88)
         ''[bold]Le théorème de Thalès[/bold]'' ;
    
    text id 102 start 58s for 3s at (88.89, 94)
         ''[italic]permet de calculer des longueurs inaccessibles[/italic]'' ;
    
    # Étoiles décoratives
    draw circle id 110 start 60s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.8) 
                radius 1.5 
                at (20, 91) ;
    
    draw circle id 111 start 60.2s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.8) 
                radius 1.5 
                at (157.78, 91) ;
    
    draw circle id 112 start 60.4s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.8) 
                radius 1.5 
                at (25, 86) ;
    
    draw circle id 113 start 60.6s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.8) 
                radius 1.5 
                at (152.78, 86) ;
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

