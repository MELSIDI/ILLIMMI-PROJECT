import 'models.dart';

/// Assemble le script Hypercourse final (illimmi-doc.md §2.5) : header avec
/// `audio "<fichier>"` + les commandes générées par le Layer 3. Fonction
/// pure — aucun appel réseau, testable directement.
String assembleCourseScript({
  required CourseMetadata metadata,
  required TranscriptResult transcript,
  required String visualsText,
}) {
  final safeSubject = metadata.subject.replaceAll('"', "'");
  final duration = transcript.duration.toStringAsFixed(1);

  return '''
course "$safeSubject" id 1000 idgap 100 for ${duration}s audio "${transcript.audioFile}" {
$visualsText
}
''';
}
