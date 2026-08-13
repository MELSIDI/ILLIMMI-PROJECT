import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../api/history_client.dart';
import '../screens/auth_dialog.dart';
import '../state/session_controller.dart';
import '../theme/app_theme.dart';
import 'history_list_tile.dart';

/// Menu latéral escamotable façon Google Gemini Web :
/// Bouton de marque ancré en haut à gauche avec icône étincelle dégradée,
/// déroulant un tiroir élégant contenant le bouton "+ Nouveau cours",
/// l'historique des cours récents et le profil utilisateur.
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

  /// Bouton Logo "ILLIMMI" style Gemini Web avec étincelle dégradée
  Widget _buildLogoButton(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ValueListenableBuilder<bool>(
      valueListenable: widget.courseActive,
      builder: (context, active, child) => AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: active ? 0.7 : 1.0,
        child: child,
      ),
      child: Material(
        color: isDark ? AppTheme.darkSurfaceContainer : AppTheme.lightSurfaceContainer,
        elevation: 0,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: _toggleMenu,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (b) => AppTheme.geminiSparkleGradient.createShader(b),
                  child: const Icon(Icons.auto_awesome, size: 22),
                ),
                const SizedBox(width: 10),
                Text(
                  'ILLIMMI',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                ),
                const SizedBox(width: 8),
                AnimatedRotation(
                  duration: _duration,
                  turns: _menuOpen ? 0.5 : 0,
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Tiroir latéral Gemini avec bouton + Nouveau cours et liste d'historique
  Widget _buildMenuCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(top: Spacing.sm),
      width: Spacing.sidebarWidth,
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.12),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bouton + Nouveau cours style Gemini
            Material(
              color: isDark ? AppTheme.darkSurfaceContainer : AppTheme.lightSurfaceContainer,
              borderRadius: BorderRadius.circular(24),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  _closeMenu();
                  widget.onNewCourse();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Nouveau cours',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: Spacing.lg),
            // Titre section "Cours récents"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
              child: Text(
                'Cours récents',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
              ),
            ),
            const SizedBox(height: Spacing.sm),
            // Liste d'historique
            Expanded(child: _buildHistoryList(context)),
            Divider(
              height: Spacing.lg,
              color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
            ),
            // Profil et session utilisateur
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListenableBuilder(
      listenable: widget.sessionController,
      builder: (context, _) {
        if (!widget.sessionController.isLoggedIn) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.history_toggle_off_rounded,
                    size: 36,
                    color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Connecte-toi pour sauvegarder et retrouver tes cours ici.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        if (widget.sessionController.history.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.md),
              child: Text(
                'Aucun cours généré pour l\'instant.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: widget.sessionController.history
              .map((entry) => HistoryListTile(
                    entry: entry,
                    onTap: () {
                      _closeMenu();
                      widget.onSelectHistory(entry);
                    },
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListenableBuilder(
      listenable: widget.sessionController,
      builder: (context, _) {
        if (widget.sessionController.isLoggedIn) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkSurfaceContainer : AppTheme.lightSurfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                child: Text(
                  (widget.sessionController.email ?? 'U')[0].toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                widget.sessionController.email ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.logout_rounded, size: 20),
                tooltip: 'Se déconnecter',
                onPressed: widget.sessionController.logout,
              ),
            ),
          );
        }
        return ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.login_rounded, color: Theme.of(context).colorScheme.primary, size: 20),
          ),
          title: Text(
            'Se connecter',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          onTap: () => _openAuthDialog(context),
        );
      },
    );
  }

  void _openAuthDialog(BuildContext context) {
    _closeMenu();
    showDialog(
      context: context,
      builder: (_) => AuthDialog(sessionController: widget.sessionController),
    );
  }
}
