import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Widget affichant un texte avec le dégradé emblématique de Google Gemini
class GeminiGradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;

  const GeminiGradientText(
    this.text, {
    super.key,
    this.style,
    this.gradient = AppTheme.geminiSparkleGradient,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
