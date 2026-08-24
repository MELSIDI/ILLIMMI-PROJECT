import 'package:flutter/material.dart';

import '../state/session_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/chalkboard_frame.dart';
import '../widgets/main_content_area.dart';
import '../widgets/sidebar.dart';

/// Point d'entrée visuel de l'app ILLIMMI :
/// Encadré dans le tableau vert d'école (ChalkboardFrame) avec sa texture
/// ardoise, cadre bois et craies, intégrant la sidebar escamotable et
/// la zone de contenu principale.
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
      backgroundColor: AppTheme.chalkboardGreenDeep,
      body: ChalkboardFrame(
        child: Stack(
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
      ),
    );
  }
}

