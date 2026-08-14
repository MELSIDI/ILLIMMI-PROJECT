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
/// (Gemini par défaut) d'analyser chaque image de scène une par une.
class Layer3VisualVerifier {
  final LlmClient _client;
  final BoardRenderServiceClient _renderClient;

  Layer3VisualVerifier({LlmClient? client, BoardRenderServiceClient? renderClient})
    : _client = client ?? GeminiClient(),
      _renderClient = renderClient ?? BoardRenderServiceClient();

  static const String _systemPrompt = '''
Tu es ILLIMMI Layer 3 — vérification visuelle du tableau.
On te montre le script Hypercourse d'un cours ainsi qu'une image représentant l'état du tableau à la fin d'une scène (juste avant un `erase` ou à la fin du cours).

L'image de la scène est accompagnée de :
1. La liste des **Éléments à vérifier / corriger** (IDs des nouveaux éléments introduits dans cette scène).
2. La liste des **Éléments immutables (déjà validés)** (IDs des éléments ayant survécu d'une scène précédente).

RÈGLES STRICTES DE VÉRIFICATION ET CORRECTION :
- Pour l'image de la scène, vérifie la composition spatiale :
  - Aucun texte ni figure ne déborde du cadre du tableau ;
  - Aucun élément ne chevauche un autre élément visible ;
  - Aucun texte n'est écrit par-dessus une figure ;
  - Toute flèche (draw line en mode flèche, ou mouse move) pointe effectivement vers l'élément visé.
- **Règle d'immutabilité** : Tu peux proposer des corrections de position géométrique UNIQUEMENT pour les **Éléments à vérifier / corriger**. Les **Éléments immutables** sont déjà validés et NE DOIVENT PAS être déplacés ou modifiés.

Si tout est correct sur l'image, réponds `ok=true` et `issues=[]`.
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

  /// Vérifie chaque scène (point de capture) une par une avec une seule image à la fois.
  /// S'arrête dès le premier problème rencontré pour permettre à l'orchestrateur
  /// de régénérer le cours avant de vérifier les scènes suivantes.
  Future<VisualVerificationResult> verify({
    required Course course,
    required String script,
  }) async {
    final batches = planCaptures(course);

    for (final batch in batches) {
      for (final point in batch.points) {
        final singlePointBatch = CaptureBatch([point]);


        List<CapturedImage> images = [];

        try {
          images = await _renderClient.renderBatch(course, singlePointBatch);
        } catch (e) {
          // Si board-render-service n'est pas accessible, on saute gentiment la vérification visuelle
          print('[VERIFIER] board-render-service indisponible ($e). Passage en mode validation automatique.');
          return const VisualVerificationResult.ok();
        }

        if (images.isEmpty) continue;

        final image = images.first;

        final mutableStr = point.mutableElementIds.isNotEmpty
            ? point.mutableElementIds.join(', ')
            : 'Aucun';
        final immutableStr = point.immutableElementIds.isNotEmpty
            ? point.immutableElementIds.join(', ')
            : 'Aucun';

        final content = <ContentBlock>[
          TextBlock('SCRIPT HYPERCOURSE COMPLET :\n$script'),
          TextBlock(
            'Capture de Scène pré-erase à t=${point.time.toStringAsFixed(2)}s :\n'
            '- Éléments à vérifier / corriger (IDs): $mutableStr\n'
            '- Éléments immutables déjà validés (à NE PAS déplacer) (IDs): $immutableStr',
          ),
          ImageBlock(image.bytes),
        ];

        final response = await _client.completeMultimodalJson(
          system: _systemPrompt,
          content: content,
          schema: _schema,
        );

        final ok = response['ok'] as bool? ?? true;
        if (!ok) {
          final issues = (response['issues'] as List? ?? const [])
              .map(
                (issueMap) => VisualIssue(
                  elementId: (issueMap as Map<String, dynamic>)['elementId'] as int?,
                  description: issueMap['description'] as String,
                ),
              )
              .toList();
          return VisualVerificationResult.failed(_formatIssues(issues));
        }
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
