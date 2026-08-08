import 'package:bcrypt/bcrypt.dart';

class PasswordHasher {
  static String hash(String plain) => BCrypt.hashpw(plain, BCrypt.gensalt());

  static bool verify(String plain, String hash) => BCrypt.checkpw(plain, hash);
}
