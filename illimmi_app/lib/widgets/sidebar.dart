import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../api/history_client.dart';
import '../screens/auth_dialog.dart';
import '../state/session_controller.dart';
import '../theme/app_theme.dart';
import 'history_list_tile.dart';

/// Menu flottant façon Claude/ChatGPT : seul le logo "ILLIMMI" est visible en
/// permanence, ancré en haut à gauche par-dessus [MainContentArea] (superposé
/// via un `Stack` dans `AppShell`, pas une colonne qui réserve de la largeur).
/// Un clic sur le logo déroule une carte (bouton "Nouveau cours", liste des
/// cours, pied de session) de haut en bas ; un clic en dehors la referme.
/// Le logo passe à 60% d'opacité dès qu'un cours est actif (généré ou en
/// lecture), signalé par [courseActive], tout en restant cliquable.
class Sidebar extends StatefulWidget {
  final SessionController sessionController;
  final VoidCallback onNewCourse;
  final void Function(HistoryEntry entry) onSelectHistory;
  final ValueListenable<bool> courseActive;

  const Sidebar({
    super.key,
    required this.sessionController,
    required this.onNewCourse,
    required this.onSelectHistory,
    required this.courseActive,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  static const _duration = Duration(milliseconds: 250);

  bool _menuOpen = false;

  void _toggleMenu() => setState(() => _menuOpen = !_menuOpen);

  void _closeMenu() {
    if (_menuOpen) setState(() => _menuOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_menuOpen)
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _closeMenu,
            ),
          ),
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLogoButton(context),
                  Expanded(
                    child: _menuOpen ? _buildMenuCard(context) : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ValueListenableBuilder<bool>(
      valueListenable: widget.courseActive,
      builder: (context, active, child) => AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: active ? 0.6 : 1.0,
        child: child,
      ),
      child: Material(
        color: colorScheme.surfaceContainerLow,
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _toggleMenu,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.md, vertical: Spacing.sm),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, color: colorScheme.primary),
                const SizedBox(width: Spacing.sm),
                Text('ILLIMMI', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(width: Spacing.sm),
                AnimatedRotation(
                  duration: _duration,
                  turns: _menuOpen ? 0.5 : 0,
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(top: Spacing.sm),
      width: Spacing.sidebarWidth,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 16, offset: const Offset(0, 8)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton.tonalIcon(
              onPressed: widget.onNewCourse,
              icon: const Icon(Icons.add),
              label: const Text('Nouveau cours'),
            ),
            const SizedBox(height: Spacing.md),
            Text('Cours', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: Spacing.sm),
            Expanded(child: _buildHistoryList(context)),
            const Divider(height: Spacing.lg),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.sessionController,
      builder: (context, _) {
        if (!widget.sessionController.isLoggedIn) {
          return Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Text(
              'Connecte-toi pour retrouver tes cours ici.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          );
        }
        if (widget.sessionController.history.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Text(
              'Aucun cours généré pour l\'instant.',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          );
        }
        return ListView(
          children: widget.sessionController.history
              .map((entry) => HistoryListTile(entry: entry, onTap: () => widget.onSelectHistory(entry)))
              .toList(),
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.sessionController,
      builder: (context, _) {
        if (widget.sessionController.isLoggedIn) {
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(widget.sessionController.email ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Se déconnecter',
              onPressed: widget.sessionController.logout,
            ),
          );
        }
        return ListTile(
          leading: const Icon(Icons.login),
          title: const Text('Se connecter'),
          onTap: () => _openAuthDialog(context),
        );
      },
    );
  }

  void _openAuthDialog(BuildContext context) => showDialog(
        context: context,
        builder: (_) => AuthDialog(sessionController: widget.sessionController),
      );
}
