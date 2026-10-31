import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persiste le token de session entre les lancements de l'app, via le
/// stockage sécurisé de la plateforme (Credential Locker/DPAPI sur
/// Windows) — avec repli en mémoire automatique si le plugin natif
/// n'est pas disponible (ex: tests unitaires ou environnement CI).
class TokenStorage {
  static const _tokenKey = 'auth_token';
  static const _emailKey = 'auth_email';
  static const _roleKey = 'auth_role';

  static final Map<String, String> _memoryFallback = {};
  final FlutterSecureStorage _storage;

  TokenStorage({FlutterSecureStorage? storage}) : _storage = storage ?? const FlutterSecureStorage();

  Future<void> save(String token, String email, [String? role]) async {
    _memoryFallback[_tokenKey] = token;
    _memoryFallback[_emailKey] = email;
    if (role != null) {
      _memoryFallback[_roleKey] = role;
    }
    try {
      await _storage.write(key: _tokenKey, value: token);
      await _storage.write(key: _emailKey, value: email);
      if (role != null) {
        await _storage.write(key: _roleKey, value: role);
      }
    } catch (_) {}
  }

  Future<String?> readToken() async {
    try {
      final val = await _storage.read(key: _tokenKey);
      if (val != null) return val;
    } catch (_) {}
    return _memoryFallback[_tokenKey];
  }

  Future<String?> readEmail() async {
    try {
      final val = await _storage.read(key: _emailKey);
      if (val != null) return val;
    } catch (_) {}
    return _memoryFallback[_emailKey];
  }

  Future<String?> readRole() async {
    try {
      final val = await _storage.read(key: _roleKey);
      if (val != null) return val;
    } catch (_) {}
    return _memoryFallback[_roleKey];
  }

  Future<void> clear() async {
    _memoryFallback.clear();
    try {
      await _storage.delete(key: _tokenKey);
      await _storage.delete(key: _emailKey);
      await _storage.delete(key: _roleKey);
    } catch (_) {}
  }
}
