import 'models.dart';

/// Assemble le script Hypercourse final (illimmi-doc.md §2.5) : header avec
/// `audio "<fichier>"` + les commandes générées par le Layer 3. Fonction
/// pure — aucun appel réseau, testable directement.
String assembleCourseScript({
  required int courseId,
  required int idGap,
  String? subject,
  CourseMetadata? metadata,
  required TranscriptResult transcript,
  required String visualsText,
}) {
  final rawSubject = subject ?? metadata?.subject ?? transcript.subject;
  final safeSubject = rawSubject.replaceAll('"', "'");
  final duration = transcript.duration.toStringAsFixed(1);

  return '''
course "$safeSubject" id $courseId idgap $idGap for ${duration}s audio "${transcript.audioFile}" {
$visualsText
}
''';
}
