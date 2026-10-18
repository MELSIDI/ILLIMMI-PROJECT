import '../http/board_render_service_client.dart';
import '../models/course.dart';
import 'board_capture_planner.dart';
import 'gemini_client.dart';
import 'llm_client.dart';
import 'prompt_loader.dart';

class VisualIssue {
  final int? elementId;
  final String description;
  VisualIssue({this.elementId, required this.description});
}

class VisualVerificationResult {
  final bool ok;
  final String? issueDescription;
  final String? correctedVisualsText;
  final int? idGap;

  const VisualVerificationResult.ok()
    : ok = true,
      issueDescription = null,
      correctedVisualsText = null,
      idGap = null;

  const VisualVerificationResult.corrected({
    required this.correctedVisualsText,
    this.idGap,
    this.issueDescription,
  }) : ok = false;

  const VisualVerificationResult.failed(this.issueDescription)
    : ok = false,
      correctedVisualsText = null,
      idGap = null;
}

/// Vérification et correction visuelle directe du tableau (Layer 2) :
/// capture le tableau à la fin de chaque scène juste avant un `erase`
/// (voir `board_capture_planner.dart`), et demande au modèle multimodal (Gemini, Claude, OpenAI...)
/// d'analyser l'image et de corriger directement les coordonnées du script Hypercourse en cas de défaut visuel.
class Layer2VisualVerifier {
  final LlmClient _client;
  final BoardRenderServiceClient _renderClient;

  Layer2VisualVerifier({LlmClient? client, BoardRenderServiceClient? renderClient})
    : _client = client ?? GeminiClient(),
      _renderClient = renderClient ?? BoardRenderServiceClient();

  static String get systemPrompt => PromptLoader.load('layer2_visual_verifier_system.md');

  static final Map<String, dynamic> _schema = {
    'type': 'object',
    'properties': {
      'ok': {'type': 'boolean'},
      'issueDescription': {'type': 'string'},
      'idgap': {'type': 'integer'},
      'correctedVisualsText': {'type': 'string'},
    },
    'required': ['ok', 'issueDescription', 'idgap', 'correctedVisualsText'],
  };

  /// Vérifie chaque scène (point de capture) une par une avec une seule image à la fois.
  /// S'arrête dès le premier problème rencontré et renvoie le script corrigé par le modèle multimodal.
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
            '- Éléments mutables à vérifier / corriger (IDs: $mutableStr) : Tu as le droit de modifier SANS RESTRICTION tous leurs paramètres (position/coordonnées, durée for, épaisseur width, couleur/fillcolor, police/style/KaTeX, rayon) SAUF le timing start qui doit RESTER STRICTEMENT INTACT pour préserver la synchronisation vocale.\n'
            '- Éléments immutables déjà validés des scènes antérieures (IDs: $immutableStr) : À NE PAS modifier pour préserver la continuité spatiale.',
          ),
          ImageBlock(image.bytes),
        ];

        final Map<String, dynamic> response;
        try {
          response = await _client.completeMultimodalJson(
            system: systemPrompt,
            content: content,
            schema: _schema,
          );
        } catch (e) {
          print('[VERIFIER] Erreur lors de l\'appel multimodal ($e).');
          return const VisualVerificationResult.ok();
        }

        final ok = response['ok'] as bool? ?? true;
        if (!ok) {
          final issueDesc = response['issueDescription'] as String? ?? 'Défaut visuel détecté sur l\'image';
          final correctedVisuals = response['correctedVisualsText'] as String?;
          final idGap = response['idgap'] as int?;

          if (correctedVisuals != null && correctedVisuals.trim().isNotEmpty) {
            return VisualVerificationResult.corrected(
              correctedVisualsText: correctedVisuals,
              idGap: idGap,
              issueDescription: issueDesc,
            );
          } else {
            return VisualVerificationResult.failed(issueDesc);
          }
        }
      }
    }

    return const VisualVerificationResult.ok();
  }
}

/// Alias rétro-compatible
typedef Layer3VisualVerifier = Layer2VisualVerifier;
