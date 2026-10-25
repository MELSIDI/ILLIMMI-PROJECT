// course_player.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/hyper_element.dart';
import '../models/basic_elements/text_element.dart';
import '../models/basic_elements/plot_element.dart';
import '../models/basic_elements/mouse_event_element.dart';
import '../board_painter/board_painter.dart';
import '../board_writter/latex_widget.dart';
import '../board_plotter/plot_widget.dart';
import '../models/course.dart';
import '../theme/app_theme.dart';
import '../theme/board_theme.dart';
import '../widgets/chalkboard_frame.dart';
import 'package:flutter/services.dart';
import '../widgets/interactive_qa_dialog.dart';

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
  final FocusNode _questionFocusNode = FocusNode();

  List<HyperElement> _dynamicElements = [];
  List<HyperElement> _staticElements = [];

  // Nouveau format ILLIMMI : audio unique et externe déclaré dans le header du cours.
  late final bool _hasCourseAudio;

  // Horloge réelle basée sur l'audio (mode _hasCourseAudio uniquement).
  Duration _audioPosition = Duration.zero;
  Duration _audioDuration = Duration.zero;
  bool _isPlaying = false;
  bool _isCompleted = false;

  // Thème actif du tableau
  BoardTheme _boardTheme = BoardTheme.green;

  // Contrôles en overlay (style YouTube)
  bool _controlsVisible = true;
  Timer? _hideControlsTimer;

  StreamSubscription<Duration>? _durationSub;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<void>? _completeSub;
  StreamSubscription<PlayerState>? _playerStateSub;

  // Volume
  double _volume = 1.0;
  bool _showVolumeSlider = false;

  // Vitesse de lecture
  double _playbackSpeed = 1.0;

  @override
  void initState() {
    super.initState();

    _questionFocusNode.addListener(() {
      if (_questionFocusNode.hasFocus) {
        _onUserActivity();
      }
    });

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
      _resetHideTimer();
    } else {
      // Mode legacy sans audio externe : comportement inchangé.
      _controller.addListener(() {
        setState(() {
          _updateAndHandleElements();
        });
      });
      _controller.forward();
      _isPlaying = true;
      _resetHideTimer();
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

  void _onUserActivity() {
    if (_controlsVisible) {
      _resetHideTimer();
    }
  }

  void _toggleControls() {
    FocusScope.of(context).unfocus();
    setState(() {
      _controlsVisible = !_controlsVisible;
    });
    if (_controlsVisible) {
      _resetHideTimer();
    } else {
      _hideControlsTimer?.cancel();
    }
  }

  void _resetHideTimer() {
    _hideControlsTimer?.cancel();
    if (_isPlaying && !_questionFocusNode.hasFocus) {
      _hideControlsTimer = Timer(const Duration(seconds: 4), () {
        if (mounted && _isPlaying && !_questionFocusNode.hasFocus) {
          setState(() => _controlsVisible = false);
        }
      });
    }
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
      _hideControlsTimer?.cancel();
      setState(() {
        _isPlaying = false;
        _controlsVisible = true;
      });
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
      _resetHideTimer();
    }
  }

  void _toggleAnimationPlayPause() {
    setState(() {
      if (_controller.isAnimating) {
        _controller.stop();
        _isPlaying = false;
        _controlsVisible = true;
        _hideControlsTimer?.cancel();
      } else {
        if (_controller.isCompleted) {
          _controller.reset();
        }
        _controller.forward();
        _isPlaying = true;
        _resetHideTimer();
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

    // Pause du cours pour permettre l'interaction avec le professeur
    if (_isPlaying) {
      _togglePlayPause();
    }
    _questionController.clear();

    showDialog(
      context: context,
      builder: (ctx) => InteractiveQaDialog(
        courseTitle: widget.course.name.isNotEmpty ? widget.course.name : 'Ce cours',
        question: question,
        currentTimeFormatted: _formatDuration(_currentTimeSeconds),
        onResumeCourse: () {
          Navigator.of(ctx).pop();
          if (!_isPlaying) {
            _togglePlayPause();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    _questionFocusNode.dispose();
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
    final defaultDrawColor = _boardTheme.defaultDrawColor;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1610),
      body: MouseRegion(
        onHover: (_) => _onUserActivity(),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _toggleControls,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Tableau 16:9 immersif maximisé avec letterboxing cinématique (Style YouTube)
              Center(
                child: AspectRatio(
                  aspectRatio: 16.0 / 9.0,
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: _boardTheme.backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.65),
                          blurRadius: 30,
                          spreadRadius: 2,
                        ),
                      ],
                      border: Border.all(
                        color: _boardTheme.borderColor,
                        width: 1.5,
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Texture d'ardoise d'école dans le tableau 16:9
                        Positioned.fill(
                          child: ChalkboardBackground(theme: _boardTheme),
                        ),
                        // Contenu géométrique et texte du cours
                        Positioned.fill(
                          child: _buildWhiteboardContent(defaultDrawColor),
                        ),
                        // Overlay célébration de fin de cours
                        Positioned.fill(
                          child: _buildCompletionOverlay(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 2. Overlay Haut : En-tête avec titre du cours en craie (flottant)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: AnimatedOpacity(
                    opacity: _controlsVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 250),
                    child: IgnorePointer(
                      ignoring: !_controlsVisible,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {},
                        child: _buildPlayerHeader(),
                      ),
                    ),
                  ),
                ),
              ),

              // 3. Overlay Bas : Barre de contrôle flottante (flottante)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 960),
                        child: AnimatedOpacity(
                          opacity: _controlsVisible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 250),
                          child: IgnorePointer(
                            ignoring: !_controlsVisible,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {},
                              child: _buildControlBar(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// En-tête flottant avec dégradé doux et titre du cours
  Widget _buildPlayerHeader() {
    final title = widget.course.name.isNotEmpty
        ? widget.course.name
        : 'Cours interactif ILLIMMI';

    return LayoutBuilder(
      builder: (context, constraints) {
        // Espace réservé à gauche pour les boutons [← Retour] et [ILLIMMI ⌄] de la Sidebar
        final isCompact = constraints.maxWidth < 900;
        final leftReservedWidth = isCompact ? 220.0 : 255.0;
        final rightBalanceWidth = isCompact ? 70.0 : 105.0;

        return Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.7),
                Colors.transparent,
              ],
            ),
          ),
          child: Row(
            children: [
              // Espace réservé pour éviter toute superposition avec la navigation Sidebar
              SizedBox(width: leftReservedWidth),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFF2F6F3),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.restart_alt_rounded, color: Color(0xFFF2F6F3)),
                tooltip: 'Recommencer le cours',
                onPressed: () {
                  setState(() {
                    _isCompleted = false;
                    _audioPosition = Duration.zero;
                  });
                  _seekTo(0);
                  if (!_isPlaying) _togglePlayPause();
                },
              ),
              IconButton(
                icon: const Icon(Icons.copy_rounded, color: Color(0xFFF2F6F3), size: 19),
                tooltip: 'Copier le titre du cours',
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: title));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Titre du cours copié !'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
              PopupMenuButton<BoardTheme>(
                icon: const Icon(Icons.palette_outlined, color: Color(0xFFF2F6F3)),
                tooltip: 'Thème du tableau',
                color: const Color(0xFF1B382B),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0x33FFFFFF)),
                ),
                initialValue: _boardTheme,
                onSelected: (theme) {
                  setState(() => _boardTheme = theme);
                },
                itemBuilder: (context) => BoardTheme.all.map((t) {
                  final isSelected = _boardTheme.type == t.type;
                  return PopupMenuItem<BoardTheme>(
                    value: t,
                    child: Row(
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: t.backgroundColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? AppTheme.chalkBlue : Colors.white60,
                              width: isSelected ? 2.0 : 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          t.label,
                          style: TextStyle(
                            color: isSelected ? AppTheme.chalkBlue : const Color(0xFFF2F6F3),
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              // Équilibrage visuel pour que le titre reste centré sur l'écran
              SizedBox(width: rightBalanceWidth),
            ],
          ),
        );
      },
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

        // Typographie adaptative proportionnelle à l'écran réel (Modèle YouTube)
        // À 720p (scale ≈ 7.2) -> 24px, à 1080p (scale ≈ 10.8) -> 36px, sur mobile (scale ≈ 2.5) -> 9-10px
        final scaledFontSize = (uniformScale * 3.333).clamp(9.0, 72.0);
        final cursorSize = (24.0 * (uniformScale / 7.2)).clamp(12.0, 48.0);
        final cursorHalf = cursorSize / 2;

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
                    const progress =
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
                    const double progress =
                        1.0; // Toujours complet pour les éléments statiques

                    final x = element.position.dx * uniformScale + offsetX;
                    final y = element.position.dy * uniformScale + offsetY;

                    return Positioned(
                      left: x,
                      top: y,
                      child: LatexWidget(
                        content: element.content,
                        fontSize: scaledFontSize,
                        color: defaultDrawColor,
                        progress: progress,
                      ),
                    );
                  }),
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
                      fontSize: scaledFontSize,
                      color: defaultDrawColor,
                      progress: progress,
                    ),
                  );
                }),

                // Couche curseur
                ..._dynamicElements.whereType<MouseEvent>().map((element) {
                  final progress = _calculateProgress(element, currentTime);
                  if (progress <= 0.0 || progress > 1.0) {
                    return const SizedBox.shrink();
                  }

                  final currentPosition = _getPositionOnPath(
                    element.points,
                    progress,
                  );
                  if (currentPosition == null) return const SizedBox.shrink();

                  final x = currentPosition.dx * uniformScale + offsetX;
                  final y = currentPosition.dy * uniformScale + offsetY;

                  return Positioned(
                    left: x - cursorHalf,
                    top: y - cursorHalf,
                    child: Icon(
                      Icons.circle,
                      color: const Color(0xFFFA89A4),
                      size: cursorSize,
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
          icon: Icon(
            _volume == 0 ? Icons.volume_off_rounded : Icons.volume_up_rounded,
            color: const Color(0xFFF2F6F3),
            size: 20,
          ),
          tooltip: 'Volume',
          onPressed: () =>
              setState(() => _showVolumeSlider = !_showVolumeSlider),
        ),
        if (_showVolumeSlider)
          SizedBox(
            width: 80,
            child: Slider(
              min: 0.0,
              max: 1.0,
              value: _volume,
              activeColor: const Color(0xFFF2F6F3),
              inactiveColor: Colors.white.withValues(alpha: 0.25),
              onChanged: (value) {
                setState(() => _volume = value);
                _audioPlayer.setVolume(value);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildSpeedControl() {
    final speeds = [0.75, 1.0, 1.25, 1.5, 2.0];
    return PopupMenuButton<double>(
      initialValue: _playbackSpeed,
      tooltip: 'Vitesse de lecture',
      color: const Color(0xFF1B382B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0x33FFFFFF)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
          color: Colors.white.withValues(alpha: 0.08),
        ),
        child: Text(
          '${_playbackSpeed == 1.0 ? '1' : _playbackSpeed}x',
          style: const TextStyle(
            color: Color(0xFFF2F6F3),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onSelected: (speed) {
        setState(() => _playbackSpeed = speed);
        _audioPlayer.setPlaybackRate(speed);
      },
      itemBuilder: (context) => speeds.map((s) => PopupMenuItem<double>(
        value: s,
        child: Text(
          '${s}x',
          style: TextStyle(
            color: _playbackSpeed == s ? AppTheme.chalkBlue : const Color(0xFFF2F6F3),
            fontWeight: _playbackSpeed == s ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildCompletionOverlay() {
    if (!_isCompleted) return const SizedBox.shrink();

    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        decoration: BoxDecoration(
          color: const Color(0xFF142B20).withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppTheme.chalkBlue.withValues(alpha: 0.6),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline_rounded, color: AppTheme.chalkGreen, size: 56),
            const SizedBox(height: 12),
            const Text(
              'Cours terminé !',
              style: TextStyle(
                color: AppTheme.chalkWhite,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Durée totale : ${_formatDuration(_totalTimeSeconds)}',
              style: const TextStyle(color: AppTheme.chalkDust, fontSize: 13),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton.icon(
                  onPressed: () {
                    setState(() {
                      _isCompleted = false;
                      _audioPosition = Duration.zero;
                    });
                    _seekTo(0);
                    if (!_isPlaying) _togglePlayPause();
                  },
                  icon: const Icon(Icons.replay_rounded),
                  label: const Text('Revoir le cours'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.chalkBlue,
                    foregroundColor: AppTheme.chalkboardGreenDeep,
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: widget.onBack,
                  icon: const Icon(Icons.home_rounded),
                  label: const Text('Nouveau cours'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.chalkWhite,
                    side: const BorderSide(color: Colors.white38),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlBar() {
    final total = _totalTimeSeconds;
    final current = _currentTimeSeconds.clamp(0.0, total > 0 ? total : 0.0);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Rangée 1 : contrôles de lecture + slide de progression en blanc
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.replay_10_rounded, color: Color(0xFFF2F6F3)),
                onPressed: () => _skip(-_skipSeconds),
                tooltip: 'Reculer de 10s',
              ),
              IconButton(
                icon: Icon(
                  _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: const Color(0xFFF2F6F3),
                  size: 28,
                ),
                onPressed: _togglePlayPause,
                tooltip: _isPlaying ? 'Pause' : 'Lecture',
              ),
              IconButton(
                icon: const Icon(Icons.forward_10_rounded, color: Color(0xFFF2F6F3)),
                onPressed: () => _skip(_skipSeconds),
                tooltip: 'Avancer de 10s',
              ),
              const SizedBox(width: 8),
              // Slide de progression et timestamps en blanc entre Avancer 10s et Volume
              Text(
                _formatDuration(current),
                style: const TextStyle(
                  color: Color(0xFFF2F6F3),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 3,
                    activeTrackColor: const Color(0xFFF2F6F3),
                    inactiveTrackColor: Colors.white.withValues(alpha: 0.25),
                    thumbColor: const Color(0xFFF2F6F3),
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
              ),
              Text(
                _formatDuration(total),
                style: const TextStyle(
                  color: Color(0xFFF2F6F3),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              _buildVolumeControl(),
              const SizedBox(width: 6),
              _buildSpeedControl(),
            ],
          ),
          Divider(
            height: 8,
            color: Colors.white.withValues(alpha: 0.15),
          ),
          // Rangée 2 : interaction / question
          Row(
            children: [
              // Bouton Interaction (pause pour poser question)
              IconButton(
                icon: const Icon(Icons.front_hand_outlined, color: Color(0xFFF2F6F3), size: 20),
                onPressed: () {
                  if (_isPlaying) {
                    _togglePlayPause();
                  }
                },
                tooltip: 'Pause pour interaction',
              ),
              const SizedBox(width: 4),
              // Champ de saisie pour question
              Expanded(
                child: TextField(
                  controller: _questionController,
                  focusNode: _questionFocusNode,
                  style: const TextStyle(
                    color: Color(0xFFF2F6F3),
                    fontSize: 14,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Posez une question...",
                    hintStyle: TextStyle(
                      color: Color(0xFF7E978A),
                      fontSize: 13,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: false,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  ),
                  onSubmitted: (_) => _handleQuestion(),
                ),
              ),

              // Bouton Envoyer question (blanc)
              IconButton(
                icon: const Icon(Icons.send_rounded, color: Color(0xFFF2F6F3), size: 20),
                onPressed: _handleQuestion,
                tooltip: 'Envoyer la question',
              ),

              // Bouton Micro (blanc)
              IconButton(
                icon: const Icon(Icons.mic_none_rounded, color: Color(0xFFF2F6F3), size: 20),
                onPressed: () {
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

