import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persiste le token de session entre les lancements de l'app, via le
/// stockage sécurisé de la plateforme (Credential Locker/DPAPI sur
/// Windows) — le token est un vrai credential Bearer valable 30 jours.
class TokenStorage {
  static const _tokenKey = 'auth_token';
  static const _emailKey = 'auth_email';
  final FlutterSecureStorage _storage;

  TokenStorage({FlutterSecureStorage? storage}) : _storage = storage ?? const FlutterSecureStorage();

  Future<void> save(String token, String email) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _emailKey, value: email);
  }

  Future<String?> readToken() => _storage.read(key: _tokenKey);

  Future<String?> readEmail() => _storage.read(key: _emailKey);

  Future<void> clear() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _emailKey);
  }
}
