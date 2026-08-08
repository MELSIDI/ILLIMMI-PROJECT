import 'package:sqlite3/sqlite3.dart';

/// Connexion SQLite unique du service (fichier local, pas de serveur DB à
/// installer) — le schéma est créé de façon idempotente au démarrage, pas
/// de framework de migration nécessaire à cette échelle.
class AppDatabase {
  final Database db;

  AppDatabase._(this.db);

  factory AppDatabase.open([String path = 'illimmi_users.db']) {
    final db = sqlite3.open(path);

    db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id TEXT PRIMARY KEY,
        email TEXT UNIQUE NOT NULL,
        password_hash TEXT NOT NULL,
        created_at TEXT NOT NULL
      );
    ''');

    db.execute('''
      CREATE TABLE IF NOT EXISTS course_history (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL REFERENCES users(id),
        prompt TEXT NOT NULL,
        subject TEXT,
        script TEXT NOT NULL,
        audio_url TEXT NOT NULL,
        duration REAL NOT NULL,
        created_at TEXT NOT NULL
      );
    ''');

    db.execute(
      'CREATE INDEX IF NOT EXISTS idx_history_user ON course_history(user_id, created_at DESC);',
    );

    return AppDatabase._(db);
  }

  void close() => db.dispose();
}
