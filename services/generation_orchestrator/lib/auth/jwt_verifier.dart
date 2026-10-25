import 'dart:io';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

/// Vérifie localement un token émis par `user-service`, via le même secret
/// partagé `AUTH_JWT_SECRET` — pas besoin d'appeler `user-service` juste
/// pour valider un token à chaque génération de cours.
///
/// Lève une exception sur tout token absent/invalide/expiré ; l'appelant
/// (`courses_routes.dart`) doit traiter ça comme un simple retour au mode
/// invité, jamais comme une erreur bloquante.
class JwtVerifier {
  static String get _secret {
    final secret = Platform.environment['AUTH_JWT_SECRET'];
    if (secret != null && secret.isNotEmpty) {
      return secret;
    }
    return 'illimmi_jwt_secret_dev_2026_super_secure';
  }

  static String verifyAndGetUserId(String token) {
    final jwt = JWT.verify(token, SecretKey(_secret));
    return (jwt.payload as Map)['sub'] as String;
  }
}
