import 'gemini_client.dart';
import 'llm_client.dart';
import 'models.dart';
import 'prompt_loader.dart';

/// Layer 1 : planification pédagogique (illimmi-doc.md §2.2).
///
/// Entrée : le prompt de l'utilisateur ("Explique-moi les dérivées").
/// Sortie : les métadonnées qui guident les Layers suivants — y compris
/// un plan pédagogique section par section avec suggestion de support
/// visuel, pour forcer Layer3 à exploiter tout le DSL Hypercourse.
class Layer1Planner {
  final LlmClient _client;

  Layer1Planner({LlmClient? client}) : _client = client ?? GeminiClient();

  static String get systemPrompt => PromptLoader.load('layer1_planner_system.md');

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
      'plan_pedagogique': {
        'type': 'array',
        'items': {
          'type': 'object',
          'properties': {
            'section': {
              'type': 'string',
              'enum': [
                'accroche',
                'prerequis',
                'exemple_concret',
                'definition_formelle',
                'decomposition',
                'erreur_frequente',
                'synthese',
              ],
            },
            'objectif': {'type': 'string'},
            'contenu_attendu': {'type': 'string'},
            'support_visuel_suggere': {'type': 'string'},
          },
          'required': [
            'section',
            'objectif',
            'contenu_attendu',
            'support_visuel_suggere',
          ],
          'additionalProperties': false,
        },
      },
    },
    'required': [
      'subject',
      'level',
      'duration_target',
      'concepts_cles',
      'ton',
      'langue',
      'plan_pedagogique',
    ],
    'additionalProperties': false,
  };

  Future<CourseMetadata> plan(String userPrompt) async {
    final json = await _client.completeJson(
      system: systemPrompt,
      userMessage: userPrompt,
      schema: _schema,
      maxTokens: 16384,
    );
    return CourseMetadata.fromJson(json);
  }
}

