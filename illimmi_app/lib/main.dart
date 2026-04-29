import 'package:flutter/material.dart';
import 'parsers/hypercourse_parser.dart';
import 'models/course.dart'; // Assure-hui d'avoir l'import de ton modèle Course
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
      title: 'Hypercourse Debug',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: const HypercourseDebugPage(),
    );
  }
}

// On passe en StatefulWidget pour garder le Future en mémoire
class HypercourseDebugPage extends StatefulWidget {
  const HypercourseDebugPage({super.key});

  @override
  State<HypercourseDebugPage> createState() => _HypercourseDebugPageState();
}

class _HypercourseDebugPageState extends State<HypercourseDebugPage> {
  late Future<Course> _courseFuture;

  final String script = r'''
  course "Introduction à la Géométrie" id 500 idgap 100 for 45s {
    
    # ═══════════════════════════════════════
    # SEGMENT 1 : BIENVENUE
    # ═══════════════════════════════════════
    
    speech id 201 start 1s ''Bienvenue dans ce cours interactif. Nous allons étudier les formes fondamentales en commençant par le cercle.'' ;

    text id 1 start 1s for 4s at (88.89, 10) 
         ''[bold][color=#2980B9]Géométrie : Le Cercle[/color][/bold]'' ;

    draw circle id 101 start 2s for 2s 
         color (41, 128, 185, 1) 
         width 3 
         radius 15 
         at (88.89, 50) ;

    # ═══════════════════════════════════════
    # SEGMENT 2 : PROPRIÉTÉS
    # ═══════════════════════════════════════

    speech id 202 start 6s ''Le point rouge au centre définit l'origine du cercle, tandis que la ligne verte représente son rayon.'' ;

    # Centre
    draw circle id 102 start 6.5s 
         color (231, 76, 60, 1) 
         fillcolor (231, 76, 60, 1) 
         radius 1.5 
         at (88.89, 50) ;

    # Rayon
    draw line id 103 start 7s for 1.5s 
         color (46, 204, 113, 1) 
         width 2.5 
         at [(88.89, 50), (103.89, 50)] ;

    text id 2 start 7.5s at (96, 47) ''[color=#2ECC71]$r$[/color]'' ;

    # ═══════════════════════════════════════
    # SEGMENT 3 : FORMULE MATHÉMATIQUE
    # ═══════════════════════════════════════

    speech id 203 start 10s ''Rappelez-vous que l'aire d'un disque se calcule avec la formule : pi fois le rayon au carré.'' ;

    text id 3 start 11s for 5s at (88.89, 75) 
         ''$$\mathcal{A} = \pi r^2$$'' ;

    # Curseur qui souligne la formule
    mouse move id 301 start 11.5s for 2s 
          at [(75, 80), (105, 80)] ;

    # ═══════════════════════════════════════
    # SEGMENT 4 : CONCLUSION
    # ═══════════════════════════════════════

    speech id 204 start 18s ''C'est terminé pour cette introduction. Vous pouvez maintenant poser vos questions dans la barre de contrôle en bas.'' ;

    text id 4 start 19s for 4s at (88.89, 90) 
         ''[italic]Fin de la démonstration[/italic]'' ;

    draw polygone id 104 start 18.5s for 2s 
         color (155, 89, 182, 1) 
         width 2 
         at [(20, 20), (157.78, 20), (157.78, 80), (20, 80)] ;
}''';

  @override
  void initState() {
    super.initState();
    // On initialise le parsing une seule fois au lancement
    _courseFuture = _loadCourse();
  }

  Future<Course> _loadCourse() async {
    print('🚀 Début du parsing...');
    final parser = HypercourseParser(script);
    return await parser.parse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Le FutureBuilder est la clé pour gérer l'asynchrone dans l'UI
      body: FutureBuilder<Course>(
        future: _courseFuture,
        builder: (context, snapshot) {
          // 1. Gestion de l'erreur
          if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error.toString());
          }

          // 2. Gestion du chargement
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Parsing du cours et génération audio...'),
                ],
              ),
            );
          }

          // 3. Succès : On affiche le player
          if (snapshot.hasData) {
            final course = snapshot.data!;
            print('✅ Parsing réussi ! Lancement du player.');
            return CoursePlayer(
              course: course,
              totalDuration: course.config.duration,
            );
          }

          return const Center(child: Text('État inconnu'));
        },
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
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
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() => _courseFuture = _loadCourse()),
              child: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }
}

