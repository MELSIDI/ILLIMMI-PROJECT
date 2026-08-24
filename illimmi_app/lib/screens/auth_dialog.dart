import 'package:flutter/material.dart';

import '../state/session_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/illimmi_logo.dart';

/// Modal d'authentification style Tableau Vert (Chalkboard)
class AuthDialog extends StatefulWidget {
  final SessionController sessionController;

  const AuthDialog({super.key, required this.sessionController});

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  bool _isSignup = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _submit() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      if (_isSignup) {
        await widget.sessionController
            .signup(_emailController.text.trim(), _passwordController.text);
      } else {
        await widget.sessionController
            .login(_emailController.text.trim(), _passwordController.text);
      }
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: const BorderSide(color: Color(0x66FFFFFF), width: 1.2),
      ),
      backgroundColor: const Color(0xFF162D22),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(Spacing.xl),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: const Color(0xFF162D22),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                IllimmiChalkIcon(size: 24),
                const SizedBox(width: 12),
                Text(
                  _isSignup ? 'Créer un compte ILLIMMI' : 'Connexion à ILLIMMI',
                  style: const TextStyle(
                    color: AppTheme.chalkWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.lg),
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('Connexion')),
                ButtonSegment(value: true, label: Text('Inscription')),
              ],
              selected: {_isSignup},
              onSelectionChanged: (s) => setState(() => _isSignup = s.first),
              style: SegmentedButton.styleFrom(
                selectedBackgroundColor: AppTheme.chalkBlue,
                selectedForegroundColor: AppTheme.chalkboardGreenDeep,
                foregroundColor: AppTheme.chalkDust,
                side: const BorderSide(color: Color(0x4DFFFFFF)),
              ),
            ),
            const SizedBox(height: Spacing.lg),
            TextField(
              controller: _emailController,
              style: const TextStyle(color: AppTheme.chalkWhite),
              decoration: const InputDecoration(
                labelText: 'Adresse Email',
                labelStyle: TextStyle(color: AppTheme.chalkDust),
                prefixIcon: Icon(Icons.email_outlined, color: AppTheme.chalkDust),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: Spacing.md),
            TextField(
              controller: _passwordController,
              style: const TextStyle(color: AppTheme.chalkWhite),
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                labelStyle: TextStyle(color: AppTheme.chalkDust),
                prefixIcon: Icon(Icons.lock_outline, color: AppTheme.chalkDust),
              ),
              obscureText: true,
              onSubmitted: (_) => _submit(),
            ),
            if (_error != null) ...[
              const SizedBox(height: Spacing.md),
              Container(
                padding: const EdgeInsets.all(Spacing.sm),
                decoration: BoxDecoration(
                  color: AppTheme.chalkPink.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.chalkPink.withValues(alpha: 0.5)),
                ),
                child: Text(
                  _error!,
                  style: const TextStyle(color: AppTheme.chalkPink, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            const SizedBox(height: Spacing.xl),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Annuler', style: TextStyle(color: AppTheme.chalkDust)),
                ),
                const SizedBox(width: Spacing.sm),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: AppTheme.chalkGradient,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _loading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: _loading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black87),
                          )
                        : Text(
                            _isSignup ? 'S\'inscrire' : 'Se connecter',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

