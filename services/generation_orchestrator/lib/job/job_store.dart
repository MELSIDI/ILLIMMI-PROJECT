import 'dart:async';
import 'dart:io';

import '../http/audio_service_client.dart';
import '../http/board_render_service_client.dart';
import '../http/user_service_client.dart';
import '../parsers/hypercourse_parser.dart';
import '../pipeline/claude_client.dart';
import '../pipeline/course_assembler.dart';
import '../pipeline/gcp_vertex_gemini_client.dart';
import '../pipeline/gemini_client.dart';
import '../pipeline/layer1_audio.dart';
import '../pipeline/layer2_visual_verifier.dart';
import '../pipeline/layer2_visuals.dart';
import '../pipeline/llm_client.dart';
import '../pipeline/openrouter_client.dart';
import '../models/course.dart';
import 'generation_job.dart';

/// Registre en mémoire des jobs de génération + boucle d'orchestration
/// pure 2-Couches : Layer 1 (Audio / Voix) → Layer 2 (Visuals / Tableau) → validation.
class JobStore {
  static const int _maxAttempts = 3;

  final Map<String, GenerationJob> _jobs = {};
  int _nextId = 1;

  final Layer1AudioGenerator _layer1;
  final Layer2VisualGenerator _layer2;
  final Layer2VisualVerifier _visualVerifier;
  final UserServiceClient _userServiceClient;

  static LlmClient _resolveDefaultClient() {
    final provider = Platform.environment['LLM_PROVIDER']?.toLowerCase();

    if (provider == 'openrouter') {
      return OpenRouterClient();
    }

    final hasGcp = (Platform.environment.containsKey('GCP_PROJECT_ID') ||
            Platform.environment.containsKey('BIGQUERY_PROJECT_ID')) &&
        provider != 'gemini';
    return hasGcp ? GcpVertexGeminiClient() : GeminiClient();
  }

  JobStore({
    LlmClient? llmClient,
    ClaudeClient? claudeClient,
    AudioServiceClient? audioServiceClient,
    UserServiceClient? userServiceClient,
    BoardRenderServiceClient? boardRenderServiceClient,
  })  : _layer1 = Layer1AudioGenerator(
          client: llmClient ?? claudeClient ?? _resolveDefaultClient(),
          audioClient: audioServiceClient,
        ),
        _layer2 = Layer2VisualGenerator(
          client: llmClient ?? claudeClient ?? _resolveDefaultClient(),
        ),
        _visualVerifier = Layer2VisualVerifier(
          client: llmClient ?? claudeClient ?? _resolveDefaultClient(),
          renderClient: boardRenderServiceClient,
        ),
        _userServiceClient = userServiceClient ?? UserServiceClient();

  GenerationJob? get(String jobId) => _jobs[jobId];

  /// [userId]/[authToken] sont renseignés uniquement si `courses_routes.dart`
  /// a pu vérifier un token Bearer valide — sinon le job tourne en mode
  /// invité exactement comme avant (pas de persistance d'historique).
  String startJob(
    String prompt, {
    String? level,
    String? language,
    String? userId,
    String? authToken,
  }) {
    final job = GenerationJob(
      id: 'job_${_nextId++}',
      message: 'Génération de la narration et de l\'audio...',
      userId: userId,
      authToken: authToken,
    );
    _jobs[job.id] = job;
    // Fire-and-forget : le job avance en tâche de fond, le statut est
    // consultable via GET /courses/<jobId>/status.
    _run(job, prompt, level: level, language: language);
    return job.id;
  }

