import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../api/generation_isolate.dart';
import '../api/history_client.dart';
import '../models/course.dart';
import '../parsers/hypercourse_parser.dart';
import '../player/course_player.dart';
import '../state/session_controller.dart';
import '../theme/app_theme.dart';
import 'generation_progress_view.dart';
import 'illimmi_logo.dart';

const _orchestratorBaseUrl = 'http://localhost:8080';

/// Zone de contenu principale sur tableau vert (Chalkboard) :
/// En-tête avec badge modèle, greeting avec dégradé craie pastel,
/// 4 cartes de suggestion aux contours en craie blanche et barre de saisie flottante.
class MainContentArea extends StatefulWidget {
  final SessionController sessionController;
  final ValueNotifier<bool> courseActive;

  const MainContentArea({
    super.key,
    required this.sessionController,
    required this.courseActive,
  });

  @override
  State<MainContentArea> createState() => MainContentAreaState();
}

class MainContentAreaState extends State<MainContentArea> {
  final TextEditingController _promptController = TextEditingController();

  Future<Course>? _courseFuture;
  Future<Course> Function()? _retry;
  String _progressStatus = '';
  bool _hasPromptText = false;
  String _selectedModel = 'ILLIMMI 1.5 Flash';
  String _selectedLevel = 'Lycée';

  @override
  void initState() {
    super.initState();
    _promptController.addListener(() {
      final hasText = _promptController.text.trim().isNotEmpty;
      if (hasText != _hasPromptText) {
        setState(() => _hasPromptText = hasText);
      }
    });
  }

  /// Charge un script de démo fixe depuis `courses/<fileName>`
  Future<Course> _loadExample(String fileName) async {
    final script = await _readScriptFile(fileName);
    return HypercourseParser(script).parse();
  }

  Future<String> _readScriptFile(String fileName) async {
    final candidates = [
      p.join(Directory.current.path, 'courses', fileName),
      p.join(Directory.current.path, 'illimmi_app', 'courses', fileName),
      p.join(Directory.current.path, '..', 'courses', fileName),
      p.join(Directory.current.path, '..', 'illimmi_app', 'courses', fileName),
      p.join(Directory.current.path, 'corpus_illimmi_1000', 'exemplars', fileName),
    ];
    for (final candidate in candidates) {
      final file = File(candidate);
      if (file.existsSync()) {
        return await file.readAsString();
      }
    }
    throw Exception('Fichier de script introuvable : $fileName (cherché dans ${candidates.take(2).toList()})');
  }

  /// Génère un cours à partir d'un sujet libre
  Future<Course> _generateFromPrompt(String prompt) async {
    final result = await runGenerationInBackground(
      prompt,
      baseUrl: _orchestratorBaseUrl,
      token: widget.sessionController.token,
      level: _selectedLevel,
      onProgress: (status, message) {
        if (mounted) setState(() => _progressStatus = message);
      },
    );

    final course = await HypercourseParser(result.script).parse();
    // Rafraîchissement automatique de l'historique (mode connecté et invité)
    unawaited(widget.sessionController.refreshHistory());
    return course;
  }

  void _startExample(String fileName) {
    widget.courseActive.value = true;
    setState(() {
      _retry = () => _loadExample(fileName);
      _progressStatus = 'Chargement de l\'exemple...';
      _courseFuture = _loadExample(fileName);
    });
  }

  void _startGeneration([String? overridePrompt]) {
    final prompt = (overridePrompt ?? _promptController.text).trim();
    if (prompt.isEmpty) return;
    widget.courseActive.value = true;
    setState(() {
      _retry = () => _generateFromPrompt(prompt);
      _progressStatus = 'Planification du cours...';
      _courseFuture = _generateFromPrompt(prompt);
    });
  }

  void loadFromHistory(HistoryEntry entry) {
    widget.courseActive.value = true;
    setState(() {
      _retry = null;
      _progressStatus = '';
      _courseFuture = HypercourseParser(entry.result.script).parse();
    });
  }

  void newCourse() {
    widget.courseActive.value = false;
    setState(() {
      _courseFuture = null;
      _promptController.clear();
    });
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_courseFuture == null) {
      return _buildChalkboardHome();
    }

