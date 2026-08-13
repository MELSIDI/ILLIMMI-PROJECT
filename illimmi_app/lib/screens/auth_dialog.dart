import 'package:flutter/material.dart';

import '../state/session_controller.dart';
import '../theme/app_theme.dart';

/// Modal d'authentification style Google Material 3 Expressive
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(Spacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (b) => AppTheme.geminiSparkleGradient.createShader(b),
                  child: const Icon(Icons.auto_awesome, size: 28),
                ),
                const SizedBox(width: 12),
                Text(
                  _isSignup ? 'Créer un compte ILLIMMI' : 'Connexion à ILLIMMI',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
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
                selectedBackgroundColor: AppTheme.geminiBlue,
                selectedForegroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: Spacing.lg),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Adresse Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: Spacing.md),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Mot de passe',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
              onSubmitted: (_) => _submit(),
            ),
            if (_error != null) ...[
              const SizedBox(height: Spacing.md),
              Container(
                padding: const EdgeInsets.all(Spacing.sm),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 13),
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
                  child: const Text('Annuler'),
                ),
                const SizedBox(width: Spacing.sm),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: AppTheme.geminiGradient,
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
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Text(
                            _isSignup ? 'S\'inscrire' : 'Se connecter',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
