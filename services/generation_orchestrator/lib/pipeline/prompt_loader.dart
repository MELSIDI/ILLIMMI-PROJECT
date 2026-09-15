import 'dart:io';

/// Chargeur dynamique des prompts pour l'orchestrateur de génération.
/// Permet de modifier les prompts dans le dossier `prompts/` sans modifier le code Dart.
class PromptLoader {
  static final Map<String, String> _cache = {};

  /// Recherche le chemin absolu du dossier `prompts/`.
  static Directory get promptsDirectory {
    final envDir = Platform.environment['PROMPTS_DIR'];
    if (envDir != null && envDir.isNotEmpty) {
      final dir = Directory(envDir);
      if (dir.existsSync()) return dir;
    }

    // 1. Depuis le répertoire courant d'exécution
    final candidates = [
      Directory('prompts'),
      Directory('services/generation_orchestrator/prompts'),
      Directory('${Directory.current.path}/prompts'),
      Directory('${Directory.current.path}/services/generation_orchestrator/prompts'),
    ];

    // 2. Relativement à l'exécutable/script en cours
    try {
      final scriptPath = Platform.script.toFilePath();
      final scriptDir = File(scriptPath).parent;
      candidates.add(Directory('${scriptDir.path}/../../prompts'));
      candidates.add(Directory('${scriptDir.path}/../prompts'));
    } catch (_) {}

    for (final candidate in candidates) {
      if (candidate.existsSync()) {
        return candidate;
      }
    }

    return Directory('prompts');
  }

  /// Charge le contenu d'un prompt par son nom de fichier (ex: `layer1_planner_system.md`).
  /// Remplace optionnellement les balises `{{variable}}` par leur valeur.
  static String load(String fileName, {Map<String, String>? variables, bool useCache = false}) {
    String? content;

    if (useCache && _cache.containsKey(fileName)) {
      content = _cache[fileName]!;
    } else {
      final dir = promptsDirectory;
      final file = File('${dir.path}/$fileName');
      if (file.existsSync()) {
        content = file.readAsStringSync();
        if (useCache) {
          _cache[fileName] = content;
        }
      }
    }

    if (content == null || content.trim().isEmpty) {
      throw FileSystemException(
        'Impossible de charger le fichier prompt: $fileName dans ${promptsDirectory.path}',
        fileName,
      );
    }

    if (variables != null && variables.isNotEmpty) {
      for (final entry in variables.entries) {
        content = content!.replaceAll('{{${entry.key}}}', entry.value);
      }
    }

    return content!;
  }

  /// Vide le cache en mémoire (utile en développement ou lors de rechargements).
  static void clearCache() {
    _cache.clear();
  }
}
