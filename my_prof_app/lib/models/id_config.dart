class IdConfig {
  final int idGap;
  final List<String> familyNames;

  IdConfig({
    this.idGap = 100000, 
    this.familyNames = const ['text', 'draw', 'speech', 'mouse', 'erase'],
  });

  /// Calcule l'index de la famille à partir de l'ID
  int getFamilyIndex(int id) {
    if (id < 0) throw ArgumentError("ID cannot be negative");
    if (id == 0) return 0;
    int idCalculate =  (id - 1) ~/ idGap;
    if (idCalculate >= familyNames.length) {
      throw ArgumentError("ID $id exceeds the maximum allowed ID for configured families");
    }
    return idCalculate;
  }

  /// Récupère le nom de la famille (pour le debug ou le routage)
  String getFamilyName(int id) {
    int index = getFamilyIndex(id);
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

  /// Recupère la plage ici le max pour une famille donnée par son nom
  int getMaxIdByFamily(String familyName) {
    int index = familyNames.indexOf(familyName);
    if (index == -1) throw ArgumentError("Family $familyName not found");
    return maxId(index);
  }
}