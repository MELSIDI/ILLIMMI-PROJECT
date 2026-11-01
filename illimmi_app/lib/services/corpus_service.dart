import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

import '../models/course.dart';
import '../parsers/hypercourse_parser.dart';

/// Modèle représentant un cours certifié ou en cours issu du corpus ILLIMMI (1 000 cours).
class CorpusCourse {
  final String id;
  final String title;
  final String subject;
  final String level;
  final String domain;
  final double durationSeconds;
  final int wordCount;
  final double worldModelScore;
  final int renderedScenes;
  final String status;
  final String? channel;
  final String courseDirPath;
  final String hcPath;
  final String audioPath;
  final String? metadataPath;
  final String? narrationPath;
  final List<String> scenePngPaths;

  CorpusCourse({
    required this.id,
    required this.title,
    required this.subject,
    required this.level,
    required this.domain,
    required this.durationSeconds,
    required this.wordCount,
    required this.worldModelScore,
    required this.renderedScenes,
    required this.status,
    this.channel,
    required this.courseDirPath,
    required this.hcPath,
    required this.audioPath,
    this.metadataPath,
    this.narrationPath,
    required this.scenePngPaths,
  });

  String get formattedDuration {
    final totalSec = durationSeconds.round();
    final mins = totalSec ~/ 60;
    final secs = totalSec % 60;
    if (mins == 0) return '${secs}s';
    return '${mins}m ${secs.toString().padLeft(2, '0')}s';
  }

  bool get hasAudio => File(audioPath).existsSync();
  bool get hasScript => File(hcPath).existsSync();
}

/// Service de découverte, d'inspection et de lecture des cours du corpus ILLIMMI.
/// Réservé aux profils Développeur et Ingénieur IA.
class CorpusService {
  static Directory? _cachedCorpusDir;
  List<CorpusCourse>? _cachedCourses;

  /// Trouve le dossier racine `corpus_illimmi_1000` de manière robuste
  static Directory? findCorpusDirectory() {
    if (_cachedCorpusDir != null && _cachedCorpusDir!.existsSync()) {
      return _cachedCorpusDir;
    }

    final env = Platform.environment['CORPUS_DIR'] ?? Platform.environment['CORPUS_PATH'];
    if (env != null && Directory(env).existsSync()) {
      _cachedCorpusDir = Directory(env);
      return _cachedCorpusDir;
    }

    final candidates = <String>[];

    // Recherche récursive ascendante depuis Directory.current (jusqu'à 5 niveaux)
    var dirIter = Directory.current;
    for (int i = 0; i < 5; i++) {
      candidates.add(p.join(dirIter.path, 'corpus_illimmi_1000'));
      final parent = dirIter.parent;
      if (parent.path == dirIter.path) break;
      dirIter = parent;
    }

    // Recherche récursive ascendante depuis l'exécutable (ex: runner/Debug sur Windows)
    try {
      var exeIter = File(Platform.resolvedExecutable).parent;
      for (int i = 0; i < 6; i++) {
        candidates.add(p.join(exeIter.path, 'corpus_illimmi_1000'));
        final parent = exeIter.parent;
        if (parent.path == exeIter.path) break;
        exeIter = parent;
      }
    } catch (_) {}

    for (final candidate in candidates) {
      final dir = Directory(candidate);
      if (dir.existsSync()) {
        _cachedCorpusDir = dir;
        return dir;
      }
    }
    return null;
  }

