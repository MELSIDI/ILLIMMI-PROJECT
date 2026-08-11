import '../http/board_render_service_client.dart';
import '../models/course.dart';
import 'board_capture_planner.dart';
import 'gemini_client.dart';
import 'llm_client.dart';

class VisualIssue {
  final int? elementId;
  final String description;
  VisualIssue({this.elementId, required this.description});
}

class VisualVerificationResult {
  final bool ok;
  final String? issueDescription;
  const VisualVerificationResult.ok() : ok = true, issueDescription = null;
  const VisualVerificationResult.failed(this.issueDescription) : ok = false;
}

/// Vérification visuelle du tableau : capture le tableau à la fin de chaque scène
/// juste avant un `erase` (voir `board_capture_planner.dart`), et demande à l'IA
/// (Gemini par défaut) de comparer ces captures au script Hypercourse.
class Layer3VisualVerifier {
  final LlmClient _client;
  final BoardRenderServiceClient _renderClient;

  Layer3VisualVerifier({LlmClient? client, BoardRenderServiceClient? renderClient})
    : _client = client ?? GeminiClient(),
      _renderClient = renderClient ?? BoardRenderServiceClient();

  static const String _systemPrompt = '''
Tu es ILLIMMI Layer 3 — vérification visuelle du tableau.
On te montre le script Hypercourse d'un cours ainsi qu'une séquence d'images
représentant l'état du tableau juste avant chaque effacement (`erase`) et à la fin du cours.

Chaque image représente une SCÈNE complète et est accompagnée de :
1. La liste des **Éléments à vérifier / corriger** (IDs des nouveaux éléments introduits dans cette scène).
2. La liste des **Éléments immutables (déjà validés)** (IDs des éléments ayant survécu d'une scène précédente).

RÈGLES STRICTES DE VÉRIFICATION ET CORRECTION :
- Pour chaque image de scène, vérifie la composition spatiale :
  - Aucun texte ni figure ne déborde du cadre du tableau ;
  - Aucun élément ne chevauche un autre élément visible ;
  - Aucun texte n'est écrit par-dessus une figure ;
  - Toute flèche (draw line en mode flèche, ou mouse move) pointe effectivement vers l'élément visé.
- **Règle d'immutabilité** : Tu peux proposer des corrections de position géométrique UNIQUEMENT pour les **Éléments à vérifier / corriger**. Les **Éléments immutables** sont déjà validés et NE DOIVENT PAS être déplacés ou modifiés.

Si tout est correct sur toutes les images, réponds `ok=true` et `issues=[]`.
Sinon, réponds `ok=false` et liste chaque problème dans `issues`, en ciblant l'ID d'un élément mutable et en fournissant une description précise de la correction géométrique requise.
''';

  static final Map<String, dynamic> _schema = {
    'type': 'object',
    'properties': {
      'ok': {'type': 'boolean'},
      'issues': {
        'type': 'array',
        'items': {
          'type': 'object',
          'properties': {
            'elementId': {'type': 'integer'},
            'description': {'type': 'string'},
          },
          'required': ['description'],
        },
      },
    },
    'required': ['ok', 'issues'],
  };

  /// Vérifie tous les lots de capture d'un [course] déjà parsé, en
  /// s'arrêtant au premier lot où un problème est détecté — une tentative
  /// fautive sera de toute façon régénérée intégralement puis re-vérifiée
  /// depuis le début (voir "Décisions" dans world-model-visual-feedback.md).
  Future<VisualVerificationResult> verify({
    required Course course,
    required String script,
  }) async {
    for (final batch in planCaptures(course)) {
      final images = await _renderClient.renderBatch(course, batch);

      final content = <ContentBlock>[
        TextBlock('SCRIPT HYPERCOURSE COMPLET :\n$script'),
      ];

      for (var i = 0; i < batch.points.length; i++) {
        final point = batch.points[i];
        final image = images[i];

        final mutableStr = point.mutableElementIds.isNotEmpty
            ? point.mutableElementIds.join(', ')
            : 'Aucun';
        final immutableStr = point.immutableElementIds.isNotEmpty
            ? point.immutableElementIds.join(', ')
            : 'Aucun';

        content.add(
          TextBlock(
            'Capture de Scène pré-erase à t=${point.time.toStringAsFixed(2)}s :\n'
            '- Éléments à vérifier / corriger (IDs): $mutableStr\n'
            '- Éléments immutables déjà validés (à NE PAS déplacer) (IDs): $immutableStr',
          ),
        );
        content.add(ImageBlock(image.bytes));
      }

      final response = await _client.completeMultimodalJson(
        system: _systemPrompt,
        content: content,
        schema: _schema,
      );

      final ok = response['ok'] as bool? ?? true;
      if (!ok) {
        final issues = (response['issues'] as List? ?? const [])
            .map(
              (i) => VisualIssue(
                elementId: (i as Map<String, dynamic>)['elementId'] as int?,
                description: i['description'] as String,
              ),
            )
            .toList();
        return VisualVerificationResult.failed(_formatIssues(issues));
      }
    }

    return const VisualVerificationResult.ok();
  }

  String _formatIssues(List<VisualIssue> issues) {
    final buffer = StringBuffer(
      'La vérification visuelle du tableau a détecté les problèmes suivants :\n',
    );
    for (final issue in issues) {
      final idPart = issue.elementId != null ? ' (élément ID ${issue.elementId})' : '';
      buffer.writeln('- ${issue.description}$idPart');
    }
    return buffer.toString();
  }
}
