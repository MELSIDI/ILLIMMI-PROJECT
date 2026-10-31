import 'dart:io';

import 'package:flutter/material.dart';
import '../services/corpus_service.dart';
import '../theme/app_theme.dart';

/// Modal d'exploration et d'inspection du corpus ILLIMMI (1 000 cours).
/// Fonctionnalité exclusive pour Développeur et Ingénieur IA.
class CorpusExplorerDialog extends StatefulWidget {
  final CorpusService corpusService;
  final List<CorpusCourse>? initialCourses;
  final void Function(CorpusCourse course) onPlayCourse;

  const CorpusExplorerDialog({
    super.key,
    required this.corpusService,
    this.initialCourses,
    required this.onPlayCourse,
  });

  @override
  State<CorpusExplorerDialog> createState() => _CorpusExplorerDialogState();
}

class _CorpusExplorerDialogState extends State<CorpusExplorerDialog> {
  final TextEditingController _searchController = TextEditingController();
  List<CorpusCourse> _allCourses = [];
  List<CorpusCourse> _filteredCourses = [];
  bool _loading = true;
  String? _error;
  CorpusCourse? _inspectingCourse;

  @override
  void initState() {
    super.initState();
    if (widget.initialCourses != null) {
      _allCourses = List.from(widget.initialCourses!);
      _filteredCourses = List.from(widget.initialCourses!);
      _loading = false;
    } else {
      _loadData();
    }
    _searchController.addListener(_applyFilter);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData({bool force = false}) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final courses = await widget.corpusService.getCorpusCourses(forceRefresh: force);
      if (mounted) {
        setState(() {
          _allCourses = courses;
          _applyFilter();
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _loading = false;
        });
      }
    }
  }

  void _applyFilter() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() => _filteredCourses = List.from(_allCourses));
    } else {
      setState(() {
        _filteredCourses = _allCourses.where((c) {
          return c.id.toLowerCase().contains(query) ||
              c.title.toLowerCase().contains(query) ||
              c.subject.toLowerCase().contains(query) ||
              c.domain.toLowerCase().contains(query) ||
              c.level.toLowerCase().contains(query);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(
          color: Colors.white.withValues(alpha: 0.35),
          width: 1.2,
        ),
      ),
      backgroundColor: const Color(0xFF142B20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 960, maxHeight: 720),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              const SizedBox(height: Spacing.md),
              _buildStatsBanner(context),
              const SizedBox(height: Spacing.md),
              _buildSearchBar(context),
              const SizedBox(height: Spacing.md),
              Expanded(
                child: _inspectingCourse != null
                    ? _buildCourseInspector(context, _inspectingCourse!)
                    : _buildCourseList(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.chalkCyan.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.chalkCyan.withValues(alpha: 0.4),
              width: 1.2,
            ),
          ),
          child: const Icon(Icons.science_rounded, color: AppTheme.chalkCyan, size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                runSpacing: 4,
                children: [
                  const Text(
                    'Laboratoire Corpus ILLIMMI',
                    style: TextStyle(
                      color: AppTheme.chalkWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 0.3,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppTheme.chalkGreen.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.chalkGreen.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    child: const Text(
                      'AI ENGINEER / DEV',
                      style: TextStyle(
                        color: AppTheme.chalkGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              const Text(
                'Parcours, inspection et lecture synchrone des cours certifiés du Lycée',
                style: TextStyle(
                  color: AppTheme.chalkDustMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.refresh_rounded, color: AppTheme.chalkDust),
          tooltip: 'Actualiser le corpus',
          onPressed: () => _loadData(force: true),
        ),
        IconButton(
          icon: const Icon(Icons.close_rounded, color: AppTheme.chalkDust),
          tooltip: 'Fermer',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _buildStatsBanner(BuildContext context) {
    final count = _allCourses.length;
    final totalSeconds = _allCourses.fold<double>(0.0, (acc, c) => acc + c.durationSeconds);
    final totalWords = _allCourses.fold<int>(0, (acc, c) => acc + c.wordCount);
    final totalScenes = _allCourses.fold<int>(0, (acc, c) => acc + c.renderedScenes);

    final mins = (totalSeconds / 60).round();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatPill(
            icon: Icons.check_circle_outline_rounded,
            color: AppTheme.chalkGreen,
            label: 'Validés',
            value: '$count / 1000',
          ),
          _buildDivider(),
          _buildStatPill(
            icon: Icons.timer_outlined,
            color: AppTheme.chalkCyan,
            label: 'Durée Totale',
            value: '~$mins min',
          ),
          _buildDivider(),
          _buildStatPill(
            icon: Icons.record_voice_over_outlined,
            color: AppTheme.chalkYellow,
            label: 'Mots Whisper',
            value: '$totalWords',
          ),
          _buildDivider(),
          _buildStatPill(
            icon: Icons.dashboard_outlined,
            color: AppTheme.chalkPink,
            label: 'Planches PNG',
            value: '$totalScenes scènes',
          ),
        ],
      ),
    );
  }

  Widget _buildStatPill({
    required IconData icon,
    required Color color,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppTheme.chalkDustMuted,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      color: Colors.white.withValues(alpha: 0.15),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextField(
      controller: _searchController,
      style: const TextStyle(color: AppTheme.chalkWhite, fontSize: 13),
      decoration: InputDecoration(
        hintText: 'Rechercher par ID (ex: MATH_001), titre, domaine ou mot-clé...',
        hintStyle: const TextStyle(color: AppTheme.chalkDustMuted, fontSize: 13),
        prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.chalkDust, size: 20),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear_rounded, color: AppTheme.chalkDust, size: 18),
                onPressed: () => _searchController.clear(),
              )
            : null,
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.2),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.25)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.25)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppTheme.chalkCyan),
        ),
      ),
    );
  }

  Widget _buildCourseList(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(color: AppTheme.chalkCyan),
      );
    }

    if (_error != null) {
      return Center(
        child: Text(
          'Erreur : $_error',
          style: const TextStyle(color: AppTheme.chalkPink),
        ),
      );
    }

    if (_filteredCourses.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.folder_open_rounded, size: 48, color: Colors.white.withValues(alpha: 0.3)),
            const SizedBox(height: 12),
            const Text(
              'Aucun cours trouvé dans le corpus.',
              style: TextStyle(color: AppTheme.chalkDust, fontSize: 14),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _filteredCourses.length,
      itemBuilder: (context, index) {
        final course = _filteredCourses[index];
        return _buildCourseCard(context, course);
      },
    );
  }

  Widget _buildCourseCard(BuildContext context, CorpusCourse course) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.22),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.chalkCyan.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppTheme.chalkCyan.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Text(
                  course.id,
                  style: const TextStyle(
                    color: AppTheme.chalkCyan,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${course.level} • ${course.domain}',
                  style: const TextStyle(
                    color: AppTheme.chalkDust,
                    fontSize: 11,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppTheme.chalkYellow.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.chalkYellow.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded, color: AppTheme.chalkYellow, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      'Score: ${course.worldModelScore.toStringAsFixed(1)} / 10',
                      style: const TextStyle(
                        color: AppTheme.chalkYellow,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            course.title,
            style: const TextStyle(
              color: AppTheme.chalkWhite,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _buildBadge(Icons.timer_outlined, course.formattedDuration, AppTheme.chalkCyan),
                  _buildBadge(Icons.notes_rounded, '\ mots', AppTheme.chalkDust),
                  _buildBadge(Icons.dashboard_rounded, '\ scènes', AppTheme.chalkGreen),
                  if (course.hasAudio)
                    _buildBadge(Icons.volume_up_rounded, 'Audio PCM', AppTheme.chalkPurple),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => setState(() => _inspectingCourse = course),
                    icon: const Icon(Icons.visibility_outlined, size: 16),
                    label: const Text('Inspecter'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.chalkDust,
                      side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onPlayCourse(course);
                    },
                    icon: const Icon(Icons.play_arrow_rounded, size: 18),
                    label: const Text('Lire le cours'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.chalkGreen,
                      foregroundColor: AppTheme.chalkboardGreenDeep,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCourseInspector(BuildContext context, CorpusCourse course) {
    return DefaultTabController(
      length: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded, color: AppTheme.chalkWhite),
                tooltip: 'Retour à la liste des cours',
                onPressed: () => setState(() => _inspectingCourse = null),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Audit & Inspection : ${course.id} — ${course.title}',
                  style: const TextStyle(
                    color: AppTheme.chalkWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.onPlayCourse(course);
                },
                icon: const Icon(Icons.play_arrow_rounded, size: 18),
                label: const Text('Lire dans le Player'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.chalkGreen,
                  foregroundColor: AppTheme.chalkboardGreenDeep,
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.sm),
          TabBar(
            indicatorColor: AppTheme.chalkCyan,
            labelColor: AppTheme.chalkCyan,
            unselectedLabelColor: AppTheme.chalkDust,
            tabs: [
              Tab(
                icon: const Icon(Icons.photo_library_outlined, size: 18),
                text: 'Planches PNG (${course.scenePngPaths.length})',
              ),
              const Tab(
                icon: Icon(Icons.schema_outlined, size: 18),
                text: 'Plan Pédagogique (Layer 1)',
              ),
              const Tab(
                icon: Icon(Icons.mic_none_outlined, size: 18),
                text: 'Narration Orale (Layer 2)',
              ),
              const Tab(
                icon: Icon(Icons.code_rounded, size: 18),
                text: 'Hypercourse .hc (Layer 3)',
              ),
            ],
          ),
          const SizedBox(height: Spacing.md),
          Expanded(
            child: TabBarView(
              children: [
                _buildScenesGalleryTab(course),
                _buildFileTextTab(course.metadataPath, 'metadata.json introuvable'),
                _buildFileTextTab(course.narrationPath, 'narration.txt introuvable'),
                _buildFileTextTab(course.hcPath, 'course.hc introuvable'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenesGalleryTab(CorpusCourse course) {
    if (course.scenePngPaths.isEmpty) {
      return const Center(
        child: Text(
          'Aucune capture de scène PNG disponible.',
          style: TextStyle(color: AppTheme.chalkDust),
        ),
      );
    }

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.6,
      ),
      itemCount: course.scenePngPaths.length,
      itemBuilder: (context, idx) {
        final imgPath = course.scenePngPaths[idx];
        final fileName = imgPath.split(RegExp(r'[\\/]')).last;
        return Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(
                File(imgPath),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, color: AppTheme.chalkPink),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  color: Colors.black.withValues(alpha: 0.7),
                  child: Text(
                    fileName,
                    style: const TextStyle(
                      color: AppTheme.chalkWhite,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFileTextTab(String? filePath, String missingMsg) {
    if (filePath == null || !File(filePath).existsSync()) {
      return Center(
        child: Text(missingMsg, style: const TextStyle(color: AppTheme.chalkDustMuted)),
      );
    }

    return FutureBuilder<String>(
      future: File(filePath).readAsString(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator(color: AppTheme.chalkCyan));
        }
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SelectableText(
              snapshot.data!,
              style: const TextStyle(
                color: AppTheme.chalkWhite,
                fontSize: 12,
                fontFamily: 'monospace',
                height: 1.4,
              ),
            ),
          ),
        );
      },
    );
  }
}

