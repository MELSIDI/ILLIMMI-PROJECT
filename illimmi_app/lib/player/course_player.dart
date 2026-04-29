// course_player.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/hyper_element.dart';
import '../models/basic_elements/draw_element.dart';
import '../models/basic_elements/text_element.dart';
import '../models/basic_elements/plot_element.dart';
import '../models/basic_elements/mouse_event_element.dart';
import '../models/basic_elements/erase_element.dart';
import '../models/basic_elements/speech_element.dart';
import '../board_painter/board_painter.dart';
import '../board_writter/latex_widget.dart';
import '../board_plotter/plot_widget.dart';
import '../models/course.dart';

class CoursePlayer extends StatefulWidget {
  final Course course;
  final double totalDuration;

  const CoursePlayer({
    super.key,
    required this.course,
    required this.totalDuration,
  });

  @override
  CoursePlayerState createState() => CoursePlayerState();
}

class CoursePlayerState extends State<CoursePlayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final TextEditingController _questionController = TextEditingController();

  List<HyperElement> _dynamicElements = [];
  List<HyperElement> _staticElements = [];
  final Set<int> _playedSpeechIds = {};
  final Map<int, String> _speechAudioUrls =
      {}; // Cache des URLs audio par ID speech

  @override
  void initState() {
    super.initState();

    // Extraire les URLs audio des éléments speech
    _extractSpeechUrls();

    // Calculer la vraie durée max depuis les éléments
    double maxTime =
        widget.course.config.duration; // la durée calculer dans le parseur
    /*for (var element in widget.elements) {
      final endTime = element.startTime + element.duration;
      if (endTime > maxTime) {
        maxTime = endTime;
      }
    }*/

    final actualDuration = maxTime > widget.totalDuration
        ? maxTime
        : widget.totalDuration;

    print('📊 === DURÉE DU COURS ===');
    print('📊 Durée fournie: ${widget.totalDuration}s');
    print('📊 Durée calculée: ${maxTime.toStringAsFixed(2)}s');
    print('📊 Durée utilisée: ${actualDuration.toStringAsFixed(2)}s');
    print('📊 Nombre d\'éléments: inconue');
    print('📊 Nombre de speech: ${_speechAudioUrls.length}');

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (actualDuration * 1000).round()),
    );

    _controller.addListener(() {
      setState(() {
        _updateAndHandleElements();
      });
    });

    // Configurer l'audio player
    _audioPlayer.setReleaseMode(ReleaseMode.stop);

    _controller.forward();
  }

  void _extractSpeechUrls() {
    for (var element in widget.course.audioRegistry.values) {
      if (element.audioPath != null) {
        _speechAudioUrls[element.id] = element.audioPath!;
      } else {
        print(
          '⚠️ Aucune URL audio pour speech ${element.id} - ${element.text.substring(0, element.text.length > 20 ? 20 : element.text.length)}...',
        );
      }
    }
  }

  Future<void> _playSpeech(SpeechElement speech) async {
    if (_playedSpeechIds.contains(speech.id)) return;

    final audioUrl = _speechAudioUrls[speech.id];
    if (audioUrl == null || audioUrl.isEmpty) {
      print('⚠️ Pas d\'URL audio pour speech ${speech.id}');
      return;
    }

    try {
      // Vérifier si c'est une URL réseau ou locale
      if (audioUrl.startsWith('http://') || audioUrl.startsWith('https://')) {
        await _audioPlayer.play(UrlSource(audioUrl));
      } else {
        await _audioPlayer.play(DeviceFileSource(audioUrl));
      }

      _playedSpeechIds.add(speech.id);
      print('🎤 Audio joué: ${speech.id} - ${audioUrl}');
    } catch (e) {
      print('❌ Erreur lecture audio ${speech.id}: $e');
    }
  }

  void _updateAndHandleElements() {
    final currentTime = _controller.value * widget.totalDuration;

    ActiveElement activeElement = widget.course.queryAll(currentTime);
    _dynamicElements = activeElement.dynamicElement;
    _staticElements = activeElement.staticElement;

    // Gérer les speech (audio)
    for (var speech in widget.course.audioRegistry.values) {
      if (speech.startTime <= currentTime &&
          currentTime < speech.endTime &&
          !_playedSpeechIds.contains(speech.id)) {
        _playSpeech(speech);
      }
    }
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.isAnimating) {
        _controller.stop();
        _audioPlayer.pause();
      } else {
        if (_controller.isCompleted) {
          _controller.reset();
          _playedSpeechIds.clear();
        }
        _controller.forward();
        // L'audio reprendra automatiquement via _updateAndHandleElements
      }
    });
  }

  void _handleQuestion() {
    final question = _questionController.text.trim();
    if (question.isEmpty) return;

    // TODO: Implémenter l'interaction avec l'IA
    print('❓ Question posée: $question');

    // Pause du cours pour permettre la réponse
    if (_controller.isAnimating) {
      _togglePlayPause();
    }

    // Afficher un message temporaire
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Question reçue: $question'),
        duration: const Duration(seconds: 2),
      ),
    );

    _questionController.clear();
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final whiteboardColor = isDarkMode
        ? const Color(0xFF1E1E1E)
        : const Color(0xFFF8F9FA);
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
                builder: (context, child) =>
                    LinearProgressIndicator(value: _controller.value),
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

        // Système de coordonnées 16:9
        final aspectRatio = 16.0 / 9.0;
        final referenceWidth = 100.0 * aspectRatio;
        final referenceHeight = 100.0;

        final scaleX = constraints.maxWidth / referenceWidth;
        final scaleY = constraints.maxHeight / referenceHeight;
        final uniformScale = scaleX < scaleY ? scaleX : scaleY;

        final offsetX =
            (constraints.maxWidth - referenceWidth * uniformScale) / 2;
        final offsetY =
            (constraints.maxHeight - referenceHeight * uniformScale) / 2;

        return Stack(
          children: [
            // Couche Static
            RepaintBoundary(
              child: Stack(
                children: [
                  CustomPaint(
                    size: Size.infinite,
                    painter: BoardPainter(
                      allElements: _staticElements,
                      currentTime: currentTime,
                      defaultColor: defaultDrawColor,
                      isStatic: true,
                      showGrid: false,
                    ),
                  ),

                  // Couche graphiques
                  ..._staticElements.whereType<PlotElement>().map((element) {
                    final progress =
                        1.0; // Toujours complet pour les éléments statiques

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

                  // Couche textes
                  ..._staticElements.whereType<TextElement>().map((element) {
                    final double progress =
                        1.0; // Toujours complet pour les éléments statiques

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
                  // pas de curseur pour les éléments statiques
                ],
              ),
            ),

            // Couche Dynamic
            Stack(
              children: [
                CustomPaint(
                  size: Size.infinite,
                  painter: BoardPainter(
                    allElements: _dynamicElements,
                    currentTime: currentTime,
                    defaultColor: defaultDrawColor,
                    showGrid: false,
                  ),
                ),

                // Couche graphiques
                ..._dynamicElements.whereType<PlotElement>().map((element) {
                  final progress = _calculateProgress(element, currentTime);
                  if (progress <= 0.0) return const SizedBox.shrink();

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

                // Couche textes
                ..._dynamicElements.whereType<TextElement>().map((element) {
                  final progress = _calculateProgress(element, currentTime);
                  if (progress <= 0.0) return const SizedBox.shrink();

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

                // Couche curseur
                ..._dynamicElements.whereType<MouseEvent>().map((element) {
                  final progress = _calculateProgress(element, currentTime);
                  if (progress <= 0.0 || progress > 1.0)
                    return const SizedBox.shrink();

                  final currentPosition = _getPositionOnPath(
                    element.points,
                    progress,
                  );
                  if (currentPosition == null) return const SizedBox.shrink();

                  final x = currentPosition.dx * uniformScale + offsetX;
                  final y = currentPosition.dy * uniformScale + offsetY;

                  return Positioned(
                    left: x - 12,
                    top: y - 12,
                    child: const Icon(
                      Icons.circle,
                      color: Colors.redAccent,
                      size: 24,
                    ),
                  );
                }),
              ],
            ),
          ],
        );
      },
    );
  }

  double _calculateProgress(HyperElement element, double currentTime) {
    if (currentTime < element.startTime) return 0.0;

    if (element.duration <= 0) {
      return 1.0;
    }

    final elapsed = currentTime - element.startTime;
    return (elapsed / element.duration).clamp(0.0, 1.0);
  }

  Offset? _getPositionOnPath(List<Offset> points, double progress) {
    if (points.isEmpty) return null;
    if (points.length == 1) return points.first;

    double totalLength = 0;
    List<double> segmentLengths = [];

    for (int i = 0; i < points.length - 1; i++) {
      final segmentLength = (points[i + 1] - points[i]).distance;
      segmentLengths.add(segmentLength);
      totalLength += segmentLength;
    }

    if (totalLength == 0) return points.first;

    final targetLength = totalLength * progress;
    double currentLength = 0;

    for (int i = 0; i < segmentLengths.length; i++) {
      if (currentLength + segmentLengths[i] >= targetLength) {
        final segmentProgress =
            (targetLength - currentLength) / segmentLengths[i];
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          // Bouton Menu/Retour
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Retour',
          ),

          // Bouton Play/Pause
          IconButton(
            icon: Icon(
              _controller.isAnimating ? Icons.pause : Icons.play_arrow,
            ),
            onPressed: _togglePlayPause,
            tooltip: _controller.isAnimating ? 'Pause' : 'Lecture',
          ),

          const SizedBox(width: 8),

          // Bouton Interaction (pause pour poser question)
          IconButton(
            icon: const Icon(Icons.front_hand_outlined),
            onPressed: () {
              if (_controller.isAnimating) {
                _togglePlayPause();
              }
            },
            tooltip: 'Pause pour interaction',
          ),

          // Champ de saisie pour question
          Expanded(
            child: TextField(
              controller: _questionController,
              decoration: const InputDecoration(
                hintText: "Posez une question...",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
              onSubmitted: (_) => _handleQuestion(),
            ),
          ),

          // Bouton Envoyer question
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _handleQuestion,
            tooltip: 'Envoyer la question',
          ),

          // Bouton Micro (pour futur)
          IconButton(
            icon: const Icon(Icons.mic_none),
            onPressed: () {
              // TODO: Implémenter reconnaissance vocale
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reconnaissance vocale bientôt disponible'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            tooltip: 'Reconnaissance vocale',
          ),
        ],
      ),
    );
  }
}