  Future<void> _run(
    GenerationJob job,
    String prompt, {
    String? level,
    String? language,
  }) async {
    try {
      job.status = 'narrating';
      job.message = 'Génération de la narration et de l\'audio...';
      final transcript = await _layer1.generate(
        prompt,
        level: level,
        language: language ?? 'français',
      );

      String? previousAttempt;
      String? previousError;
      String? currentVisualsText;
      int currentIdGap = 100;

      for (var attempt = 1; attempt <= _maxAttempts; attempt++) {
        job.status = attempt == 1 ? 'generating_visuals' : 'correcting_visuals';
        job.message = attempt == 1
            ? 'Génération des appuis visuels...'
            : 'Correction des appuis visuels (tentative $attempt/$_maxAttempts)...';

        final courseId = _calculateCourseId(job.userId, job.id);

        if (currentVisualsText == null) {
          final layer2Result = await _layer2.generate(
            transcript,
            subject: prompt,
            level: level,
            previousAttempt: previousAttempt,
            previousError: previousError,
          );
          currentVisualsText = layer2Result.visualsText;
          currentIdGap = layer2Result.idGap;
        }

        var script = assembleCourseScript(
          courseId: courseId,
          idGap: currentIdGap,
          subject: prompt,
          transcript: transcript,
          visualsText: currentVisualsText!,
        );

        Course? course;
        const maxSyntaxRetries = 3;
        for (var syntaxAttempt = 1; syntaxAttempt <= maxSyntaxRetries; syntaxAttempt++) {
          try {
            course = await HypercourseParser(script).parse();
            break;
          } catch (syntaxError) {
            print('[SYNTAX CORRECTION] Tentative $syntaxAttempt/$maxSyntaxRetries : $syntaxError');
            if (syntaxAttempt == maxSyntaxRetries) {
              rethrow;
            }
            job.status = 'correcting_syntax';
            job.message =
                'Correction de la syntaxe DSL (tentative $syntaxAttempt/$maxSyntaxRetries)...';

            final correctedResult = await _layer2.correctSyntax(
              brokenScript: script,
              syntaxError: syntaxError.toString(),
              transcript: transcript,
              subject: prompt,
              level: level,
            );

            currentVisualsText = correctedResult.visualsText;
            currentIdGap = correctedResult.idGap;
            script = assembleCourseScript(
              courseId: courseId,
              idGap: currentIdGap,
              subject: prompt,
              transcript: transcript,
              visualsText: currentVisualsText,
            );
          }
        }

        try {
          job.status = 'checking_visuals';
          job.message = 'Vérification visuelle du tableau...';
          final verification = await _visualVerifier.verify(course: course!, script: script);

          if (!verification.ok) {
            if (verification.correctedVisualsText != null &&
                verification.correctedVisualsText!.trim().isNotEmpty) {
              currentVisualsText = verification.correctedVisualsText;
              currentIdGap = verification.idGap ?? currentIdGap;
            } else {
              currentVisualsText = null;
            }
            throw Exception(verification.issueDescription ?? 'Anomalie visuelle détectée');
          }

          job.status = 'done';
          job.message = 'Terminé';
          job.script = script;
          job.audioUrl = transcript.audioFile;
          job.duration = transcript.duration;

          if (job.userId != null && job.authToken != null) {
            unawaited(_persistHistory(job, prompt, transcript.subject));
          }
          return;
        } catch (e) {
          if (attempt == _maxAttempts) {
            throw Exception('Échec de génération après $_maxAttempts tentatives : $e');
          }
          previousAttempt = script;
          previousError = e.toString();
        }
      }
    } catch (e) {
      job.status = 'error';
      job.message = e.toString();
      job.error = e.toString();
    }
  }

  /// Persistance best-effort de l'historique auprès de `user-service` :
  /// n'importe quelle erreur (service injoignable, timeout...) est
  /// uniquement journalisée — jamais propagée, jamais de repli du job déjà
  /// marqué `done` (dégradation équivalente au mode invité).
  Future<void> _persistHistory(GenerationJob job, String prompt, String subject) async {
    try {
      await _userServiceClient
          .postHistory(
            token: job.authToken!,
            prompt: prompt,
            subject: subject,
            script: job.script!,
            audioUrl: job.audioUrl!,
            duration: job.duration!,
          )
          .timeout(const Duration(seconds: 5));
    } catch (e) {
      print('user-service injoignable, historique non persisté pour ${job.id}: $e');
    }
  }

  /// Calcule l'ID du cours à partir du userId et du jobId.
  int _calculateCourseId(String? userId, String jobId) {
    if (userId != null && userId.isNotEmpty) {
      return (userId.hashCode.abs() % 900000) + 100000;
    }
    return (jobId.hashCode.abs() % 900000) + 100000;
  }
}

