import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'sql_server_client.dart';

/// Gestionnaire de base de données universel pour `user-service` :
/// - SQLite embarqué local avec mode WAL (Write-Ahead Logging) pour intégrité maximale
/// - Miroir optionnel vers Microsoft SQL Server 2025 (`ILLIMMI_DB`) si disponible
/// - Utilisateur invité garanti ('guest') pour persister tous les cours même sans compte
class AppDatabase {
  final Database db;
  final SqlServerClient sqlServer;
  final String dbPath;

  AppDatabase._(this.db, this.sqlServer, this.dbPath);

  static String resolveDefaultDbPath() {
    final envPath = Platform.environment['DB_PATH'];
    if (envPath != null && envPath.trim().isNotEmpty) {
      return envPath.trim();
    }
    // Si on est dans le dossier services/user_service
    final current = Directory.current.path;
    if (File(p.join(current, 'pubspec.yaml')).existsSync() &&
        File(p.join(current, 'lib', 'db', 'database.dart')).existsSync()) {
      return p.join(current, 'illimmi_users.db');
    }
    // Si on est à la racine du projet
    final nested = p.join(current, 'services', 'user_service', 'illimmi_users.db');
    if (Directory(p.join(current, 'services', 'user_service')).existsSync()) {
      return nested;
    }
    return p.join(current, 'illimmi_users.db');
  }

  factory AppDatabase.open([String? path]) {
    final effectivePath = path ?? resolveDefaultDbPath();
    final parentDir = Directory(p.dirname(effectivePath));
    if (!parentDir.existsSync()) {
      parentDir.createSync(recursive: true);
    }

    final db = sqlite3.open(effectivePath);

    // Optimisations SQLite pour garantir la persistance immédiate et la concurrence
    try {
      db.execute('PRAGMA journal_mode = WAL;');
      db.execute('PRAGMA synchronous = NORMAL;');
      db.execute('PRAGMA foreign_keys = ON;');
    } catch (e) {
      print('Warning PRAGMA SQLite: $e');
    }

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

    // Garantir l'existence d'un compte invité 'guest' pour que TOUT cours généré
    // sans session soit immédiatement persisté sans violation de clé étrangère
    db.execute('''
      INSERT OR IGNORE INTO users (id, email, password_hash, created_at)
      VALUES ('guest', 'guest@illimmi.local', 'guest_auth_bypass', '2026-01-01T00:00:00.000Z');
    ''');

    final sqlServer = SqlServerClient();
    // Initialisation asynchrone non-bloquante du miroir SQL Server
    sqlServer.insertUser(
      id: 'guest',
      email: 'guest@illimmi.local',
      passwordHash: 'guest_auth_bypass',
      createdAt: '2026-01-01T00:00:00.000Z',
    ).catchError((_) {});

    print('Base SQLite initialisée avec succès : $effectivePath');
    return AppDatabase._(db, sqlServer, effectivePath);
  }

  /// Insère un utilisateur dans SQLite et synchronise vers SQL Server
  Future<void> saveUser({
    required String id,
    required String email,
    required String passwordHash,
    required String createdAt,
  }) async {
    db.execute(
      'INSERT INTO users (id, email, password_hash, created_at) VALUES (?, ?, ?, ?)',
      [id, email, passwordHash, createdAt],
    );
    await sqlServer.insertUser(
      id: id,
      email: email,
      passwordHash: passwordHash,
      createdAt: createdAt,
    );
  }

  /// Insère un cours dans l'historique dans SQLite et synchronise vers SQL Server
  Future<void> saveCourseHistory({
    required String id,
    required String userId,
    required String prompt,
    String? subject,
    required String script,
    required String audioUrl,
    required double duration,
    required String createdAt,
  }) async {
    // Si userId est vide ou non spécifié, repli automatique sur 'guest'
    final effectiveUserId = (userId.trim().isEmpty) ? 'guest' : userId.trim();

    // S'assurer que le user existe dans SQLite
    final userCheck = db.select('SELECT id FROM users WHERE id = ?', [effectiveUserId]);
    if (userCheck.isEmpty) {
      db.execute(
        'INSERT OR IGNORE INTO users (id, email, password_hash, created_at) VALUES (?, ?, ?, ?)',
        [effectiveUserId, '$effectiveUserId@illimmi.local', 'auto_created', createdAt],
      );
    }

    db.execute(
      'INSERT INTO course_history (id, user_id, prompt, subject, script, audio_url, duration, created_at) '
      'VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
      [id, effectiveUserId, prompt, subject, script, audioUrl, duration, createdAt],
    );

    // Miroir vers SQL Server
    await sqlServer.insertHistory(
      id: id,
      userId: effectiveUserId,
      prompt: prompt,
      subject: subject,
      script: script,
      audioUrl: audioUrl,
      duration: duration,
      createdAt: createdAt,
    );
  }

  void close() => db.dispose();
}
