import 'dart:convert';
import 'dart:typed_data';

/// Bloc de contenu logique (texte ou image), indépendant du fournisseur —
/// chaque client LLM (`ClaudeClient`, `GeminiClient`, `OpenAiClient`,
/// `DeepSeekClient`) le convertit vers son propre format de requête dans
/// `completeMultimodalJson`.
sealed class ContentBlock {
  Map<String, dynamic> toJson();
}

class TextBlock implements ContentBlock {
  final String text;
  TextBlock(this.text);

  @override
  Map<String, dynamic> toJson() => {'type': 'text', 'text': text};
}

class ImageBlock implements ContentBlock {
  final Uint8List bytes;
  final String mediaType;
  ImageBlock(this.bytes, {this.mediaType = 'image/png'});

  @override
  Map<String, dynamic> toJson() => {
    'type': 'image',
    'source': {
      'type': 'base64',
      'media_type': mediaType,
      'data': base64Encode(bytes),
    },
  };
}
