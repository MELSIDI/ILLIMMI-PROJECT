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
import 'gemini_gradient_text.dart';
import 'generation_progress_view.dart';

const _orchestratorBaseUrl = 'http://localhost:8080';

/// Zone de contenu principale style Google Gemini Web :
/// En-tête avec sélecteur de modèle, greeting avec dégradé polychrome,
/// cartes de suggestion interactives et barre de saisie flottante (pill input).
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
    final path = p.join(Directory.current.path, 'courses', fileName);
    final file = File(path);
    if (!await file.exists()) {
      throw Exception('Fichier de script introuvable : $path');
    }
    return await file.readAsString();
  }

  /// Génère un cours à partir d'un sujet libre
  Future<Course> _generateFromPrompt(String prompt) async {
    final result = await runGenerationInBackground(
      prompt,
      baseUrl: _orchestratorBaseUrl,
      token: widget.sessionController.token,
      onProgress: (status, message) {
        if (mounted) setState(() => _progressStatus = message);
      },
    );

    final course = await HypercourseParser(result.script).parse();
    if (widget.sessionController.isLoggedIn) {
      unawaited(widget.sessionController.refreshHistory());
    }
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
      return _buildGeminiHome();
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
        return const Center(child: Text('État inconnu'));
      },
    );
  }

  /// Page d'accueil style Google Gemini Web
  Widget _buildGeminiHome() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Stack(
        children: [
          // Arrière-plan subtil avec gradient radial Gemini en haut
          Positioned(
            top: -100,
            left: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.geminiBlue.withValues(alpha: isDark ? 0.12 : 0.08),
                    AppTheme.geminiPurple.withValues(alpha: isDark ? 0.06 : 0.04),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              // Barre supérieure (Header Gemini avec badge modèle)
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
                          // Hero Header avec dégradé Gemini
                          _buildHeroHeader(context),
                          const SizedBox(height: Spacing.xxl),
                          // Grille des suggestions Gemini (4 cartes)
                          _buildSuggestionGrid(context),
                          const SizedBox(height: Spacing.xxl + Spacing.lg),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Floating Pill Input Bar Gemini en bas
              _buildFloatingInputBar(context, colorScheme, isDark),
            ],
          ),
        ],
      ),
    );
  }

  /// En-tête Gemini avec sélecteur de modèle "ILLIMMI 1.5 Flash"
  Widget _buildTopHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Espace pour le logo sidebar à gauche
          const SizedBox(width: 140),
          // Badge sélecteur de modèle style Gemini
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkSurfaceContainer : AppTheme.lightSurfaceContainer,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (b) => AppTheme.geminiSparkleGradient.createShader(b),
                  child: const Icon(Icons.auto_awesome, size: 18),
                ),
                const SizedBox(width: 8),
                Text(
                  'ILLIMMI 1.5 Flash',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.arrow_drop_down,
                  size: 20,
                  color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                ),
              ],
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  /// Titre d'accueil avec dégradé Gemini
  Widget _buildHeroHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppTheme.geminiBlue.withValues(alpha: 0.2),
                    AppTheme.geminiPurple.withValues(alpha: 0.2),
                  ],
                ),
              ),
              child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (b) => AppTheme.geminiSparkleGradient.createShader(b),
                child: const Icon(Icons.auto_awesome, size: 32),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Bonjour,',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppTheme.darkTextSecondary
                        : AppTheme.lightTextSecondary,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const GeminiGradientText(
          'Que veux-tu apprendre aujourd\'hui ?',
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Sélectionne une suggestion ci-dessous ou saisis ton sujet pour générer un cours interactif personnalisé.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppTheme.darkTextSecondary
                    : AppTheme.lightTextSecondary,
              ),
        ),
      ],
    );
  }

  /// Grille des cartes de suggestion Gemini (4 cartes)
  Widget _buildSuggestionGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useDoubleColumn = constraints.maxWidth > 550;
        final suggestions = [
          _SuggestionData(
            icon: Icons.square_foot_rounded,
            iconColor: const Color(0xFF4285F4),
            title: 'Géométrie dans l\'espace',
            description: 'Introduction aux figures, théorèmes et constructions visuelles',
            onTap: () => _startExample('introduction_geometrie.hc'),
          ),
          _SuggestionData(
            icon: Icons.balance_rounded,
            iconColor: const Color(0xFF9B51E0),
            title: 'Théorie des Barycentres',
            description: 'Centre de masse, vecteurs et coefficients pondérés',
            onTap: () => _startExample('barycentres.hc'),
          ),
          _SuggestionData(
            icon: Icons.show_chart_rounded,
            iconColor: const Color(0xFFD9657B),
            title: 'Calcul Différentiel',
            description: 'Explique-moi les dérivées, tangentes et variations de fonctions',
            onTap: () {
              _promptController.text = 'Explique-moi les dérivées et le calcul différentiel';
              _startGeneration();
            },
          ),
          _SuggestionData(
            icon: Icons.science_rounded,
            iconColor: const Color(0xFF34A853),
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

  /// Carte de suggestion individuelle style Gemini
  Widget _buildSuggestionCard(BuildContext context, _SuggestionData item) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: item.onTap,
        hoverColor: item.iconColor.withValues(alpha: 0.08),
        child: Container(
          padding: const EdgeInsets.all(Spacing.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
              width: 1,
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
                      color: item.iconColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(item.icon, color: item.iconColor, size: 22),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                    color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
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

  /// Barre de saisie flottante en forme de capsule (Pill Input) Gemini
  Widget _buildFloatingInputBar(BuildContext context, ColorScheme colorScheme, bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(Spacing.lg, 0, Spacing.lg, Spacing.lg),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 860),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkSurfaceContainer : AppTheme.lightSurfaceContainer,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    // Icône Gemini Sparkle à gauche du texte
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (b) => AppTheme.geminiSparkleGradient.createShader(b),
                      child: const Icon(Icons.auto_awesome, size: 24),
                    ),
                    const SizedBox(width: 12),
                    // Champ de texte principal
                    Expanded(
                      child: TextField(
                        controller: _promptController,
                        style: Theme.of(context).textTheme.bodyLarge,
                        decoration: InputDecoration(
                          hintText: 'Demande à ILLIMMI de créer un cours...',
                          hintStyle: TextStyle(
                            color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: false,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onSubmitted: (_) => _startGeneration(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Bouton d'envoi circulaire Gemini
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(24),
                        onTap: _startGeneration,
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: _hasPromptText ? AppTheme.geminiGradient : null,
                            color: _hasPromptText
                                ? null
                                : (isDark ? AppTheme.darkSurface : AppTheme.lightSurface),
                          ),
                          child: Icon(
                            Icons.arrow_upward_rounded,
                            color: _hasPromptText
                                ? Colors.white
                                : (isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary),
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'ILLIMMI peut générer des cours avec visuels interactifs et synthèse vocale.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 11,
                      color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded, size: 64, color: colorScheme.error),
            const SizedBox(height: 20),
            Text('Erreur de génération', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text(error, textAlign: TextAlign.center, style: TextStyle(color: colorScheme.error)),
            const SizedBox(height: 20),
            if (_retry != null)
              FilledButton.icon(
                onPressed: () => setState(() => _courseFuture = _retry?.call()),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Réessayer'),
              ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: newCourse,
              child: const Text('Nouveau cours'),
            ),
          ],
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
