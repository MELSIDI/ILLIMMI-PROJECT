class IdConfig {
  final int id;
  final int idGap;
  double duration;
  final List<String> familyNames;

  /// Chemin (ou URL) du fichier audio externe du cours (nouveau format ILLIMMI).
  /// `null` pour les cours legacy qui synthétisent l'audio via des commandes `speech`.
  final String? audioPath;

  IdConfig({
    this.id = 1,
    this.idGap = 100000,
    this.duration = 600, // 10 minutes par défaut
    this.familyNames = const ['text', 'draw', 'speech', 'mouse', 'erase'],
    this.audioPath,
  });

  /// Calcule l'index de la famille à partir de l'ID
  int getFamilyIndex(int idelement) {
    if (idelement < 0) throw ArgumentError("ID cannot be negative");
    if (idelement == 0) return 0;
    int idCalculate = (idelement - 1) ~/ idGap;
    if (idCalculate >= familyNames.length) {
      throw ArgumentError(
        "ID $idelement exceeds the maximum allowed ID for configured families",
      );
    }
    return idCalculate;
  }

  /// Récupère le nom de la famille (pour le debug ou le routage)
  String getFamilyName(int idelement) {
    int index = getFamilyIndex(idelement);
    return familyNames[index];
  }

  /// Calcule la plage pour une famille donnée
  int minId(int familyIndex) => (familyIndex * idGap) + 1;
  int maxId(int familyIndex) => (familyIndex + 1) * idGap;

  /// Récupère la plage ici le min pour une famille donnée par son nom
  int getMinIdByFamily(String familyName) {
    int index = familyNames.indexOf(familyName);
    if (index == -1) throw ArgumentError("Family $familyName not found");
    return minId(index);
  }

  int getFamilyIndexByName(String familyName) {
    int index = familyNames.indexOf(familyName);
    if (index == -1) throw ArgumentError("Family $familyName not found");
    return index;
  }

  /// Recupère la plage ici le max pour une famille donnée par son nom
  int getMaxIdByFamily(String familyName) {
    int index = familyNames.indexOf(familyName);
    if (index == -1) throw ArgumentError("Family $familyName not found");
    return maxId(index);
  }
}
