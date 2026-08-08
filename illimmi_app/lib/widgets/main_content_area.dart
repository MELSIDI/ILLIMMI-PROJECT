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
import 'generation_progress_view.dart';

const _orchestratorBaseUrl = 'http://localhost:8080';

/// Zone de contenu principale de l'app : reprend telle quelle la logique de
/// génération/lecture qui vivait auparavant dans `HypercourseDebugPage`
/// (`main.dart`), déplacée ici pour cohabiter avec la sidebar dans
/// `AppShell`. Exposée via une clé globale (`GlobalKey<MainContentAreaState>`)
/// pour que la sidebar puisse déclencher `newCourse()`/`loadFromHistory()`.
class MainContentArea extends StatefulWidget {
  final SessionController sessionController;
  final ValueNotifier<bool> courseActive;

  const MainContentArea({super.key, required this.sessionController, required this.courseActive});

  @override
  State<MainContentArea> createState() => MainContentAreaState();
}

class MainContentAreaState extends State<MainContentArea> {
  final TextEditingController _promptController = TextEditingController();

  Future<Course>? _courseFuture;
  Future<Course> Function()? _retry;
  String _progressStatus = '';

  /// Charge un script de démo fixe depuis `courses/<fileName>`, comme décrit
  /// dans illimmi-doc.md (« L'app Flutter reçoit ce fichier .hc et... »).
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

  /// Génère un cours à partir d'un sujet libre en délégant au microservice
  /// `generation-orchestrator`, dans un isolate séparé de celui de l'UI
  /// (`runGenerationInBackground`). Si connecté, transmet le token pour que
  /// l'orchestrator persiste le cours dans l'historique une fois terminé,
  /// puis rafraîchit la liste côté client.
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

  void _startGeneration() {
    final prompt = _promptController.text.trim();
    if (prompt.isEmpty) return;
    widget.courseActive.value = true;
    setState(() {
      _retry = () => _generateFromPrompt(prompt);
      _progressStatus = 'Planification du cours...';
      _courseFuture = _generateFromPrompt(prompt);
    });
  }

  /// Charge un cours déjà généré depuis l'historique : reparse directement
  /// le script stocké, sans repasser par `generation-orchestrator`.
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
      return _buildPromptEntry();
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
          return CoursePlayer(course: course, totalDuration: course.config.duration, onBack: newCourse);
        }
        return const Center(child: Text('État inconnu'));
      },
    );
  }

  Widget _buildPromptEntry() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Quel sujet veux-tu apprendre ?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _promptController,
                decoration: const InputDecoration(
                  hintText: 'Ex : Explique-moi les dérivées',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _startGeneration(),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _startGeneration,
                child: const Text('Générer'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => _startExample('introduction_geometrie.hc'),
                child: const Text('Charger l\'exemple'),
              ),
              TextButton(
                onPressed: () => _startExample('barycentres.hc'),
                child: const Text('Charger l\'exemple : Barycentres'),
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
            Icon(Icons.error, size: 64, color: colorScheme.error),
            const SizedBox(height: 20),
            Text('Erreur de génération', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text(error, textAlign: TextAlign.center, style: TextStyle(color: colorScheme.error)),
            const SizedBox(height: 20),
            if (_retry != null)
              ElevatedButton(
                onPressed: () => setState(() => _courseFuture = _retry?.call()),
                child: const Text('Réessayer'),
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
