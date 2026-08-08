import 'package:flutter/material.dart';

import '../state/session_controller.dart';

/// Dialogue modal (pas un écran plein bloquant) : la connexion est
/// optionnelle, donc un dialogue qui flotte au-dessus d'un contenu déjà
/// utilisable colle mieux que d'imposer un mur de connexion.
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
        await widget.sessionController.signup(_emailController.text.trim(), _passwordController.text);
      } else {
        await widget.sessionController.login(_emailController.text.trim(), _passwordController.text);
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
    return AlertDialog(
      title: Text(_isSignup ? 'Créer un compte' : 'Se connecter'),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('Connexion')),
                ButtonSegment(value: true, label: Text('Inscription')),
              ],
              selected: {_isSignup},
              onSelectionChanged: (s) => setState(() => _isSignup = s.first),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
              onSubmitted: (_) => _submit(),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Continuer sans compte'),
        ),
        FilledButton(
          onPressed: _loading ? null : _submit,
          child: _loading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(_isSignup ? 'Créer le compte' : 'Se connecter'),
        ),
      ],
    );
  }
}
