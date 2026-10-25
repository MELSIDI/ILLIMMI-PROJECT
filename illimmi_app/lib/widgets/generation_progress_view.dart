import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'thinking_orb.dart';

/// Vue de chargement et de progression de génération ILLIMMI
/// utilisant le moteur 3D pointillé "Thinking Orb" (Jakub Antalik / MIT).
///
/// L'orbe adapte son état géométrique (Orbits, Wave, Ribbon, Rubik, Globe)
/// dynamiquement selon l'étape courante de génération (Voix, Visuels, etc.).
class GenerationProgressView extends StatelessWidget {
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

  /// Déduit l'état d'animation 3D de l'orbe selon la sémantique de l'étape courante
  ThinkingOrbState _resolveOrbState(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('audio') ||
        lower.contains('voix') ||
        lower.contains('narration') ||
        lower.contains('parole') ||
        lower.contains('écoute')) {
      // Waveform 3D ondulant à travers les anneaux
      return ThinkingOrbState.listening;
    }
    if (lower.contains('visuel') ||
        lower.contains('tableau') ||
        lower.contains('scène') ||
        lower.contains('dessin')) {
      // Écharpe multi-bandes fluide et ondulante
      return ThinkingOrbState.composing;
    }
    if (lower.contains('vérif') ||
        lower.contains('correct') ||
        lower.contains('world model') ||
        lower.contains('résol')) {
      // Bandes cubiques dynamiques qui se résolvent
      return ThinkingOrbState.solving;
    }
    if (lower.contains('planif') ||
        lower.contains('recherche') ||
        lower.contains('prépar')) {
      // Globe avec balayage méridien
      return ThinkingOrbState.searching;
    }
    if (lower.contains('connect') ||
        lower.contains('assembl') ||
        lower.contains('orchestr')) {
      // Constellation de nœuds et paquets
      return ThinkingOrbState.connecting;
    }
    // Par défaut : particules rapides en révolution sur orbites inclinées
    return ThinkingOrbState.working;
  }

  @override
  Widget build(BuildContext context) {
    final orbState = _resolveOrbState(statusText);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Orbe 3D principal Thinking Orb (Taille d'avatar / Hero : 140px)
            SizedBox(
              width: 150,
              height: 150,
              child: Center(
                child: ThinkingOrb(
                  state: orbState,
                  size: 140,
                  speed: 1.0,
                  colorStyle: OrbColorStyle.chalk,
                ),
              ),
            ),
            const SizedBox(height: Spacing.xl),

            // Pilule d'état avec Thinking Orb miniature inline (20px)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Container(
                key: ValueKey(statusText),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.28),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Mini Thinking Orb inline remplaçant le spinner classique
                    ThinkingOrb(
                      state: orbState,
                      size: 20,
                      speed: 1.35,
                      colorStyle: OrbColorStyle.chalk,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      statusText,
                      style: const TextStyle(
                        color: AppTheme.chalkWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Spacing.lg),

            // Barre de progression dégradée craie cyan
            SizedBox(
              width: 220,
              height: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress > 0 ? progress : null,
                  backgroundColor: Colors.white.withValues(alpha: 0.12),
                  valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.chalkCyan),
                ),
              ),
            ),

            if (onCancel != null) ...[
              const SizedBox(height: Spacing.md),
              TextButton(
                onPressed: onCancel,
                child: const Text(
                  'Annuler',
                  style: TextStyle(color: AppTheme.chalkDust),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
