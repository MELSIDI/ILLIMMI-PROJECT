import 'claude_client.dart';
import 'models.dart';

/// Layer 1 : planification pédagogique (illimmi-doc.md §2.2).
///
/// Entrée : le prompt de l'utilisateur ("Explique-moi les dérivées").
/// Sortie : les métadonnées qui guident les Layers suivants.
class Layer1Planner {
  final ClaudeClient _client;

  Layer1Planner({ClaudeClient? client}) : _client = client ?? ClaudeClient();

  static const String _systemPrompt = '''
Tu es ILLIMMI Layer 1, un planificateur pédagogique.
Analyse la demande de l'utilisateur et produis les métadonnées qui guideront
la génération d'un cours interactif : sujet précis, niveau scolaire estimé,
durée cible en secondes (entre 60 et 180 pour un cours court), concepts clés
à couvrir, ton pédagogique, et langue de l'utilisateur (code ISO, ex: "fr").
''';

  static final Map<String, dynamic> _schema = {
    'type': 'object',
    'properties': {
      'subject': {'type': 'string'},
      'level': {'type': 'string'},
      'duration_target': {'type': 'integer'},
      'concepts_cles': {
        'type': 'array',
        'items': {'type': 'string'},
      },
      'ton': {'type': 'string'},
      'langue': {'type': 'string'},
    },
    'required': [
      'subject',
      'level',
      'duration_target',
      'concepts_cles',
      'ton',
      'langue',
    ],
    'additionalProperties': false,
  };

  Future<CourseMetadata> plan(String userPrompt) async {
    final json = await _client.completeJson(
      system: _systemPrompt,
      userMessage: userPrompt,
      schema: _schema,
    );
    return CourseMetadata.fromJson(json);
  }
}
