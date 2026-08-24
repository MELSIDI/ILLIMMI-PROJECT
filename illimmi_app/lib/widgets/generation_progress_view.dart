import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'illimmi_logo.dart';

/// Animation de génération style Tableau Vert (Chalkboard) :
/// Un orbe lumineux aux couleurs pastel de craie avec anneau tournant,
/// pulsation fluide et statut d'avancement mis à jour avec élégance.
class GenerationProgressView extends StatefulWidget {
  final double progress;
  final String statusText;
  final VoidCallback? onCancel;

  const GenerationProgressView({
    super.key,
    this.progress = 0.0,
    String? statusText,
    String? message,
    this.onCancel,
  }) : statusText = statusText ?? message ?? 'Génération en cours...';

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
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Orbe lumineux central en craie
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
                                AppTheme.chalkBlue.withValues(alpha: 0.25),
                                AppTheme.chalkPurple.withValues(alpha: 0.15),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Anneau rotatif dégradé craie
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
                                AppTheme.chalkCyan,
                                AppTheme.chalkBlue,
                                AppTheme.chalkPurple,
                                AppTheme.chalkPink,
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
                          color: Colors.black.withValues(alpha: 0.4),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                      ),
                      // Logo Craie ILLIMMI au centre
                      Transform.scale(
                        scale: pulse,
                        child: IllimmiChalkLogo(
                          height: 34,
                          borderRadius: BorderRadius.circular(6),
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
                key: ValueKey(widget.statusText),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.38),
                    width: 1.2,
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
                        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.chalkBlue),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.statusText,
                      style: const TextStyle(
                        color: AppTheme.chalkWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
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
                child: LinearProgressIndicator(
                  value: widget.progress > 0 ? widget.progress : null,
                  backgroundColor: Colors.white.withValues(alpha: 0.15),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.chalkBlue),
                ),
              ),
            ),
            if (widget.onCancel != null) ...[
              const SizedBox(height: Spacing.md),
              TextButton(
                onPressed: widget.onCancel,
                child: const Text('Annuler', style: TextStyle(color: AppTheme.chalkDust)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

