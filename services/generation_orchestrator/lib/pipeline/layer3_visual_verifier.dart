import '../http/board_render_service_client.dart';
import '../models/course.dart';
import 'board_capture_planner.dart';
import 'claude_client.dart';

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

/// Vérification visuelle du tableau : capture le tableau à la fin de
/// l'apparition de chaque élément (voir `board_capture_planner.dart`), et
/// demande à Claude de comparer ces captures au script Hypercourse pour
/// détecter chevauchement, débordement, texte par-dessus une figure, ou
/// flèche mal orientée — ce que la seule vérification syntaxique
/// (`HypercourseParser`) ne peut pas voir.
class Layer3VisualVerifier {
  final ClaudeClient _client;
  final BoardRenderServiceClient _renderClient;

  Layer3VisualVerifier({ClaudeClient? client, BoardRenderServiceClient? renderClient})
    : _client = client ?? ClaudeClient(),
      _renderClient = renderClient ?? BoardRenderServiceClient();

  static const String _systemPrompt = '''
Tu es ILLIMMI Layer 3 — vérification visuelle.
On te montre le script Hypercourse d'un cours ainsi qu'une séquence
d'images du tableau, capturées juste après que chaque élément a fini
d'apparaître. Chaque image est précédée de l'ID (ou des IDs) de l'élément
dont l'achèvement a déclenché cette capture.

Vérifie que la composition du tableau est cohérente sur CHAQUE image :
- aucun texte ni figure ne déborde du cadre du tableau ;
- aucun élément ne chevauche un autre élément encore visible ;
- aucun texte n'est écrit par-dessus une figure ;
- toute flèche (draw line en mode flèche, ou mouse move) pointe
  effectivement vers l'élément qu'elle est censée désigner, pas à côté.

Si tout est correct sur toutes les images, réponds ok=true et issues=[].
Sinon, réponds ok=false et liste chaque problème dans `issues`, avec l'ID
de l'élément fautif et une description précise et actionnable du problème
(ce qui ne va pas et ce qu'il faudrait changer).
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
      for (final image in images) {
        content.add(
          TextBlock(
            'Image — élément(s) déclencheur(s) ID: ${image.triggerElementIds.join(', ')}',
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