    return FutureBuilder<Course>(
      future: _courseFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GenerationProgressView(message: _progressStatus);
        }
        if (snapshot.hasData) {
          final course = snapshot.data!;
          return CoursePlayer(
            course: course,
            totalDuration: course.config.duration,
            onBack: newCourse,
          );
        }
        return const Center(
          child: Text(
            'État inconnu',
            style: TextStyle(color: AppTheme.chalkDust),
          ),
        );
      },
    );
  }

  /// Page d'accueil style Tableau Vert
  Widget _buildChalkboardHome() {
    return SafeArea(
      child: Column(
        children: [
          // Barre supérieure (Header avec badge modèle)
          _buildTopHeader(context),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 860),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Spacing.xl),
                      // Hero Header avec dégradé Craie Pastel
                      _buildHeroHeader(context),
                      const SizedBox(height: Spacing.xxl),
                      // Grille des 4 suggestions encadrées à la craie
                      _buildSuggestionGrid(context),
                      const SizedBox(height: Spacing.xxl + Spacing.lg),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Barre de saisie flottante en capsule
          _buildFloatingInputBar(context),
        ],
      ),
    );
  }

  /// En-tête avec sélecteur de modèle style pilule ardoise
  Widget _buildTopHeader(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: Center(
        child: PopupMenuButton<String>(
          tooltip: 'Changer de moteur IA',
          initialValue: _selectedModel,
          color: const Color(0xFF1E2824),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
          ),
          onSelected: (model) {
            setState(() => _selectedModel = model);
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: 'ILLIMMI 1.5 Flash',
              child: Row(
                children: [
                  Icon(Icons.bolt, color: AppTheme.chalkYellow, size: 18),
                  SizedBox(width: 8),
                  Text('ILLIMMI 1.5 Flash (Rapide)', style: TextStyle(color: AppTheme.chalkWhite, fontSize: 13)),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'ILLIMMI 2.5 Pro',
              child: Row(
                children: [
                  Icon(Icons.psychology, color: AppTheme.chalkCyan, size: 18),
                  SizedBox(width: 8),
                  Text('ILLIMMI 2.5 Pro (Raisonnement)', style: TextStyle(color: AppTheme.chalkWhite, fontSize: 13)),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'ILLIMMI Audio-First',
              child: Row(
                children: [
                  Icon(Icons.record_voice_over, color: AppTheme.chalkPink, size: 18),
                  SizedBox(width: 8),
                  Text('ILLIMMI Audio-First (Piper TTS)', style: TextStyle(color: AppTheme.chalkWhite, fontSize: 13)),
                ],
              ),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IllimmiChalkIcon(size: 16),
                const SizedBox(width: 8),
                Text(
                  _selectedModel,
                  style: const TextStyle(
                    color: AppTheme.chalkWhite,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_drop_down,
                  size: 18,
                  color: AppTheme.chalkDust,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Titre d'accueil avec dégradé craie pastel
  Widget _buildHeroHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IllimmiChalkLogo(
              height: 48,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(width: 14),
            const Text(
              'Bonjour,',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w500,
                color: AppTheme.chalkDust,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          'Que veux-tu apprendre aujourd\'hui ?',
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            height: 1.2,
            color: AppTheme.chalkWhite,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Sélectionne une suggestion ci-dessous ou saisis ton sujet pour générer un cours interactif personnalisé.',
          style: TextStyle(
            color: AppTheme.chalkDust,
            fontSize: 15,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  /// Grille des 4 cartes de suggestion aux contours en craie
  Widget _buildSuggestionGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useDoubleColumn = constraints.maxWidth > 550;
        final suggestions = [
          _SuggestionData(
            icon: Icons.square_foot_rounded,
            iconColor: AppTheme.chalkBlue,
            title: 'Construire avec des vecteurs',
            description: 'Construire les points E, F et G à partir d\'égalités vectorielles',
            onTap: () => _startExample('vecteurs.hc'),
          ),
          _SuggestionData(
            icon: Icons.balance_rounded,
            iconColor: AppTheme.chalkPurple,
            title: 'Théorie des Barycentres',
            description: 'Centre de masse, vecteurs et coefficients pondérés',
            onTap: () => _startExample('barycentres.hc'),
          ),
          _SuggestionData(
            icon: Icons.show_chart_rounded,
            iconColor: AppTheme.chalkPink,
            title: 'Calcul Différentiel',
            description: 'Explique-moi les dérivées, tangentes et variations de fonctions',
            onTap: () {
              _promptController.text = 'Explique-moi les dérivées et le calcul différentiel';
              _startGeneration();
            },
          ),
          _SuggestionData(
            icon: Icons.science_rounded,
            iconColor: AppTheme.chalkGreen,
            title: 'Physique & Cinématique',
            description: 'Comprendre la vitesse, l\'accélération et les lois du mouvement',
            onTap: () {
              _promptController.text = 'Explique-moi la cinématique et les lois du mouvement';
              _startGeneration();
            },
          ),
        ];

        if (useDoubleColumn) {
          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: Spacing.md,
            mainAxisSpacing: Spacing.md,
            childAspectRatio: 2.2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: suggestions.map((item) => _buildSuggestionCard(context, item)).toList(),
          );
        }

        return Column(
          children: suggestions
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: Spacing.md),
                    child: _buildSuggestionCard(context, item),
                  ))
              .toList(),
        );
      },
    );
  }

  /// Carte de suggestion individuelle avec bordure fine en craie
  Widget _buildSuggestionCard(BuildContext context, _SuggestionData item) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: item.onTap,
        hoverColor: Colors.white.withValues(alpha: 0.06),
        child: Container(
          padding: const EdgeInsets.all(Spacing.md),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.38),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: item.iconColor.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: item.iconColor.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Icon(item.icon, color: item.iconColor, size: 20),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                    color: Colors.white.withValues(alpha: 0.65),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: AppTheme.chalkWhite,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: const TextStyle(
                      color: AppTheme.chalkDust,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Barre de saisie flottante en forme de capsule (Pill Input)
  Widget _buildFloatingInputBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(Spacing.lg, 0, Spacing.lg, Spacing.sm),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 860),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Sélecteur de niveau d'enseignement
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.school, size: 14, color: AppTheme.chalkDustMuted),
                      const SizedBox(width: 6),
                      const Text(
                        'Niveau :',
                        style: TextStyle(
                          color: AppTheme.chalkDustMuted,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      for (final lvl in ['Collège', 'Lycée', 'Supérieur', 'Tout public']) ...[
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () => setState(() => _selectedLevel = lvl),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: _selectedLevel == lvl
                                    ? AppTheme.chalkGreen.withValues(alpha: 0.3)
                                    : Colors.black.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: _selectedLevel == lvl
                                      ? AppTheme.chalkGreen
                                      : Colors.white.withValues(alpha: 0.2),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                lvl,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: _selectedLevel == lvl ? FontWeight.w600 : FontWeight.normal,
                                  color: _selectedLevel == lvl ? AppTheme.chalkWhite : AppTheme.chalkDust,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Row(
                  children: [
                    // Logo Craie ILLIMMI à gauche
                    const SizedBox(width: 2),
                    IllimmiChalkIcon(size: 20),
                    const SizedBox(width: 10),
                    // Champ de texte principal
                    Expanded(
                      child: TextField(
                        controller: _promptController,
                        style: const TextStyle(
                          color: AppTheme.chalkWhite,
                          fontSize: 15,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Demande à ILLIMMI de créer un cours...',
                          hintStyle: TextStyle(
                            color: AppTheme.chalkDustMuted,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: false,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        onSubmitted: (_) => _startGeneration(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Bouton d'envoi circulaire en craie
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(22),
                        onTap: _startGeneration,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: _hasPromptText ? AppTheme.chalkGradient : null,
                            color: _hasPromptText ? null : Colors.white.withValues(alpha: 0.15),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.4),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_upward_rounded,
                            color: _hasPromptText ? Colors.black87 : AppTheme.chalkWhite,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'ILLIMMI peut générer des cours avec visuels interactifs et synthèse vocale.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.chalkDustMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 520),
          padding: const EdgeInsets.all(Spacing.xl),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppTheme.chalkPink.withValues(alpha: 0.6),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline_rounded, size: 56, color: AppTheme.chalkPink),
              const SizedBox(height: 16),
              const Text(
                'Erreur de génération',
                style: TextStyle(
                  color: AppTheme.chalkWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SelectableText(
                  error,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppTheme.chalkPink, fontSize: 13, height: 1.4),
                ),
              ),
              const SizedBox(height: 20),
              if (_retry != null)
                FilledButton.icon(
                  onPressed: () => setState(() => _courseFuture = _retry?.call()),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.chalkBlue,
                    foregroundColor: AppTheme.chalkboardGreenDeep,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Réessayer', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: newCourse,
                child: const Text('Nouveau cours', style: TextStyle(color: AppTheme.chalkWhite)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionData {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final VoidCallback onTap;

  _SuggestionData({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.onTap,
  });
}

