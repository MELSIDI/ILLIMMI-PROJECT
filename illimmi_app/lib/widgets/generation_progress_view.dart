import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Animation affichée pendant que le cours se génère en tâche de fond
/// (voir `runGenerationInBackground` dans `api/generation_isolate.dart`) :
/// un anneau qui tourne autour d'une icône qui pulse, avec le statut courant
/// qui se met à jour en fondu au fil des étapes (planification, narration,
/// appuis visuels...).
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
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final pulse =
                    0.85 + 0.15 * (0.5 + 0.5 * math.sin(_controller.value * 2 * math.pi));
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: _controller.value * 2 * math.pi,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SweepGradient(
                            colors: [
                              scheme.primary.withValues(alpha: 0),
                              scheme.primary,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    Transform.scale(
                      scale: pulse,
                      child: Icon(Icons.auto_awesome, size: 40, color: scheme.primary),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 28),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: Text(
              widget.message,
              key: ValueKey(widget.message),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(
            width: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child: LinearProgressIndicator(minHeight: 6),
            ),
          ),
        ],
      ),
    );
  }
}
