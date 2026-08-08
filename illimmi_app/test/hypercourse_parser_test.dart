// Vérifie que le parser supporte le header `audio "<fichier>"` sans corrompre le nom du
// cours, reste correct sur les scripts sans clause `audio`, et que `speech` est désormais
// un simple sous-titre synchronisé (aucune synthèse TTS, timing fourni par l'auteur du
// script conservé tel quel, retrouvable par timestamp comme n'importe quel autre élément).

import 'package:flutter_test/flutter_test.dart';
import 'package:illimmi_app/parsers/hypercourse_parser.dart';

void main() {
  test('parses the new ILLIMMI format (audio header) without corrupting courseName', () async {
    const script = r'''
      course "Les Dérivées" id 1000 idgap 100 for 10s audio "derivees.wav" {
        text id 1 start 1.5s at (88.89, 8) ''[bold]Les Dérivées[/bold]'' ;
      }
    ''';

    final course = await HypercourseParser(script).parse();

    expect(course.name, 'Les Dérivées');
    expect(course.config.audioPath, 'derivees.wav');
    expect(course.globalRegistry.containsKey(1), isTrue);
  });

  test('parses scripts without an audio header (audioPath stays null)', () async {
    const script = r'''
      course "Les Dérivées" id 1000 idgap 100 for 10s {
        text id 1 start 1.5s at (88.89, 8) ''[bold]Les Dérivées[/bold]'' ;
      }
    ''';

    final course = await HypercourseParser(script).parse();

    expect(course.name, 'Les Dérivées');
    expect(course.config.audioPath, isNull);
    expect(course.globalRegistry.containsKey(1), isTrue);
  });

  test('speech is a subtitle: no TTS, no timing shift, queryable like any other element', () async {
    const script = r'''
      course "Les Dérivées" id 1000 idgap 100 for 10s audio "derivees.wav" {
        speech id 201 start 2s for 3s ''Bonjour, aujourd'hui...'' ;
      }
    ''';

    // Si `speech` invoquait encore Piper TTS, ce test dépendrait de `piper.exe` et serait lent ;
    // il doit se terminer quasi instantanément.
    final course = await HypercourseParser(script).parse();

    expect(course.globalRegistry.containsKey(201), isTrue);

    final speech = course.globalRegistry[201]!;
    // Timing conservé tel quel : aucune synthèse audio ne vient le décaler.
    expect(speech.startTime, 2.0);
    expect(speech.duration, 3.0);

    // Retrouvable par timestamp comme un `text`, plus via un registre audio séparé.
    expect(
      course.queryAll(3.0).dynamicElement.any((e) => e.id == 201),
      isTrue,
    );
  });
}
