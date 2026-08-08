import 'package:flutter/foundation.dart';

import '../api/auth_client.dart';
import '../api/history_client.dart';
import '../storage/token_storage.dart';

/// État de session unique (auth + historique, l'historique dérivant du
/// token) partagé par la sidebar, le dialogue de connexion et la zone de
/// contenu principale. Un simple [ChangeNotifier] suffit à cette échelle
/// (3 consommateurs, tous frères sous `AppShell`) — pas besoin d'un package
/// de state management supplémentaire.
class SessionController extends ChangeNotifier {
  final AuthClient _authClient;
  final HistoryClient _historyClient;
  final TokenStorage _tokenStorage;

  String? token;
  String? email;
  List<HistoryEntry> history = [];

  SessionController({
    AuthClient? authClient,
    HistoryClient? historyClient,
    TokenStorage? tokenStorage,
  }) : _authClient = authClient ?? AuthClient(),
       _historyClient = historyClient ?? HistoryClient(),
       _tokenStorage = tokenStorage ?? TokenStorage();

  bool get isLoggedIn => token != null;

  /// À appeler une fois au démarrage de l'app, avant `runApp`.
  Future<void> restoreSession() async {
    final savedToken = await _tokenStorage.readToken();
    final savedEmail = await _tokenStorage.readEmail();
    if (savedToken == null) return;

    token = savedToken;
    email = savedEmail;
    notifyListeners();
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
    await _tokenStorage.save(result.token, email);
    notifyListeners();
    await refreshHistory();
  }

  Future<void> logout() async {
    token = null;
    email = null;
    history = [];
    await _tokenStorage.clear();
    notifyListeners();
  }

  Future<void> refreshHistory() async {
    final currentToken = token;
    if (currentToken == null) return;
    try {
      history = await _historyClient.getHistory(currentToken);
      notifyListeners();
    } catch (_) {
      // user-service injoignable : l'historique reste tel quel, ce n'est
      // jamais bloquant pour le reste de l'app.
    }
  }
}
