import 'package:flutter/foundation.dart';

import '../api/auth_client.dart';
import '../api/history_client.dart';
import '../storage/token_storage.dart';

/// État de session unique (auth + historique) partagé par la sidebar,
/// le dialogue de connexion et la zone de contenu principale.
/// L'historique des cours est préservé et visible à la fois en mode connecté
/// et en mode invité.
class SessionController extends ChangeNotifier {
  final AuthClient _authClient;
  final HistoryClient _historyClient;
  final TokenStorage _tokenStorage;

  String? token;
  String? email;
  String? role;
  List<HistoryEntry> history = [];

  SessionController({
    AuthClient? authClient,
    HistoryClient? historyClient,
    TokenStorage? tokenStorage,
  }) : _authClient = authClient ?? AuthClient(),
       _historyClient = historyClient ?? HistoryClient(),
       _tokenStorage = tokenStorage ?? TokenStorage();

  bool get isLoggedIn => token != null;

  /// Vérifie si l'utilisateur actuel a les droits Développeur ou Ingénieur IA
  bool get isDev =>
      role == 'ai_engineer' ||
      role == 'dev' ||
      (email != null &&
          (email!.endsWith('@illimmi.ai') ||
              email!.endsWith('@illimmi.dev') ||
              email!.startsWith('dev@') ||
              email!.startsWith('ai.engineer@')));

  /// Initialise la session et charge l'historique des cours sauvegardés.
  Future<void> restoreSession() async {
    final savedToken = await _tokenStorage.readToken();
    final savedEmail = await _tokenStorage.readEmail();
    final savedRole = await _tokenStorage.readRole();
    if (savedToken != null) {
      token = savedToken;
      email = savedEmail;
      role = savedRole;
      notifyListeners();
    }
    // Chargement de l'historique dans tous les cas (mode connecté ou invité)
    await refreshHistory();
  }

  Future<void> signup(String email, String password) async {
    final result = await _authClient.signup(email, password);
    await _onAuthSuccess(result, email);
  }

  Future<void> login(String email, String password) async {
    final result = await _authClient.login(email, password);
    await _onAuthSuccess(result, email);
  }

  Future<void> _onAuthSuccess(AuthResult result, String email) async {
    token = result.token;
    this.email = email;
    role = result.role;
    await _tokenStorage.save(result.token, email, result.role);
    notifyListeners();
    await refreshHistory();
  }

  Future<void> logout() async {
    token = null;
    email = null;
    role = null;
    await _tokenStorage.clear();
    await refreshHistory();
    notifyListeners();
  }

  /// Connexion rapide ou bascule locale vers le rôle Développeur / Ingénieur IA
  Future<void> loginAsDev({
    String email = 'ai.engineer@illimmi.ai',
    String password = 'illimmi-dev-2026',
  }) async {
    try {
      final result = await _authClient.login(email, password);
      await _onAuthSuccess(result, email);
    } catch (_) {
      // Mode secours direct (ex: backend non démarré en environnement dev local)
      token = 'local_ai_engineer_session_token';
      this.email = email;
      role = 'ai_engineer';
      await _tokenStorage.save(token!, email, role);
      notifyListeners();
      await refreshHistory();
    }
  }

  /// Rafraîchit l'historique depuis la base de données.
  Future<void> refreshHistory() async {
    try {
      history = await _historyClient.getHistory(token);
      notifyListeners();
    } catch (e) {
      // user-service temporairement injoignable, l'historique existant reste affiché
    }
  }

  /// Supprime un cours de l'historique
  Future<void> deleteHistoryEntry(String id) async {
    try {
      await _historyClient.deleteHistory(id, token);
      history.removeWhere((e) => e.id == id);
      notifyListeners();
    } catch (_) {}
  }
}
