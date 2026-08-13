import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Animation de génération façon Google Gemini :
/// Un orbe lumineux aux couleurs emblématiques de Gemini avec anneau tournant,
/// pulsation fluide et statut d'avancement mis à jour avec élégance.
class GenerationProgressView extends StatefulWidget {
  final String message;

  const GenerationProgressView({super.key, required this.message});

  @override
  State<GenerationProgressView> createState() => _GenerationProgressViewState();
}

class _GenerationProgressViewState extends State<GenerationProgressView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Orbe Lumineux Gemini
            SizedBox(
              width: 140,
              height: 140,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final angle = _controller.value * 2 * math.pi;
                  final pulse = 0.88 + 0.12 * math.sin(angle * 2);

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // Halo lumineux externe
                      Transform.scale(
                        scale: pulse * 1.15,
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppTheme.geminiBlue.withValues(alpha: 0.25),
                                AppTheme.geminiPurple.withValues(alpha: 0.15),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Anneau rotatif dégradé Gemini
                      Transform.rotate(
                        angle: angle,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: SweepGradient(
                              colors: [
                                Colors.transparent,
                                AppTheme.geminiCyan,
                                AppTheme.geminiBlue,
                                AppTheme.geminiPurple,
                                AppTheme.geminiPink,
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Masque central
                      Container(
                        width: 104,
                        height: 104,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
                        ),
                      ),
                      // Icône d'étincelle pulsante avec dégradé
                      Transform.scale(
                        scale: pulse,
                        child: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (b) => AppTheme.geminiSparkleGradient.createShader(b),
                          child: const Icon(Icons.auto_awesome, size: 48),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: Spacing.xl),
            // Message de progression
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: Container(
                key: ValueKey(widget.message),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkSurfaceContainer : AppTheme.lightSurfaceContainer,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.geminiBlue),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Spacing.lg),
            // Barre de progression dégradée
            SizedBox(
              width: 220,
              height: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: const LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.geminiBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