/*
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
      darkTheme: ThemeData(brightness: Brightness.dark),
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
      course "Démonstration Complète des Éléments Hypercourse" id 10 idgap 100 for 130s {
    # ═══════════════════════════════════════
    # SECTION 1 : INTRODUCTION ET TEXTES
    # ═══════════════════════════════════════
    
    # Titre principal avec formatage avancé
    text id 1 start 0.5s for 2s at (88.89, 8)
         ''[bold][color=#2C3E50]Démonstration Complète Hypercourse[/color][/bold]'' ;
    
    # Sous-titre avec formule LaTeX inline
    text id 2 start 2.5s for 2s at (88.89, 15)
         ''[italic]Exploration de toutes les primitives graphiques et $\LaTeX$[/italic]'' ;
    
    # ═══════════════════════════════════════
    # SECTION 2 : LIGNES ET FLÈCHES
    # ═══════════════════════════════════════
    
    text id 3 start 5s for 2s at (30, 25)
         ''[bold][color=#E74C3C]1. Lignes et Flèches[/color][/bold]'' ;
    
    # Ligne simple
    draw line id 101 start 6s for 1.5s 
              color (231, 76, 60, 1) 
              width 2.5 
              at [(15, 35), (45, 35)] ;
    
    text id 4 start 7.5s at (30, 38) ''Ligne simple'' ;
    
    # Flèche
    draw arrow id 102 start 8s for 1.5s 
               color (52, 152, 219, 1) 
               width 2.5 
               at [(15, 42), (45, 42)] ;
    
    text id 5 start 9.5s at (30, 45) ''Flèche'' ;
    
    # ═══════════════════════════════════════
    # SECTION 3 : CHEMINS ET COURBES
    # ═══════════════════════════════════════
    
    text id 6 start 11s for 2s at (30, 52)
         ''[bold][color=#2ECC71]2. Chemins et Courbes[/color][/bold]'' ;
    
    # Chemin brisé (path)
    draw path id 103 start 12s for 2s 
              color (46, 204, 113, 1) 
              width 2 
              at [(10, 60), (20, 65), (30, 58), (40, 63), (50, 60)] ;
    
    text id 7 start 14s at (30, 68) ''Chemin brisé'' ;
    
    # Courbe lissée smooth
    draw curve id 104 start 15s for 2s 
               color (155, 89, 182, 1) 
               width 2.5 
               smooth 
               at [(10, 72), (20, 78), (30, 70), (40, 76), (50, 72)] ;
    
    text id 8 start 17s at (30, 80) ''Courbe lissée'' ;
    
    # Courbe Bézier avec flèche
    draw curve id 105 start 18s for 2s 
               color (243, 156, 18, 1) 
               width 2.5 
               bezier 
               at [(10, 84), (25, 92), (35, 84), (50, 88)] 
               with +arrow at end ;
    
    text id 9 start 20s at (30, 93) ''Courbe Bézier + flèche'' ;
    
    # ═══════════════════════════════════════
    # SECTION 4 : FORMES FERMÉES
    # ═══════════════════════════════════════
    
    text id 10 start 22s for 2s at (88.89, 25)
         ''[bold][color=#3498DB]3. Formes Fermées[/color][/bold]'' ;
    
    # Triangle
    draw polygone id 106 start 23s for 1.5s 
                  color (52, 152, 219, 1) 
                  width 2.5 
                  fillcolor (52, 152, 219, 0.2) 
                  at [(65, 35), (80, 45), (70, 45)] ;
    
    text id 11 start 24.5s at (72, 48) ''Triangle'' ;
    
    # Carré
    draw polygone id 107 start 25s for 1.5s 
                  color (231, 76, 60, 1) 
                  width 2.5 
                  fillcolor (231, 76, 60, 0.2) 
                  at [(85, 35), (95, 35), (95, 45), (85, 45)] ;
    
    text id 12 start 26.5s at (90, 48) ''Carré'' ;
    
    # Pentagone
    draw polygone id 108 start 27s for 1.5s 
                  color (46, 204, 113, 1) 
                  width 2.5 
                  fillcolor (46, 204, 113, 0.2) 
                  at [(105, 38), (110, 35), (113, 40), (110, 45), (105, 42)] ;
    
    text id 13 start 28.5s at (109, 48) ''Pentagone'' ;
    
    # ═══════════════════════════════════════
    # SECTION 5 : CERCLES ET ELLIPSES
    # ═══════════════════════════════════════
    
    text id 14 start 30s for 2s at (88.89, 52)
         ''[bold][color=#9B59B6]4. Cercles et Ellipses[/color][/bold]'' ;
    
    # Cercle simple
    draw circle id 109 start 31s for 1.5s 
                color (155, 89, 182, 1) 
                width 2.5 
                fillcolor (155, 89, 182, 0.15) 
                radius 6 
                at (70, 62) ;
    
    text id 15 start 32.5s at (70, 70) ''Cercle'' ;
    
    # Cercle avec flèche sur 45°
    draw circle id 110 start 33s for 1.5s 
                color (231, 76, 60, 1) 
                width 2.5 
                fillcolor (231, 76, 60, 0.15) 
                radius 6 
                at (88.89, 62) 
                with +arrow on 45deg ;
    
    text id 16 start 34.5s at (88.89, 70) ''Cercle + flèche'' ;
    
    # Ellipse simple
    draw ellipse id 111 start 35s for 1.5s 
                 color (52, 152, 219, 1) 
                 width 2.5 
                 fillcolor (52, 152, 219, 0.15) 
                 radiusX 8 
                 radiusY 5 
                 at (107, 62) ;
    
    text id 17 start 36.5s at (107, 70) ''Ellipse'' ;
    
    # Ellipse avec rotation et flèche
    draw ellipse id 112 start 37s for 1.5s 
                 color (46, 204, 113, 1) 
                 width 2.5 
                 fillcolor (46, 204, 113, 0.15) 
                 radiusX 9 
                 radiusY 4 
                 rotation 30 
                 at (125, 62) 
                 with -arrow on 120deg ;
    
    text id 18 start 38.5s at (125, 70) ''Ellipse rotée'' ;
    
    # ═══════════════════════════════════════
    # SECTION 6 : ARCS
    # ═══════════════════════════════════════
    
    text id 20 start 40s for 2s at (88.89, 75)
         ''[bold][color=#F39C12]5. Arcs de Cercle et Elliptiques[/color][/bold]'' ;
    
    # Arc de cercle simple
    draw arc id 113 start 41s for 1.5s 
              color (243, 156, 18, 1) 
              width 3 
              fillcolor (243, 156, 18, 0.1) 
              radius 7 
              at (70, 85) 
              from 0deg to 180deg ;
    
    text id 21 start 42.5s at (70, 93) ''Arc 180°'' ;
    
    # Arc avec flèche
    draw arc id 114 start 43s for 1.5s 
              color (155, 89, 182, 1) 
              width 3 
              radius 7 
              at (88.89, 85) 
              from 45deg to 225deg 
              with +arrow at end ;
    
    text id 22 start 44.5s at (88.89, 93) ''Arc + flèche'' ;
    
    # Arc elliptique
    draw elliptic_arc id 115 start 45s for 1.5s 
                      color (231, 76, 60, 1) 
                      width 3 
                      fillcolor (231, 76, 60, 0.1) 
                      radiusX 9 
                      radiusY 5 
                      at (107, 85) 
                      from 0deg to 270deg ;
    
    text id 23 start 46.5s at (107, 93) ''Arc elliptique'' ;
    
    # Arc elliptique roté avec flèche
    draw elliptic_arc id 116 start 47s for 1.5s 
                      color (52, 152, 219, 1) 
                      width 3 
                      radiusX 8 
                      radiusY 4 
                      rotation 45 
                      at (125, 85) 
                      from 30deg to 330deg 
                      with -arrow at end ;
    
    text id 24 start 48.5s at (125, 93) ''Arc roté'' ;
    
    # ═══════════════════════════════════════
    # SECTION 7 : REPÈRES ET FONCTIONS 2D
    # ═══════════════════════════════════════
    
    # Effacer les éléments précédents
    erase id 401 start 50s for 1s at [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
                                      14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
                                      101, 102, 103, 104, 105, 106, 107, 108, 109,
                                      110, 111, 112, 113, 114, 115, 116] ;
    
    text id 25 start 51s for 2s at (88.89, 10)
         ''[bold][color=#E74C3C]6. Repères Cartésiens et Fonctions Mathématiques[/color][/bold]'' ;
    
    # Repère cartésien principal
    draw 2drep id 117 start 52s for 1.5s 
               at (88.89, 50) 
               color (100, 100, 100, 0.7) 
               width 1.5 
               scale = 5 
               x_range = [-6, 6] 
               y_range = [-4, 4] ;
    
    text id 26 start 53.5s at (20, 18) ''Repère cartésien'' ;
    
    # Fonction polynomiale : parabole
    draw 2dfunc id 118 start 54s for 2s 
                color (231, 76, 60, 1) 
                width 3 
                at 117 
                y = x^2/4 - 2 ;
    
    text id 27 start 56s at (150, 25)
         ''[color=#E74C3C]$f(x) = \frac{x^2}{4} - 2$[/color]'' ;
    
    # Fonction trigonométrique : sinus
    draw 2dfunc id 119 start 57s for 2s 
                color (52, 152, 219, 1) 
                width 3 
                at 117 
                y = 2*sin(x) ;
    
    text id 28 start 59s at (150, 32)
         ''[color=#3498DB]$g(x) = 2\sin(x)$[/color]'' ;
    
    # Fonction exponentielle décroissante
    draw 2dfunc id 120 start 60s for 2s 
                color (46, 204, 113, 1) 
                width 3 
                at 117 
                y = 3*exp(-x/2)*cos(x) ;
    
    text id 29 start 62s at (150, 39)
         ''[color=#2ECC71]$h(x) = 3e^{-x/2}\cos(x)$[/color]'' ;
    
    # Fonction racine carrée
    draw 2dfunc id 121 start 63s for 2s 
                color (155, 89, 182, 1) 
                width 3 
                at 117 
                y = sqrt(abs(x)) ;
    
    text id 30 start 65s at (150, 46)
         ''[color=#9B59B6]$i(x) = \sqrt{|x|}$[/color]'' ;
    
    # Points remarquables sur les fonctions
    draw circle id 122 start 66s 
                color (243, 156, 18, 1) 
                width 2 
                fillcolor (243, 156, 18, 1) 
                radius 1.5 
                at (88.89, 40) ;
    
    text id 31 start 66.5s at (83, 37) ''$(0, -2)$'' ;
    
    draw circle id 123 start 67s 
                color (243, 156, 18, 1) 
                width 2 
                fillcolor (243, 156, 18, 1) 
                radius 1.5 
                at (113.89, 50) ;
    
    text id 32 start 67.5s at (118, 52) ''$(\frac{\pi}{2}, 2)$'' ;
    
    # ═══════════════════════════════════════
    # SECTION 8 : ANIMATIONS DE CURSEUR
    # ═══════════════════════════════════════
    
    text id 33 start 69s at (20, 75)
         ''[bold][color=#F39C12]Animation du curseur[/color][/bold]'' ;
    
    # Curseur suivant les points remarquables
    mouse move id 301 start 70s for 3s 
               at [(88.89, 40), (113.89, 50), (88.89, 50), (68.89, 60)] ;
    
    # ═══════════════════════════════════════
    # SECTION 9 : FORMULES LaTeX COMPLEXES
    # ═══════════════════════════════════════
    
    erase id 402 start 74s for 1s at [25, 26, 27, 28, 29, 30, 31, 32, 33,
                                      118, 119, 120, 121, 122, 123, 117] ;
    
    text id 34 start 75s for 2s at (88.89, 15)
         ''[bold][color=#2C3E50]7. Formules Mathématiques Avancées[/color][/bold]'' ;
    
    # Formule de Taylor
    text id 35 start 77s for 3s at (88.89, 30)
         ''$$f(x) = \sum_{n=0}^{\infty} \frac{f^{(n)}(a)}{n!}(x-a)^n$$'' ;
    
    text id 36 start 80s at (88.89, 38)
         ''[italic]Série de Taylor[/italic]'' ;
    
    # Intégrale de Gauss
    text id 37 start 82s for 3s at (88.89, 50)
         ''$$\int_{-\infty}^{+\infty} e^{-x^2} dx = \sqrt{\pi}$$'' ;
    
    text id 38 start 85s at (88.89, 58)
         ''[italic]Intégrale de Gauss[/italic]'' ;
    
    # Équation de Schrödinger
    text id 39 start 87s for 3s at (88.89, 70)
         ''$$i\hbar\frac{\partial}{\partial t}\Psi(\mathbf{r},t) = \hat{H}\Psi(\mathbf{r},t)$$'' ;
    
    text id 40 start 90s at (88.89, 78)
         ''[italic]Équation de Schrödinger[/italic]'' ;
    
    # Formule d'Euler
    text id 41 start 92s for 3s at (88.89, 90)
         ''$$e^{i\pi} + 1 = 0$$'' ;
    
    text id 42 start 95s at (88.89, 95)
         ''[italic]Identité d'Euler : la plus belle équation[/italic]'' ;
    
    # ═══════════════════════════════════════
    # SECTION 10 : DÉMONSTRATION GÉOMÉTRIQUE
    # ═══════════════════════════════════════
    
    erase id 403 start 98s for 1s at [34, 35, 36, 37, 38, 39, 40, 41, 42] ;
    
    text id 43 start 99s for 2s at (88.89, 8)
         ''[bold][color=#E74C3C]8. Construction Géométrique Complexe[/color][/bold]'' ;
    
    text id 44 start 101s at (88.89, 13)
         ''[italic]Théorème du cercle inscrit dans un triangle[/italic]'' ;
    
    # Triangle principal
    draw polygone id 124 start 102s for 2s 
                  color (52, 152, 219, 1) 
                  width 3 
                  fillcolor (52, 152, 219, 0.1) 
                  at [(40, 70), (88.89, 25), (137.78, 70)] ;
    
    # Points du triangle
    draw circle id 125 start 104s 
                color (231, 76, 60, 1) 
                width 2 
                fillcolor (231, 76, 60, 1) 
                radius 2 
                at (40, 70) ;
    
    text id 45 start 104.5s at (33, 72) ''[bold]$A$[/bold]'' ;
    
    draw circle id 126 start 104s 
                color (231, 76, 60, 1) 
                width 2 
                fillcolor (231, 76, 60, 1) 
                radius 2 
                at (88.89, 25) ;
    
    text id 46 start 104.5s at (88.89, 20) ''[bold]$B$[/bold]'' ;
    
    draw circle id 127 start 104s 
                color (231, 76, 60, 1) 
                width 2 
                fillcolor (231, 76, 60, 1) 
                radius 2 
                at (137.78, 70) ;
    
    text id 47 start 104.5s at (143, 72) ''[bold]$C$[/bold]'' ;
    
    # Bissectrices
    draw line id 128 start 106s for 1.5s 
              color (46, 204, 113, 0.6) 
              width 2 
              at [(40, 70), (88.89, 52)] ;
    
    draw line id 129 start 106s for 1.5s 
              color (46, 204, 113, 0.6) 
              width 2 
              at [(88.89, 25), (88.89, 52)] ;
    
    draw line id 130 start 106s for 1.5s 
              color (46, 204, 113, 0.6) 
              width 2 
              at [(137.78, 70), (88.89, 52)] ;
    
    text id 48 start 107.5s at (60, 60)
         ''[color=#2ECC71]Bissectrices[/color]'' ;
    
    # Centre du cercle inscrit (incentre)
    draw circle id 131 start 109s 
                color (155, 89, 182, 1) 
                width 2 
                fillcolor (155, 89, 182, 1) 
                radius 2 
                at (88.89, 52) ;
    
    text id 49 start 109.5s at (93, 54) ''[bold][color=#9B59B6]$I$[/color][/bold]'' ;
    
    # Cercle inscrit
    draw circle id 132 start 111s for 2s 
                color (243, 156, 18, 1) 
                width 3 
                fillcolor (243, 156, 18, 0.15) 
                radius 12 
                at (88.89, 52) ;
    
    text id 50 start 113s at (88.89, 78)
         ''[color=#F39C12]Cercle inscrit[/color]'' ;
    
    # Rayons vers les points de tangence
    draw line id 133 start 114s 
              color (243, 156, 18, 0.7) 
              width 1.5 
              at [(88.89, 52), (64.44, 61)] ;
    
    draw line id 134 start 114s 
              color (243, 156, 18, 0.7) 
              width 1.5 
              at [(88.89, 52), (88.89, 40)] ;
    
    draw line id 135 start 114s 
              color (243, 156, 18, 0.7) 
              width 1.5 
              at [(88.89, 52), (113.34, 61)] ;
    
    text id 51 start 115s at (88.89, 48) ''$r$'' ;
    
    # ═══════════════════════════════════════
    # SECTION 11 : CONCLUSION
    # ═══════════════════════════════════════
    
    erase id 404 start 118s for 1.5s at [43, 44, 45, 46, 47, 48, 49, 50, 51, 124,
                                         125, 126, 127, 128, 129, 130, 131, 132,
                                         133, 134, 135] ;
    
    # Message final avec cadre décoratif
    draw polygone id 136 start 120s for 1.5s 
                  color (155, 89, 182, 1) 
                  width 3 
                  fillcolor (155, 89, 182, 0.1) 
                  at [(20, 35), (157.78, 35), (157.78, 65), (20, 65)] ;
    
    text id 52 start 121s for 3s at (45, 38)
         ''[bold][font=Arial][color=#9B59B6]Démonstration Complète Terminée ![/color][/font][/bold]'' ;
    
    text id 53 start 121s for 3s at (45, 45)
         ''[italic]Tous les éléments Hypercourse présentés[/italic]'' ;
    
    text id 54 start 121s for 3s at (45, 52)
         ''$\checkmark$ Lignes • Flèches • Chemins • Courbes • Polygones'' ;
    
    text id 55 start 121s for 3s at (45, 57)
         ''$\checkmark$ Cercles • Ellipses • Arcs • Repères 2D • Fonctions'' ;
    
    # Étoiles décoratives
    draw circle id 137 start 123s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.9) 
                radius 1.5 
                at (25, 50) ;
    
    draw circle id 138 start 123.2s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.9) 
                radius 1.5 
                at (152.78, 50) ;
    
    draw circle id 139 start 123.4s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.9) 
                radius 1.5 
                at (30, 40) ;
    
    draw circle id 140 start 123.6s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.9) 
                radius 1.5 
                at (147.78, 40) ;
    
    draw circle id 141 start 123.8s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.9) 
                radius 1.5 
                at (30, 60) ;
    
    draw circle id 142 start 124s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.9) 
                radius 1.5 
                at (147.78, 60) ;
    
    # Animation finale du curseur célébrant la fin
    mouse move id 305 start 124s for 2s 
               at [(20, 20), (157.78, 20), (157.78, 80), (20, 80), (88.89, 50)] ;
}
    ''';

    try {
      print('🚀 Début du parsing...');
      final parser = HypercourseParser(script);
      final course = await parser.parse();

      print('✅ Parsing réussi !');

      // Afficher les statistiques
      //HypercourseTimer.printCourseStats(elements);

      // Calculer la durée totale
      //final totalDuration = HypercourseTimer.calculateTotalDuration(course.config.duration);
      final totalDuration = course.config.duration;

      print('🎬 Lancement du player avec durée: ${totalDuration}s');

      return CoursePlayer(course: course, totalDuration: totalDuration);
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
}*/
