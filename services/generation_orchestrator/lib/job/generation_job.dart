/// État d'un job de génération de cours, exposé via `/courses/<jobId>/status`
/// et `/courses/<jobId>`.
class GenerationJob {
  final String id;
  String status; // planning | narrating | generating_visuals | correcting_visuals | done | error
  String message;
  String? script;
  String? audioUrl;
  double? duration;
  String? error;

  // Non exposés dans toStatusJson()/toResultJson() : usage interne uniquement,
  // pour la persistance best-effort de l'historique une fois le job terminé.
  final String? userId;
  final String? authToken;

  GenerationJob({
    required this.id,
    this.status = 'planning',
    this.message = '',
    this.script,
    this.audioUrl,
    this.duration,
    this.error,
    this.userId,
    this.authToken,
  });

  Map<String, dynamic> toStatusJson() => {
    'jobId': id,
    'status': status,
    'message': message,
  };

  Map<String, dynamic> toResultJson() => {
    'script': script,
    'audioUrl': audioUrl,
    'duration': duration,
  };
}
