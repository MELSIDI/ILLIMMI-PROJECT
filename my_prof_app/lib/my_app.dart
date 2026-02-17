import 'parsers/hypercourse_parser.dart';
import 'models/course.dart';

void main() {
  String script = r'''
    course "Mon Cours 1" id 10 idgap 100 for 10s {
      # Contenu du cours
      # ═══════════════════════════════════════
      # SECTION 1 : INTRODUCTION ET TEXTES
      # ═══════════════════════════════════════
      
      # Titre principal avec formatage avancé
      text id 1 start 0.5s for 2s at (88.89, 8) "[bold][color=#2C3E50]Démonstration Complète Hypercourse[/color][/bold]";
    }
  ''';

  HypercourseParser parser = HypercourseParser(script);
  Course course = parser.parse();
  print('Course parsed: ${course.name}, id=${course.config.id}, idGap=${course.config.idGap}, duration=${course.config.duration}s');
}