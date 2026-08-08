// course_player.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/hyper_element.dart';
import '../models/basic_elements/draw_element.dart';
import '../models/basic_elements/text_element.dart';
import '../models/basic_elements/plot_element.dart';
import '../models/basic_elements/mouse_event_element.dart';
import '../models/basic_elements/erase_element.dart';
import '../board_painter/board_painter.dart';
import '../board_writter/latex_widget.dart';
import '../board_plotter/plot_widget.dart';
import '../models/course.dart';

class CoursePlayer extends StatefulWidget {
  final Course course;
  final double totalDuration;
  final VoidCallback onBack;

  const CoursePlayer({
    super.key,
    required this.course,
    required this.totalDuration,
    required this.onBack,
  });

  @override
  CoursePlayerState createState() => CoursePlayerState();
}

class CoursePlayerState extends State<CoursePlayer>
    with SingleTickerProviderStateMixin {
  static const _skipSeconds = 10;

  late AnimationController _controller;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final TextEditingController _questionController = TextEditingController();

  List<HyperElement> _dynamicElements = [];
  List<HyperElement> _staticElements = [];

  // Nouveau format ILLIMMI : audio unique et externe déclaré dans le header du cours.
  late final bool _hasCourseAudio;

  // Horloge réelle basée sur l'audio (mode _hasCourseAudio uniquement).
  Duration _audioPosition = Duration.zero;
  Duration _audioDuration = Duration.zero;
  bool _isPlaying = false;
  bool _isCompleted = false;

  StreamSubscription<Duration>? _durationSub;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<void>? _completeSub;
  StreamSubscription<PlayerState>? _playerStateSub;

  // Volume / luminosité.
  double _volume = 1.0;
  double _dimOpacity = 0.0;
  bool _showVolumeSlider = false;
  bool _showBrightnessSlider = false;

  @override
  void initState() {
    super.initState();

    _hasCourseAudio =
        widget.course.config.audioPath != null &&
        widget.course.config.audioPath!.isNotEmpty;

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

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (actualDuration * 1000).round()),
    );

    // Configurer l'audio player
    _audioPlayer.setReleaseMode(ReleaseMode.stop);
    _audioPlayer.setVolume(_volume);

    if (_hasCourseAudio) {
      // Mode audio réel : la barre de progression et le temps courant sont
      // pilotés par la vraie position/durée de l'audio (voir _wireAudioListeners),
      // pas par l'AnimationController.
      _wireAudioListeners();
      _playCourseAudio();
      _isPlaying = true;
    } else {
      // Mode legacy sans audio externe : comportement inchangé.
      _controller.addListener(() {
        setState(() {
          _updateAndHandleElements();
        });
      });
      _controller.forward();
      _isPlaying = true;
    }
  }

  /// Écoute la vraie horloge audio pour piloter la progression et le temps
  /// courant du cours, au lieu de la durée estimée par le parseur.
  void _wireAudioListeners() {
    _durationSub = _audioPlayer.onDurationChanged.listen((d) {
      if (!mounted) return;
      setState(() => _audioDuration = d);
    });

    _positionSub = _audioPlayer.onPositionChanged.listen((p) {
      if (!mounted) return;
      setState(() {
        _audioPosition = p;
        _updateAndHandleElements();
      });
    });

    _completeSub = _audioPlayer.onPlayerComplete.listen((_) {
      if (!mounted) return;
      setState(() {
        _isPlaying = false;
        _isCompleted = true;
        // Force la position affichée à la durée réelle : garantit que la
        // barre de progression atteint bien 100% quand la narration se termine.
        _audioPosition = _audioDuration;
        _updateAndHandleElements();
      });
    });

    _playerStateSub = _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });
  }

  /// Lance l'audio unique et externe du cours (nouveau format ILLIMMI), en parallèle
  /// de la timeline visuelle. Contrairement au `speech` legacy, il n'y a qu'un seul
  /// fichier pour tout le cours, démarré dès le lancement.
  Future<void> _playCourseAudio() async {
    final path = widget.course.config.audioPath;
    if (path == null || path.isEmpty) return;

    try {
      if (path.startsWith('http://') || path.startsWith('https://')) {
        await _audioPlayer.play(UrlSource(path));
      } else {
        await _audioPlayer.play(DeviceFileSource(path));
      }
      print('🔊 Audio du cours lancé: $path');
    } catch (e) {
      print('❌ Erreur lecture audio du cours: $e');
    }
  }

  double get _currentTimeSeconds => _hasCourseAudio
      ? _audioPosition.inMilliseconds / 1000.0
      : _controller.value * widget.totalDuration;

  double get _totalTimeSeconds => _hasCourseAudio
      ? (_audioDuration > Duration.zero
            ? _audioDuration.inMilliseconds / 1000.0
            : widget.totalDuration)
      : widget.totalDuration;

  void _updateAndHandleElements() {
    final currentTime = _currentTimeSeconds;

    ActiveElement activeElement = widget.course.queryAll(currentTime);
    _dynamicElements = activeElement.dynamicElement;
    _staticElements = activeElement.staticElement;
  }

  void _togglePlayPause() {
    if (_hasCourseAudio) {
      _toggleAudioPlayPause();
    } else {
      _toggleAnimationPlayPause();
    }
  }

  void _toggleAudioPlayPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
      setState(() => _isPlaying = false);
    } else {
      if (_isCompleted) {
        setState(() {
          _isCompleted = false;
          _audioPosition = Duration.zero;
        });
        _audioPlayer.seek(Duration.zero);
        _playCourseAudio(); // relance l'audio du cours depuis le début
      } else {
        _audioPlayer.resume();
      }
      setState(() => _isPlaying = true);
    }
  }

  void _toggleAnimationPlayPause() {
    setState(() {
      if (_controller.isAnimating) {
        _controller.stop();
        _isPlaying = false;
      } else {
        if (_controller.isCompleted) {
          _controller.reset();
        }
        _controller.forward();
        _isPlaying = true;
      }
    });
  }

  Future<void> _skip(int deltaSeconds) async {
    if (_hasCourseAudio) {
      final total = _audioDuration;
      var target = _audioPosition + Duration(seconds: deltaSeconds);
      if (target < Duration.zero) target = Duration.zero;
      if (total > Duration.zero && target > total) target = total;
      await _audioPlayer.seek(target);
      if (mounted) {
        setState(() {
          _audioPosition = target;
          if (_isCompleted && target < total) _isCompleted = false;
        });
      }
    } else {
      final total = widget.totalDuration;
      if (total <= 0) return;
      final currentSeconds = _controller.value * total;
      final targetSeconds = (currentSeconds + deltaSeconds).clamp(0.0, total);
      _controller.value = targetSeconds / total;
    }
  }

  Future<void> _seekTo(double seconds) async {
    if (_hasCourseAudio) {
      final target = Duration(milliseconds: (seconds * 1000).round());
      await _audioPlayer.seek(target);
      if (mounted) {
        setState(() {
          _audioPosition = target;
          if (_isCompleted && target < _audioDuration) _isCompleted = false;
        });
      }
    } else {
      final total = widget.totalDuration;
      if (total <= 0) return;
      setState(() {
        _controller.value = (seconds / total).clamp(0.0, 1.0);
      });
    }
  }

  String _formatDuration(double seconds) {
    final d = Duration(milliseconds: (seconds * 1000).round());
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _handleQuestion() {
    final question = _questionController.text.trim();
    if (question.isEmpty) return;

    // TODO: Implémenter l'interaction avec l'IA
    print('❓ Question posée: $question');

    // Pause du cours pour permettre la réponse
    if (_isPlaying) {
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
    _durationSub?.cancel();
    _positionSub?.cancel();
    _completeSub?.cancel();
    _playerStateSub?.cancel();
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
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: whiteboardColor,
                        border: Border.all(
                          color: Colors.blueGrey.withOpacity(0.2),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _buildWhiteboardContent(defaultDrawColor),
                    ),
                    if (_dimOpacity > 0)
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(_dimOpacity),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _buildProgressBar(),
              const SizedBox(height: 12),
              _buildControlBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    final total = _totalTimeSeconds;
    final current = _currentTimeSeconds.clamp(0.0, total > 0 ? total : 0.0);
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 3,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
          ),
          child: Slider(
            min: 0.0,
            max: total > 0 ? total : 1.0,
            value: current,
            onChanged: total > 0 ? (value) => _seekTo(value) : null,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(current)),
              Text(_formatDuration(total)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWhiteboardContent(Color defaultDrawColor) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final currentTime = _currentTimeSeconds;

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

  Widget _buildVolumeControl() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(_volume == 0 ? Icons.volume_off : Icons.volume_up),
          tooltip: 'Volume',
          onPressed: () =>
              setState(() => _showVolumeSlider = !_showVolumeSlider),
        ),
        if (_showVolumeSlider)
          SizedBox(
            width: 110,
            child: Slider(
              min: 0.0,
              max: 1.0,
              value: _volume,
              onChanged: (value) {
                setState(() => _volume = value);
                _audioPlayer.setVolume(value);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildBrightnessControl() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.brightness_6),
          tooltip: 'Luminosité',
          onPressed: () => setState(
            () => _showBrightnessSlider = !_showBrightnessSlider,
          ),
        ),
        if (_showBrightnessSlider)
          SizedBox(
            width: 110,
            child: Slider(
              min: 0.0,
              max: 0.8,
              value: _dimOpacity,
              onChanged: (value) => setState(() => _dimOpacity = value),
            ),
          ),
      ],
    );
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Rangée 1 : contrôles de lecture
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: widget.onBack,
                tooltip: 'Retour',
              ),
              IconButton(
                icon: const Icon(Icons.replay_10),
                onPressed: () => _skip(-_skipSeconds),
                tooltip: 'Reculer de 10s',
              ),
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: _togglePlayPause,
                tooltip: _isPlaying ? 'Pause' : 'Lecture',
              ),
              IconButton(
                icon: const Icon(Icons.forward_10),
                onPressed: () => _skip(_skipSeconds),
                tooltip: 'Avancer de 10s',
              ),
              const Spacer(),
              _buildVolumeControl(),
              const SizedBox(width: 4),
              _buildBrightnessControl(),
            ],
          ),
          const Divider(height: 8),
          // Rangée 2 : interaction / question
          Row(
            children: [
              // Bouton Interaction (pause pour poser question)
              IconButton(
                icon: const Icon(Icons.front_hand_outlined),
                onPressed: () {
                  if (_isPlaying) {
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
        ],
      ),
    );
  }
}
