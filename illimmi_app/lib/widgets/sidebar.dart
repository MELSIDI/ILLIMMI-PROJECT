import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../api/history_client.dart';
import '../screens/auth_dialog.dart';
import '../state/session_controller.dart';
import '../theme/app_theme.dart';
import 'history_list_tile.dart';
import 'illimmi_logo.dart';

/// Menu latéral escamotable style Tableau Vert (Chalkboard) :
/// Bouton de marque ancré en haut à gauche avec logo en craie blanche,
/// déroulant un tiroir ardoise élégant avec le bouton "+ Nouveau cours",
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
                  _buildTopNavigationGroup(context),
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

  /// Groupe de navigation supérieur :
  /// - En mode cours actif : Bouton [← Retour] et Bouton [ILLIMMI ⌄] disposés élégamment côte à côte
  /// - En mode accueil : Bouton [ILLIMMI ⌄] seul
  Widget _buildTopNavigationGroup(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.courseActive,
      builder: (context, active, _) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: active ? 0.9 : 1.0,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (active) ...[
                _buildBackButton(context),
                const SizedBox(width: 8),
              ],
              _buildLogoButton(context),
            ],
          ),
        );
      },
    );
  }

  /// Bouton [← Retour] style ardoise/craie pour quitter le cours sans superposition
  Widget _buildBackButton(BuildContext context) {
    return Tooltip(
      message: 'Quitter le cours et retourner à l\'accueil',
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            _closeMenu();
            widget.onNewCourse();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.38),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_rounded,
                  color: AppTheme.chalkWhite,
                  size: 18,
                ),
                SizedBox(width: 6),
                Text(
                  'Retour',
                  style: TextStyle(
                    color: AppTheme.chalkWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Bouton Logo "ILLIMMI" style pilule ardoise avec icône de craie et menu déroulant
  Widget _buildLogoButton(BuildContext context) {
    return Tooltip(
      message: 'Historique des cours et menu',
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: _toggleMenu,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.38),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IllimmiChalkIcon(size: 18),
                const SizedBox(width: 10),
                const Text(
                  'ILLIMMI',
                  style: TextStyle(
                    color: AppTheme.chalkWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedRotation(
                  duration: _duration,
                  turns: _menuOpen ? 0.5 : 0,
                  child: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppTheme.chalkDust,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Tiroir latéral en ardoise avec logo, bouton + Nouveau cours et liste d'historique
  Widget _buildMenuCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: Spacing.sm),
      width: Spacing.sidebarWidth,
      decoration: BoxDecoration(
        color: const Color(0xFF142B20).withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.38),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
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
            // En-tête du menu avec Logo Craie
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: IllimmiChalkLogo(
                  height: 38,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(height: Spacing.md),
            // Bouton + Nouveau cours
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(24),
              child: InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  _closeMenu();
                  widget.onNewCourse();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.35),
                      width: 1,
                    ),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.add_rounded,
                        color: AppTheme.chalkBlue,
                        size: 20,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Nouveau cours',
                        style: TextStyle(
                          color: AppTheme.chalkWhite,
                          fontSize: 14,
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: Spacing.xs),
              child: Text(
                'Cours récents',
                style: TextStyle(
                  color: AppTheme.chalkDust,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 0.2,
                ),
              ),
            ),
            const SizedBox(height: Spacing.sm),
            // Liste d'historique
            Expanded(child: _buildHistoryList(context)),
            Divider(
              height: Spacing.lg,
              color: Colors.white.withValues(alpha: 0.15),
            ),
            // Profil et session utilisateur
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
        final history = widget.sessionController.history;
        if (history.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.md),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.auto_stories_outlined,
                    size: 32,
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Aucun cours sauvegardé pour l\'instant.\nGénère un cours pour le retrouver ici !',
                    style: TextStyle(
                      color: AppTheme.chalkDustMuted,
                      fontSize: 12,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: history
              .map((entry) => HistoryListTile(
                    entry: entry,
                    onTap: () {
                      _closeMenu();
                      widget.onSelectHistory(entry);
                    },
                    onDelete: () => widget.sessionController.deleteHistoryEntry(entry.id),
                  ))
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
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              leading: CircleAvatar(
                backgroundColor: AppTheme.chalkBlue.withValues(alpha: 0.25),
                child: Text(
                  (widget.sessionController.email ?? 'U')[0].toUpperCase(),
                  style: const TextStyle(
                    color: AppTheme.chalkBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                widget.sessionController.email ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppTheme.chalkWhite,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.logout_rounded, size: 18, color: AppTheme.chalkDust),
                tooltip: 'Se déconnecter',
                onPressed: widget.sessionController.logout,
              ),
            ),
          );
        }
        return ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.white.withValues(alpha: 0.25)),
          ),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.chalkBlue.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.login_rounded, color: AppTheme.chalkBlue, size: 18),
          ),
          title: const Text(
            'Se connecter',
            style: TextStyle(
              color: AppTheme.chalkWhite,
              fontSize: 14,
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

