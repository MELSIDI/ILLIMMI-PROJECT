import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

/// Émission et vérification des tokens de session, signés avec le secret
/// partagé `AUTH_JWT_SECRET` — le même secret est lu par
/// `generation-orchestrator` pour vérifier un token localement, sans
/// dépendre de `user-service` ni d'un store de session partagé.
class JwtService {
  static String get _secret {
    final secret = Platform.environment['AUTH_JWT_SECRET'];
    if (secret == null || secret.isEmpty) {
      throw Exception(
        'AUTH_JWT_SECRET n\'est pas définie. '
        'Exporte-la avant de lancer le service : export AUTH_JWT_SECRET="...".',
      );
    }
    return secret;
  }

  /// Expiration longue (30 jours) : app desktop sans UI de refresh-token —
  /// se déconnecter revient simplement à effacer le token côté client.
  static String issue(String userId, String email) {
    final jwt = JWT({'sub': userId, 'email': email}, issuer: 'illimmi-user-service');
    return jwt.sign(SecretKey(_secret), expiresIn: const Duration(days: 30));
  }

  static String verifyAndGetUserId(String token) {
    final jwt = JWT.verify(token, SecretKey(_secret));
    return (jwt.payload as Map)['sub'] as String;
  }
}
