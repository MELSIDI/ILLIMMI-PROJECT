import 'package:test/test.dart';
import 'package:generation_orchestrator/pipeline/course_assembler.dart';
import 'package:generation_orchestrator/pipeline/models.dart';

void main() {
  test('assembleCourseScript produces a header with audio + the visuals body', () {
    final metadata = CourseMetadata(
      subject: 'Les Dérivées',
      level: 'Terminale',
      durationTarget: 90,
      conceptsCles: ['limite', 'tangente'],
      ton: 'pédagogique',
      langue: 'fr',
    );
    final transcript = TranscriptResult(
      transcript: 'Bonjour...',
      transcriptTimestamped: [
        WordTimestamp(word: 'Bonjour', start: 0.0, end: 0.5),
      ],
      duration: 87.3,
      // audioFile est désormais une URL servie par audio-service, pas un
      // chemin de fichier local — plus de conversion de séparateurs à faire.
      audioFile: 'http://localhost:8082/audios/derivees/narration.wav',
      language: 'fr',
    );
    const visualsText =
        "text id 1 start 1.5s at (88.89, 8) ''[bold]Les Dérivées[/bold]'' ;";

    final script = assembleCourseScript(
      courseId: 1000,
      idGap: 100,
      metadata: metadata,
      transcript: transcript,
      visualsText: visualsText,
    );

    expect(script, contains('course "Les Dérivées" id 1000 idgap 100'));
    expect(script, contains('for 87.3s'));
    expect(script, contains('audio "http://localhost:8082/audios/derivees/narration.wav"'));
    expect(script, contains(visualsText));
  });

  test('assembleCourseScript strips double quotes from the subject', () {
    final metadata = CourseMetadata(
      subject: 'Le théorème "de Pythagore"',
      level: 'Collège',
      durationTarget: 60,
      conceptsCles: [],
      ton: 'simple',
      langue: 'fr',
    );
    final transcript = TranscriptResult(
      transcript: '...',
      transcriptTimestamped: [],
      duration: 30.0,
      audioFile: 'http://localhost:8082/audios/pythagore/narration.wav',
      language: 'fr',
    );

    final script = assembleCourseScript(
      courseId: 2000,
      idGap: 100,
      metadata: metadata,
      transcript: transcript,
      visualsText: '',
    );


    expect(script, isNot(contains('"de Pythagore"')));
    expect(script, contains("'de Pythagore'"));
  });
}