  /// Récupère la liste de tous les cours certifiés du corpus
  Future<List<CorpusCourse>> getCorpusCourses({bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedCourses != null) {
      return _cachedCourses!;
    }

    final corpusDir = findCorpusDirectory();
    if (corpusDir == null) {
      return [];
    }

    final progressFile = File(p.join(corpusDir.path, 'catalog', 'progress.json'));
    final catalogFile = File(p.join(corpusDir.path, 'catalog', 'corpus_1000_full.json'));
    final coursesDir = Directory(p.join(corpusDir.path, 'courses'));

    Map<String, dynamic> completedMap = {};
    if (progressFile.existsSync()) {
      try {
        final content = progressFile.readAsStringSync();
        final json = jsonDecode(content) as Map<String, dynamic>;
        completedMap = (json['completed_courses'] as Map<String, dynamic>?) ?? {};
      } catch (_) {}
    }

    Map<String, Map<String, dynamic>> catalogMap = {};
    if (catalogFile.existsSync()) {
      try {
        final content = catalogFile.readAsStringSync();
        final list = jsonDecode(content) as List<dynamic>;
        for (final item in list) {
          if (item is Map<String, dynamic> && item['id'] != null) {
            catalogMap[item['id'] as String] = item;
          }
        }
      } catch (_) {}
    }

    final List<CorpusCourse> courses = [];

    // Priorité aux cours terminés dans progress.json
    for (final entry in completedMap.entries) {
      final cid = entry.key;
      final info = entry.value as Map<String, dynamic>;
      final cat = catalogMap[cid] ?? {};
      final courseDir = Directory(p.join(coursesDir.path, cid));

      final hcFile = File(p.join(courseDir.path, 'course.hc'));
      final audioFile = File(p.join(courseDir.path, 'narration.wav'));
      final metaFile = File(p.join(courseDir.path, 'metadata.json'));
      final narrFile = File(p.join(courseDir.path, 'narration.txt'));

      final rendersDir = Directory(p.join(courseDir.path, 'renders'));
      final scenePngs = <String>[];
      if (rendersDir.existsSync()) {
        final files = rendersDir
            .listSync()
            .whereType<File>()
            .where((f) => p.basename(f.path).startsWith('scene_') && f.path.endsWith('.png'))
            .toList();
        files.sort((a, b) => a.path.compareTo(b.path));
        scenePngs.addAll(files.map((f) => f.path));
      }

      courses.add(
        CorpusCourse(
          id: cid,
          title: info['title'] as String? ?? cat['title'] as String? ?? cid,
          subject: cat['subject'] as String? ?? 'Mathématiques',
          level: cat['level'] as String? ?? 'Seconde',
          domain: cat['domain'] as String? ?? 'Nombres & Calculs',
          durationSeconds: (info['duration_seconds'] as num?)?.toDouble() ?? 0.0,
          wordCount: (info['word_count'] as num?)?.toInt() ?? 0,
          worldModelScore: (info['world_model_score'] as num?)?.toDouble() ?? 10.0,
          renderedScenes: (info['rendered_scenes'] as num?)?.toInt() ?? scenePngs.length,
          status: info['status'] as String? ?? 'COMPLETED',
          channel: info['channel'] as String? ?? cat['author'] as String?,
          courseDirPath: courseDir.path,
          hcPath: hcFile.path,
          audioPath: audioFile.path,
          metadataPath: metaFile.existsSync() ? metaFile.path : null,
          narrationPath: narrFile.existsSync() ? narrFile.path : null,
          scenePngPaths: scenePngs,
        ),
      );
    }

    // Si des dossiers existent sur disque sans être dans progress.json
    if (coursesDir.existsSync()) {
      for (final dir in coursesDir.listSync().whereType<Directory>()) {
        final cid = p.basename(dir.path);
        if (completedMap.containsKey(cid)) continue;
        final hcFile = File(p.join(dir.path, 'course.hc'));
        if (hcFile.existsSync()) {
          final cat = catalogMap[cid] ?? {};
          final audioFile = File(p.join(dir.path, 'narration.wav'));
          final metaFile = File(p.join(dir.path, 'metadata.json'));
          final narrFile = File(p.join(dir.path, 'narration.txt'));

          final rendersDir = Directory(p.join(dir.path, 'renders'));
          final scenePngs = <String>[];
          if (rendersDir.existsSync()) {
            final files = rendersDir
                .listSync()
                .whereType<File>()
                .where((f) => p.basename(f.path).startsWith('scene_') && f.path.endsWith('.png'))
                .toList();
            files.sort((a, b) => a.path.compareTo(b.path));
            scenePngs.addAll(files.map((f) => f.path));
          }

          courses.add(
            CorpusCourse(
              id: cid,
              title: cat['title'] as String? ?? cid,
              subject: cat['subject'] as String? ?? 'Général',
              level: cat['level'] as String? ?? 'Lycée',
              domain: cat['domain'] as String? ?? 'Général',
              durationSeconds: 0.0,
              wordCount: 0,
              worldModelScore: 10.0,
              renderedScenes: scenePngs.length,
              status: 'READY',
              channel: cat['author'] as String?,
              courseDirPath: dir.path,
              hcPath: hcFile.path,
              audioPath: audioFile.path,
              metadataPath: metaFile.existsSync() ? metaFile.path : null,
              narrationPath: narrFile.existsSync() ? narrFile.path : null,
              scenePngPaths: scenePngs,
            ),
          );
        }
      }
    }

    // Tri naturel par ID (MATH_001, MATH_002, ...)
    courses.sort((a, b) => a.id.compareTo(b.id));
    _cachedCourses = courses;
    return courses;
  }

  /// Charge et parse le cours sélectionné pour le CoursePlayer,
  /// en résolvant rigoureusement le chemin audio absolu vers narration.wav
  Future<Course> loadCourse(CorpusCourse item) async {
    final hcFile = File(item.hcPath);
    if (!hcFile.existsSync()) {
      throw Exception('Fichier .hc introuvable pour ${item.id} à l\'emplacement : ${item.hcPath}');
    }

    var script = hcFile.readAsStringSync();

    final audioFile = File(item.audioPath);
    if (audioFile.existsSync()) {
      // Normaliser le chemin selon la plateforme (backslashes natifs sur Windows pour Media Foundation)
      final normalizedAudioPath = Platform.isWindows
          ? audioFile.absolute.path.replaceAll('/', r'\')
          : audioFile.absolute.path;
      script = script.replaceFirst(
        RegExp(r'''audio\s+["'][^"']+["']'''),
        'audio "$normalizedAudioPath"',
      );
    }

    final parser = HypercourseParser(script);
    return await parser.parse();
  }
}

