import 'content_block.dart';

export 'content_block.dart';

/// Interface unifiée pour tous les clients LLM (Gemini, Claude, OpenAI, DeepSeek).
abstract class LlmClient {
  /// Complétion texte simple.
  Future<String> complete({
    required String system,
    required String userMessage,
    int maxTokens = 16384,
  });

  /// Complétion contrainte par un schéma JSON.
  Future<Map<String, dynamic>> completeJson({
    required String system,
    required String userMessage,
    required Map<String, dynamic> schema,
    int maxTokens = 16384,
  });

  /// Complétion multimodale (texte + images) contrainte par un schéma JSON.
  Future<Map<String, dynamic>> completeMultimodalJson({
    required String system,
    required List<ContentBlock> content,
    required Map<String, dynamic> schema,
    int maxTokens = 16384,
  });
}
