import 'package:flutter/material.dart';
import '../models/hyper_element.dart';
import '../../models/basic_elements/draw_element.dart';
import '../../models/basic_elements/text_element.dart';
import '../../models/basic_elements/plot_element.dart';
import '../../models/basic_elements/mouse_event_element.dart';
import '../../models/basic_elements/erase_element.dart';
import '../../models/basic_elements/speech_element.dart';
import '../board_painter/board_painter.dart';
import '../board_writter/latex_widget.dart';
import '../board_plotter/plot_widget.dart';

class CoursePlayer extends StatefulWidget {
  final List<HyperElement> elements;
  final double totalDuration;
  const CoursePlayer({super.key, required this.elements, required this.totalDuration});
  @override
  CoursePlayerState createState() => CoursePlayerState();
}

class CoursePlayerState extends State<CoursePlayer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<HyperElement> _visibleElements = [];
  final Set<int> _playedSpeechIds = {};

  @override
  void initState() {
    super.initState();
    
    // Calculer la vraie durée max depuis les éléments
    double maxTime = 0.0;
    for (var element in widget.elements) {
      final endTime = element.startTime + element.duration;
      if (endTime > maxTime) {
        maxTime = endTime;
      }
    }
    
    // Prendre le max entre totalDuration fournie et calculée
    final actualDuration = maxTime > widget.totalDuration ? maxTime : widget.totalDuration;
    
    print('📊 === DURÉE DU COURS ===');
    print('📊 Durée fournie: ${widget.totalDuration}s');
    print('📊 Durée calculée: ${maxTime.toStringAsFixed(2)}s');
    print('📊 Durée utilisée: ${actualDuration.toStringAsFixed(2)}s');
    print('📊 Nombre d\'éléments: ${widget.elements.length}');
    
    // IMPORTANT : Utiliser milliseconds pour avoir la précision
    _controller = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: (actualDuration * 1000).round())
    );
    
    _controller.addListener(() {
      setState(() {
        _updateAndHandleElements();
      });
    });
    
    _controller.forward();
  }

  void _updateAndHandleElements() {
    final currentTime = _controller.value * widget.totalDuration;
    
    // Récupérer tous les éléments dont le startTime est dépassé
    _visibleElements = widget.elements.where((el) => el.startTime <= currentTime).toList();
    
    // Gérer les effacements
    final idsToErase = <int>{};
    for (var element in _visibleElements.whereType<EraseElement>()) {
      // Vérifier si l'animation d'effacement est en cours ou terminée
      if (currentTime >= element.startTime) {
        idsToErase.addAll(element.idsToErase);
      }
    }
    
    // Retirer les éléments effacés ET les commandes erase elles-mêmes
    _visibleElements.removeWhere((el) => 
      idsToErase.contains(el.id) || el is EraseElement
    );
    
    // Filtrer les MouseEvent qui ont terminé leur animation
    _visibleElements.removeWhere((el) {
      if (el is MouseEvent) {
        return currentTime > el.startTime + el.duration;
      }
      return false;
    });

    _visibleElements.whereType<SpeechElement>().forEach((speech) {
      if (!_playedSpeechIds.contains(speech.id)) {
        _playedSpeechIds.add(speech.id);
      }
    });
  }

  @override
  void dispose() { 
    _controller.dispose(); 
    super.dispose(); 
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final whiteboardColor = isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FA);
    final defaultDrawColor = isDarkMode ? Colors.white70 : Colors.black87;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteboardColor,
                    border: Border.all(color: Colors.blueGrey.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _buildWhiteboardContent(defaultDrawColor),
                ),
              ),
              const SizedBox(height: 12),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => LinearProgressIndicator(value: _controller.value),
              ),
              const SizedBox(height: 12),
              _buildControlBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWhiteboardContent(Color defaultDrawColor) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final currentTime = _controller.value * widget.totalDuration;
        
        // === SYSTÈME DE COORDONNÉES 16:9 UNIFORME ===
        final aspectRatio = 16.0 / 9.0;
        final referenceWidth = 100.0 * aspectRatio; // ~177.78
        final referenceHeight = 100.0;
        
        // Calculer l'échelle uniforme (même échelle pour X et Y)
        final scaleX = constraints.maxWidth / referenceWidth;
        final scaleY = constraints.maxHeight / referenceHeight;
        final uniformScale = scaleX < scaleY ? scaleX : scaleY;
        
        // Calculer les offsets pour centrer le contenu
        final offsetX = (constraints.maxWidth - referenceWidth * uniformScale) / 2;
        final offsetY = (constraints.maxHeight - referenceHeight * uniformScale) / 2;
        
        return Stack(
          children: [
            // Couche pour les dessins (incluant Function2D)
            CustomPaint(
              size: Size.infinite,
              painter: BoardPainter(
                allElements: _visibleElements,
                currentTime: currentTime,
                defaultColor: defaultDrawColor,
                showGrid: false, // Mettre à true pour debug
              ),
            ),
            
            // Couche pour les graphiques interactifs
            ..._visibleElements.whereType<PlotElement>().map((element) {
              final progress = _calculateProgress(element, currentTime);
              if (progress <= 0.0) return const SizedBox.shrink();
              
              // Appliquer la transformation 16:9
              final x = element.position.dx * uniformScale + offsetX;
              final y = element.position.dy * uniformScale + offsetY;
              final width = 80 * uniformScale;
              final height = 80 * uniformScale;
              
              return Positioned(
                left: x, 
                top: y, 
                width: width, 
                height: height, 
                child: Opacity(
                  opacity: progress.clamp(0.0, 1.0),
                  child: PlotWidget(element: element),
                ),
              );
            }),
            
            // Couche pour les textes LaTeX avec animation d'écriture
            ..._visibleElements.whereType<TextElement>().map((element) {
              final progress = _calculateProgress(element, currentTime);
              if (progress <= 0.0) return const SizedBox.shrink();
              
              // Appliquer la transformation 16:9
              final x = element.position.dx * uniformScale + offsetX;
              final y = element.position.dy * uniformScale + offsetY;
              
              return Positioned(
                left: x, 
                top: y, 
                child: LatexWidget(
                  content: element.content, 
                  color: defaultDrawColor,
                  progress: progress,
                ),
              );
            }),
            
            // Couche pour le curseur avec animation fluide
            ..._visibleElements.whereType<MouseEvent>().map((element) {
              final progress = _calculateProgress(element, currentTime);
              if (progress <= 0.0 || progress > 1.0) return const SizedBox.shrink();
              
              // Calculer la position actuelle sur le chemin
              final currentPosition = _getPositionOnPath(element.points, progress);
              if (currentPosition == null) return const SizedBox.shrink();
              
              // Appliquer la transformation 16:9
              final x = currentPosition.dx * uniformScale + offsetX;
              final y = currentPosition.dy * uniformScale + offsetY;
              
              return Positioned(
                left: x - 12, // Centrer l'icône
                top: y - 12,
                child: const Icon(
                  Icons.circle, 
                  color: Colors.redAccent, 
                  size: 24,
                ),
              );
            }),
          ],
        );
      },
    );
  }
  
  /// Calcule la progression d'un élément (0.0 à 1.0)
  double _calculateProgress(HyperElement element, double currentTime) {
    if (currentTime < element.startTime) return 0.0;
    
    if (element.duration <= 0) {
      // Apparition instantanée
      return 1.0;
    }
    
    final elapsed = currentTime - element.startTime;
    return (elapsed / element.duration).clamp(0.0, 1.0);
  }
  
  /// Calcule la position sur un chemin défini par une liste de points
  Offset? _getPositionOnPath(List<Offset> points, double progress) {
    if (points.isEmpty) return null;
    if (points.length == 1) return points.first;
    
    // Calculer la longueur totale du chemin
    double totalLength = 0;
    List<double> segmentLengths = [];
    
    for (int i = 0; i < points.length - 1; i++) {
      final segmentLength = (points[i + 1] - points[i]).distance;
      segmentLengths.add(segmentLength);
      totalLength += segmentLength;
    }
    
    if (totalLength == 0) return points.first;
    
    // Trouver le segment et la position sur ce segment
    final targetLength = totalLength * progress;
    double currentLength = 0;
    
    for (int i = 0; i < segmentLengths.length; i++) {
      if (currentLength + segmentLengths[i] >= targetLength) {
        // On est sur ce segment
        final segmentProgress = (targetLength - currentLength) / segmentLengths[i];
        return Offset.lerp(points[i], points[i + 1], segmentProgress)!;
      }
      currentLength += segmentLengths[i];
    }
    
    return points.last;
  }
  
  Widget _buildControlBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 1, blurRadius: 4)],
      ),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
          IconButton(
            icon: Icon(_controller.isAnimating ? Icons.pause : Icons.play_arrow), 
            onPressed: () {
              setState(() {
                if (_controller.isAnimating) {
                  _controller.stop();
                } else {
                  if (_controller.isCompleted) {
                    _controller.reset();
                  }
                  _controller.forward();
                }
              });
            },
          ),
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.front_hand_outlined), onPressed: (){},),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Posez une question...", 
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.send), onPressed: () {}),
          IconButton(icon: const Icon(Icons.mic_none), onPressed: () {}),
        ],
      ),
    );
  }
}