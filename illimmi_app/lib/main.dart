// main.dart
/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
      title: 'Hypercourse AI',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const CourseRequestPage(),
    );
  }
}

class CourseRequestPage extends StatefulWidget {
  const CourseRequestPage({super.key});

  @override
  State<CourseRequestPage> createState() => _CourseRequestPageState();
}

class _CourseRequestPageState extends State<CourseRequestPage> {
  final TextEditingController _topicController = TextEditingController();
  final TextEditingController _levelController = TextEditingController(text: 'débutant');
  
  bool _isGenerating = false;
  String? _errorMessage;
  
  // URL du serveur backend (modifie selon ton environnement)
  static const String apiUrl = 'http://localhost:8000/generate_course'; // Émulateur Android
  // Pour device réel ou iOS: 'http://192.168.x.x:8000/generate_course'
  // Pour web: 'http://localhost:8000/generate_course'

  Future<void> _generateCourse() async {
    if (_topicController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez entrer un sujet pour le cours';
      });
      return;
    }

    setState(() {
      _isGenerating = true;
      _errorMessage = null;
    });

    try {
      print('📤 Envoi de la requête au serveur...');
      print('📝 Sujet: ${_topicController.text}');
      print('📊 Niveau: ${_levelController.text}');
      
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'topic': _topicController.text.trim(),
          'level': _levelController.text.trim(),
        }),
      ).timeout(
        const Duration(seconds: 120), // Timeout de 2 minutes
        onTimeout: () {
          throw Exception('La génération a pris trop de temps. Veuillez réessayer.');
        },
      );

      if (response.statusCode == 200) {
        print('✅ Réponse reçue du serveur');
        
        final data = jsonDecode(response.body);
        final script = data['script'] as String;
        
        print('📜 Script reçu (${script.length} caractères)');
        print('🚀 Démarrage du parsing...');
        
        // Parser le script
        final parser = HypercourseParser(script);
        final elements = parser.parse();
        
        print('✅ Parsing réussi !');
        HypercourseTimer.printCourseStats(elements);
        
        final totalDuration = HypercourseTimer.calculateTotalDuration(elements);
        
        print('🎬 Lancement du player...');
        
        // Navigation vers le player
        if (!mounted) return;
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CoursePlayer(
              elements: elements,
              totalDuration: totalDuration,
            ),
          ),
        );
        
      } else {
        throw Exception('Erreur serveur: ${response.statusCode}');
      }
      
    } catch (e, stackTrace) {
      print('❌ Erreur: $e');
      print('Stack trace: $stackTrace');
      
      setState(() {
        _errorMessage = 'Erreur lors de la génération: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isGenerating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo/Icône
                Icon(
                  Icons.school,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 24),
                
                // Titre
                Text(
                  'MY PROF.AI',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                
                Text(
                  'Générez des cours interactifs avec l\'IA',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                
                // Champ sujet
                TextField(
                  controller: _topicController,
                  decoration: InputDecoration(
                    labelText: 'Sujet du cours',
                    hintText: 'Ex: Le théorème de Pythagore',
                    prefixIcon: const Icon(Icons.topic),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                  textInputAction: TextInputAction.next,
                  enabled: !_isGenerating,
                ),
                const SizedBox(height: 16),
                
                // Champ niveau
                TextField(
                  controller: _levelController,
                  decoration: InputDecoration(
                    labelText: 'Niveau',
                    hintText: 'Ex: débutant, intermédiaire, avancé',
                    prefixIcon: const Icon(Icons.bar_chart),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                  textInputAction: TextInputAction.done,
                  enabled: !_isGenerating,
                  onSubmitted: (_) => _generateCourse(),
                ),
                const SizedBox(height: 24),
                
                // Bouton génération
                ElevatedButton.icon(
                  onPressed: _isGenerating ? null : _generateCourse,
                  icon: _isGenerating
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Icon(Icons.auto_awesome),
                  label: Text(
                    _isGenerating ? 'Génération en cours...' : 'Générer le cours',
                    style: const TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                
                // Message d'erreur
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red[300]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red[700]),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(color: Colors.red[700]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                
                // Indicateur de progression
                if (_isGenerating) ...[
                  const SizedBox(height: 24),
                  const LinearProgressIndicator(),
                  const SizedBox(height: 8),
                  Text(
                    'Génération du cours par l\'IA...\nCela peut prendre 30-60 secondes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
                
                // Exemples
                const SizedBox(height: 32),
                Text(
                  'Exemples de sujets :',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildExampleChip('Théorème de Pythagore', 'débutant'),
                _buildExampleChip('Dérivées de fonctions', 'intermédiaire'),
                _buildExampleChip('Série de Fourier', 'avancé'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExampleChip(String topic, String level) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: _isGenerating ? null : () {
          _topicController.text = topic;
          _levelController.text = level;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                size: 16,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  topic,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  level,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _topicController.dispose();
    _levelController.dispose();
    super.dispose();
  }
}

*/
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
      course "Démonstration Complète des Éléments Hypercourse" {
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
    
    text id 10 start 5s for 2s at (30, 25)
         ''[bold][color=#E74C3C]1. Lignes et Flèches[/color][/bold]'' ;
    
    # Ligne simple
    draw line id 20 start 6s for 1.5s 
              color (231, 76, 60, 1) 
              width 2.5 
              at [(15, 35), (45, 35)] ;
    
    text id 21 start 7.5s at (30, 38) ''Ligne simple'' ;
    
    # Flèche
    draw arrow id 22 start 8s for 1.5s 
               color (52, 152, 219, 1) 
               width 2.5 
               at [(15, 42), (45, 42)] ;
    
    text id 23 start 9.5s at (30, 45) ''Flèche'' ;
    
    # ═══════════════════════════════════════
    # SECTION 3 : CHEMINS ET COURBES
    # ═══════════════════════════════════════
    
    text id 30 start 11s for 2s at (30, 52)
         ''[bold][color=#2ECC71]2. Chemins et Courbes[/color][/bold]'' ;
    
    # Chemin brisé (path)
    draw path id 40 start 12s for 2s 
              color (46, 204, 113, 1) 
              width 2 
              at [(10, 60), (20, 65), (30, 58), (40, 63), (50, 60)] ;
    
    text id 41 start 14s at (30, 68) ''Chemin brisé'' ;
    
    # Courbe lissée smooth
    draw curve id 42 start 15s for 2s 
               color (155, 89, 182, 1) 
               width 2.5 
               smooth 
               at [(10, 72), (20, 78), (30, 70), (40, 76), (50, 72)] ;
    
    text id 43 start 17s at (30, 80) ''Courbe lissée'' ;
    
    # Courbe Bézier avec flèche
    draw curve id 44 start 18s for 2s 
               color (243, 156, 18, 1) 
               width 2.5 
               bezier 
               at [(10, 84), (25, 92), (35, 84), (50, 88)] 
               with +arrow at end ;
    
    text id 45 start 20s at (30, 93) ''Courbe Bézier + flèche'' ;
    
    # ═══════════════════════════════════════
    # SECTION 4 : FORMES FERMÉES
    # ═══════════════════════════════════════
    
    text id 50 start 22s for 2s at (88.89, 25)
         ''[bold][color=#3498DB]3. Formes Fermées[/color][/bold]'' ;
    
    # Triangle
    draw polygone id 60 start 23s for 1.5s 
                  color (52, 152, 219, 1) 
                  width 2.5 
                  fillcolor (52, 152, 219, 0.2) 
                  at [(65, 35), (80, 45), (70, 45)] ;
    
    text id 61 start 24.5s at (72, 48) ''Triangle'' ;
    
    # Carré
    draw polygone id 62 start 25s for 1.5s 
                  color (231, 76, 60, 1) 
                  width 2.5 
                  fillcolor (231, 76, 60, 0.2) 
                  at [(85, 35), (95, 35), (95, 45), (85, 45)] ;
    
    text id 63 start 26.5s at (90, 48) ''Carré'' ;
    
    # Pentagone
    draw polygone id 64 start 27s for 1.5s 
                  color (46, 204, 113, 1) 
                  width 2.5 
                  fillcolor (46, 204, 113, 0.2) 
                  at [(105, 38), (110, 35), (113, 40), (110, 45), (105, 42)] ;
    
    text id 65 start 28.5s at (109, 48) ''Pentagone'' ;
    
    # ═══════════════════════════════════════
    # SECTION 5 : CERCLES ET ELLIPSES
    # ═══════════════════════════════════════
    
    text id 70 start 30s for 2s at (88.89, 52)
         ''[bold][color=#9B59B6]4. Cercles et Ellipses[/color][/bold]'' ;
    
    # Cercle simple
    draw circle id 80 start 31s for 1.5s 
                color (155, 89, 182, 1) 
                width 2.5 
                fillcolor (155, 89, 182, 0.15) 
                radius 6 
                at (70, 62) ;
    
    text id 81 start 32.5s at (70, 70) ''Cercle'' ;
    
    # Cercle avec flèche sur 45°
    draw circle id 82 start 33s for 1.5s 
                color (231, 76, 60, 1) 
                width 2.5 
                fillcolor (231, 76, 60, 0.15) 
                radius 6 
                at (88.89, 62) 
                with +arrow on 45deg ;
    
    text id 83 start 34.5s at (88.89, 70) ''Cercle + flèche'' ;
    
    # Ellipse simple
    draw ellipse id 84 start 35s for 1.5s 
                 color (52, 152, 219, 1) 
                 width 2.5 
                 fillcolor (52, 152, 219, 0.15) 
                 radiusX 8 
                 radiusY 5 
                 at (107, 62) ;
    
    text id 85 start 36.5s at (107, 70) ''Ellipse'' ;
    
    # Ellipse avec rotation et flèche
    draw ellipse id 86 start 37s for 1.5s 
                 color (46, 204, 113, 1) 
                 width 2.5 
                 fillcolor (46, 204, 113, 0.15) 
                 radiusX 9 
                 radiusY 4 
                 rotation 30 
                 at (125, 62) 
                 with -arrow on 120deg ;
    
    text id 87 start 38.5s at (125, 70) ''Ellipse rotée'' ;
    
    # ═══════════════════════════════════════
    # SECTION 6 : ARCS
    # ═══════════════════════════════════════
    
    text id 90 start 40s for 2s at (88.89, 75)
         ''[bold][color=#F39C12]5. Arcs de Cercle et Elliptiques[/color][/bold]'' ;
    
    # Arc de cercle simple
    draw arc id 100 start 41s for 1.5s 
              color (243, 156, 18, 1) 
              width 3 
              fillcolor (243, 156, 18, 0.1) 
              radius 7 
              at (70, 85) 
              from 0deg to 180deg ;
    
    text id 101 start 42.5s at (70, 93) ''Arc 180°'' ;
    
    # Arc avec flèche
    draw arc id 102 start 43s for 1.5s 
              color (155, 89, 182, 1) 
              width 3 
              radius 7 
              at (88.89, 85) 
              from 45deg to 225deg 
              with +arrow at end ;
    
    text id 103 start 44.5s at (88.89, 93) ''Arc + flèche'' ;
    
    # Arc elliptique
    draw elliptic_arc id 104 start 45s for 1.5s 
                      color (231, 76, 60, 1) 
                      width 3 
                      fillcolor (231, 76, 60, 0.1) 
                      radiusX 9 
                      radiusY 5 
                      at (107, 85) 
                      from 0deg to 270deg ;
    
    text id 105 start 46.5s at (107, 93) ''Arc elliptique'' ;
    
    # Arc elliptique roté avec flèche
    draw elliptic_arc id 106 start 47s for 1.5s 
                      color (52, 152, 219, 1) 
                      width 3 
                      radiusX 8 
                      radiusY 4 
                      rotation 45 
                      at (125, 85) 
                      from 30deg to 330deg 
                      with -arrow at end ;
    
    text id 107 start 48.5s at (125, 93) ''Arc roté'' ;
    
    # ═══════════════════════════════════════
    # SECTION 7 : REPÈRES ET FONCTIONS 2D
    # ═══════════════════════════════════════
    
    # Effacer les éléments précédents
    erase id 900 start 50s for 1s at [10, 20, 21, 22, 23, 30, 40, 41, 42, 43, 44, 45, 
                                       50, 60, 61, 62, 63, 64, 65, 70, 80, 81, 82, 83, 
                                       84, 85, 86, 87, 90, 100, 101, 102, 103, 104, 105, 106, 107] ;
    
    text id 200 start 51s for 2s at (88.89, 10)
         ''[bold][color=#E74C3C]6. Repères Cartésiens et Fonctions Mathématiques[/color][/bold]'' ;
    
    # Repère cartésien principal
    draw 2drep id 300 start 52s for 1.5s 
               at (88.89, 50) 
               color (100, 100, 100, 0.7) 
               width 1.5 
               scale = 5 
               x_range = [-6, 6] 
               y_range = [-4, 4] ;
    
    text id 201 start 53.5s at (20, 18) ''Repère cartésien'' ;
    
    # Fonction polynomiale : parabole
    draw 2dfunc id 310 start 54s for 2s 
                color (231, 76, 60, 1) 
                width 3 
                at 300 
                y = x^2/4 - 2 ;
    
    text id 202 start 56s at (150, 25)
         ''[color=#E74C3C]$f(x) = \frac{x^2}{4} - 2$[/color]'' ;
    
    # Fonction trigonométrique : sinus
    draw 2dfunc id 311 start 57s for 2s 
                color (52, 152, 219, 1) 
                width 3 
                at 300 
                y = 2*sin(x) ;
    
    text id 203 start 59s at (150, 32)
         ''[color=#3498DB]$g(x) = 2\sin(x)$[/color]'' ;
    
    # Fonction exponentielle décroissante
    draw 2dfunc id 312 start 60s for 2s 
                color (46, 204, 113, 1) 
                width 3 
                at 300 
                y = 3*exp(-x/2)*cos(x) ;
    
    text id 204 start 62s at (150, 39)
         ''[color=#2ECC71]$h(x) = 3e^{-x/2}\cos(x)$[/color]'' ;
    
    # Fonction racine carrée
    draw 2dfunc id 313 start 63s for 2s 
                color (155, 89, 182, 1) 
                width 3 
                at 300 
                y = sqrt(abs(x)) ;
    
    text id 205 start 65s at (150, 46)
         ''[color=#9B59B6]$i(x) = \sqrt{|x|}$[/color]'' ;
    
    # Points remarquables sur les fonctions
    draw circle id 320 start 66s 
                color (243, 156, 18, 1) 
                width 2 
                fillcolor (243, 156, 18, 1) 
                radius 1.5 
                at (88.89, 40) ;
    
    text id 206 start 66.5s at (83, 37) ''$(0, -2)$'' ;
    
    draw circle id 321 start 67s 
                color (243, 156, 18, 1) 
                width 2 
                fillcolor (243, 156, 18, 1) 
                radius 1.5 
                at (113.89, 50) ;
    
    text id 207 start 67.5s at (118, 52) ''$(\frac{\pi}{2}, 2)$'' ;
    
    # ═══════════════════════════════════════
    # SECTION 8 : ANIMATIONS DE CURSEUR
    # ═══════════════════════════════════════
    
    text id 210 start 69s at (20, 75)
         ''[bold][color=#F39C12]Animation du curseur[/color][/bold]'' ;
    
    # Curseur suivant les points remarquables
    mouse move id 600 start 70s for 3s 
               at [(88.89, 40), (113.89, 50), (88.89, 50), (68.89, 60)] ;
    
    # ═══════════════════════════════════════
    # SECTION 9 : FORMULES LaTeX COMPLEXES
    # ═══════════════════════════════════════
    
    erase id 901 start 74s for 1s at [200, 201, 202, 203, 204, 205, 206, 207, 210, 
                                       300, 310, 311, 312, 313, 320, 321] ;
    
    text id 400 start 75s for 2s at (88.89, 15)
         ''[bold][color=#2C3E50]7. Formules Mathématiques Avancées[/color][/bold]'' ;
    
    # Formule de Taylor
    text id 410 start 77s for 3s at (88.89, 30)
         ''$$f(x) = \sum_{n=0}^{\infty} \frac{f^{(n)}(a)}{n!}(x-a)^n$$'' ;
    
    text id 411 start 80s at (88.89, 38)
         ''[italic]Série de Taylor[/italic]'' ;
    
    # Intégrale de Gauss
    text id 412 start 82s for 3s at (88.89, 50)
         ''$$\int_{-\infty}^{+\infty} e^{-x^2} dx = \sqrt{\pi}$$'' ;
    
    text id 413 start 85s at (88.89, 58)
         ''[italic]Intégrale de Gauss[/italic]'' ;
    
    # Équation de Schrödinger
    text id 414 start 87s for 3s at (88.89, 70)
         ''$$i\hbar\frac{\partial}{\partial t}\Psi(\mathbf{r},t) = \hat{H}\Psi(\mathbf{r},t)$$'' ;
    
    text id 415 start 90s at (88.89, 78)
         ''[italic]Équation de Schrödinger[/italic]'' ;
    
    # Formule d'Euler
    text id 416 start 92s for 3s at (88.89, 90)
         ''$$e^{i\pi} + 1 = 0$$'' ;
    
    text id 417 start 95s at (88.89, 95)
         ''[italic]Identité d'Euler : la plus belle équation[/italic]'' ;
    
    # ═══════════════════════════════════════
    # SECTION 10 : DÉMONSTRATION GÉOMÉTRIQUE
    # ═══════════════════════════════════════
    
    erase id 902 start 98s for 1s at [400, 410, 411, 412, 413, 414, 415, 416, 417] ;
    
    text id 500 start 99s for 2s at (88.89, 8)
         ''[bold][color=#E74C3C]8. Construction Géométrique Complexe[/color][/bold]'' ;
    
    text id 501 start 101s at (88.89, 13)
         ''[italic]Théorème du cercle inscrit dans un triangle[/italic]'' ;
    
    # Triangle principal
    draw polygone id 510 start 102s for 2s 
                  color (52, 152, 219, 1) 
                  width 3 
                  fillcolor (52, 152, 219, 0.1) 
                  at [(40, 70), (88.89, 25), (137.78, 70)] ;
    
    # Points du triangle
    draw circle id 511 start 104s 
                color (231, 76, 60, 1) 
                width 2 
                fillcolor (231, 76, 60, 1) 
                radius 2 
                at (40, 70) ;
    
    text id 512 start 104.5s at (33, 72) ''[bold]$A$[/bold]'' ;
    
    draw circle id 513 start 104s 
                color (231, 76, 60, 1) 
                width 2 
                fillcolor (231, 76, 60, 1) 
                radius 2 
                at (88.89, 25) ;
    
    text id 514 start 104.5s at (88.89, 20) ''[bold]$B$[/bold]'' ;
    
    draw circle id 515 start 104s 
                color (231, 76, 60, 1) 
                width 2 
                fillcolor (231, 76, 60, 1) 
                radius 2 
                at (137.78, 70) ;
    
    text id 516 start 104.5s at (143, 72) ''[bold]$C$[/bold]'' ;
    
    # Bissectrices
    draw line id 520 start 106s for 1.5s 
              color (46, 204, 113, 0.6) 
              width 2 
              at [(40, 70), (88.89, 52)] ;
    
    draw line id 521 start 106s for 1.5s 
              color (46, 204, 113, 0.6) 
              width 2 
              at [(88.89, 25), (88.89, 52)] ;
    
    draw line id 522 start 106s for 1.5s 
              color (46, 204, 113, 0.6) 
              width 2 
              at [(137.78, 70), (88.89, 52)] ;
    
    text id 523 start 107.5s at (60, 60)
         ''[color=#2ECC71]Bissectrices[/color]'' ;
    
    # Centre du cercle inscrit (incentre)
    draw circle id 530 start 109s 
                color (155, 89, 182, 1) 
                width 2 
                fillcolor (155, 89, 182, 1) 
                radius 2 
                at (88.89, 52) ;
    
    text id 531 start 109.5s at (93, 54) ''[bold][color=#9B59B6]$I$[/color][/bold]'' ;
    
    # Cercle inscrit
    draw circle id 540 start 111s for 2s 
                color (243, 156, 18, 1) 
                width 3 
                fillcolor (243, 156, 18, 0.15) 
                radius 12 
                at (88.89, 52) ;
    
    text id 541 start 113s at (88.89, 78)
         ''[color=#F39C12]Cercle inscrit[/color]'' ;
    
    # Rayons vers les points de tangence
    draw line id 550 start 114s 
              color (243, 156, 18, 0.7) 
              width 1.5 
              at [(88.89, 52), (64.44, 61)] ;
    
    draw line id 551 start 114s 
              color (243, 156, 18, 0.7) 
              width 1.5 
              at [(88.89, 52), (88.89, 40)] ;
    
    draw line id 552 start 114s 
              color (243, 156, 18, 0.7) 
              width 1.5 
              at [(88.89, 52), (113.34, 61)] ;
    
    text id 553 start 115s at (88.89, 48) ''$r$'' ;
    
    # ═══════════════════════════════════════
    # SECTION 11 : CONCLUSION
    # ═══════════════════════════════════════
    
    erase id 903 start 118s for 1.5s at [500, 501, 510, 511, 512, 513, 514, 515, 516, 
                                          520, 521, 522, 523, 530, 531, 540, 541, 
                                          550, 551, 552, 553] ;
    
    # Message final avec cadre décoratif
    draw polygone id 600 start 120s for 1.5s 
                  color (155, 89, 182, 1) 
                  width 3 
                  fillcolor (155, 89, 182, 0.1) 
                  at [(20, 35), (157.78, 35), (157.78, 65), (20, 65)] ;
    
    text id 601 start 121s for 3s at (45, 38)
         ''[bold][font=Arial][color=#9B59B6]Démonstration Complète Terminée ![/color][/font][/bold]'' ;
    
    text id 602 start 121s for 3s at (45, 45)
         ''[italic]Tous les éléments Hypercourse présentés[/italic]'' ;
    
    text id 603 start 121s for 3s at (45, 52)
         ''$\checkmark$ Lignes • Flèches • Chemins • Courbes • Polygones'' ;
    
    text id 604 start 121s for 3s at (45, 57)
         ''$\checkmark$ Cercles • Ellipses • Arcs • Repères 2D • Fonctions'' ;
    
    # Étoiles décoratives
    draw circle id 610 start 123s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.9) 
                radius 1.5 
                at (25, 50) ;
    
    draw circle id 611 start 123.2s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.9) 
                radius 1.5 
                at (152.78, 50) ;
    
    draw circle id 612 start 123.4s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.9) 
                radius 1.5 
                at (30, 40) ;
    
    draw circle id 613 start 123.6s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.9) 
                radius 1.5 
                at (147.78, 40) ;
    
    draw circle id 614 start 123.8s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.9) 
                radius 1.5 
                at (30, 60) ;
    
    draw circle id 615 start 124s 
                color (241, 196, 15, 1) 
                width 2 
                fillcolor (241, 196, 15, 0.9) 
                radius 1.5 
                at (147.78, 60) ;
    
    # Animation finale du curseur célébrant la fin
    mouse move id 700 start 124s for 2s 
               at [(20, 20), (157.78, 20), (157.78, 80), (20, 80), (88.89, 50)] ;
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

      return CoursePlayer(elements: elements, totalDuration: totalDuration);
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
