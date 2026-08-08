import 'package:flutter/material.dart';

import '../state/session_controller.dart';
import '../widgets/main_content_area.dart';
import '../widgets/sidebar.dart';

/// Nouveau point d'entrée visuel de l'app : sidebar façon Claude/ChatGPT à
/// gauche + zone de contenu principale à droite (prompt / animation de
/// génération / lecteur de cours).
class AppShell extends StatefulWidget {
  final SessionController sessionController;

  const AppShell({super.key, required this.sessionController});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final _contentKey = GlobalKey<MainContentAreaState>();
  final _courseActive = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _courseActive.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MainContentArea(
            key: _contentKey,
            sessionController: widget.sessionController,
            courseActive: _courseActive,
          ),
          Positioned.fill(
            child: Sidebar(
              sessionController: widget.sessionController,
              onNewCourse: () => _contentKey.currentState?.newCourse(),
              onSelectHistory: (entry) => _contentKey.currentState?.loadFromHistory(entry),
              courseActive: _courseActive,
            ),
          ),
        ],
      ),
    );
  }
}
