import 'dart:convert';
import 'dart:io';

/// Client SQL Server natif pour Windows utilisant `sqlcmd` avec Windows Authentication.
/// Permet la persistance et la synchronisation des données (utilisateurs, historique, jobs)
/// directement dans Microsoft SQL Server (`ILLIMMI_DB`).
class SqlServerClient {
  final String server;
  final String database;
  bool? _isAvailable;

  SqlServerClient({
    String? server,
    String? database,
  })  : server = server ?? Platform.environment['SQLSERVER_HOST'] ?? 'localhost',
        database = database ?? Platform.environment['SQLSERVER_DATABASE'] ?? 'ILLIMMI_DB';

  /// Vérifie si Microsoft SQL Server est accessible avec Windows Auth (-E) et Trust Cert (-C).
  Future<bool> checkAvailability() async {
    if (_isAvailable != null) return _isAvailable!;
    try {
      final res = await Process.run(
        'sqlcmd',
        ['-S', server, '-d', database, '-E', '-C', '-Q', 'SELECT 1;'],
        runInShell: true,
      );
      _isAvailable = (res.exitCode == 0);
    } catch (_) {
      _isAvailable = false;
    }
    return _isAvailable!;
  }

  /// Échappe les apostrophes pour T-SQL (' -> '')
  static String escape(String value) => value.replaceAll("'", "''");

  /// Exécute une instruction SQL (INSERT, UPDATE, DELETE, DDL).
  Future<bool> execute(String sql) async {
    final available = await checkAvailability();
    if (!available) return false;

    try {
      // Écrire la requête dans un fichier temporaire pour supporter de grands textes
      // (scripts de cours, transcripts) sans limitation de ligne de commande.
      final tempFile = File('${Directory.systemTemp.path}\\sqlcmd_${DateTime.now().microsecondsSinceEpoch}.sql');
      await tempFile.writeAsString(sql, encoding: utf8);

      final result = await Process.run(
        'sqlcmd',
        ['-S', server, '-d', database, '-E', '-C', '-i', tempFile.path, '-b'],
        runInShell: true,
      );

      try {
        if (await tempFile.exists()) {
          await tempFile.delete();
        }
      } catch (_) {}

      if (result.exitCode != 0) {
        print('SqlServerClient execute warning: ${result.stderr} / ${result.stdout}');
        return false;
      }
      return true;
    } catch (e) {
      print('SqlServerClient execute error: $e');
      return false;
    }
  }

  /// Exécute une requête SELECT avec `FOR JSON PATH` et parse le JSON retourné.
  Future<List<Map<String, dynamic>>?> queryJson(String selectSql) async {
    final available = await checkAvailability();
    if (!available) return null;

    try {
      final query = 'SET NOCOUNT ON; $selectSql FOR JSON PATH;';
      final tempFile = File('${Directory.systemTemp.path}\\sqlcmd_query_${DateTime.now().microsecondsSinceEpoch}.sql');
      await tempFile.writeAsString(query, encoding: utf8);

      final result = await Process.run(
        'sqlcmd',
        ['-S', server, '-d', database, '-E', '-C', '-i', tempFile.path, '-y', '0', '-h', '-1'],
        runInShell: true,
      );

      try {
        if (await tempFile.exists()) {
          await tempFile.delete();
        }
      } catch (_) {}

      if (result.exitCode != 0) return null;

      final output = (result.stdout as String).trim();
      if (output.isEmpty || output == 'NULL') return [];

      final decoded = jsonDecode(output);
      if (decoded is List) {
        return decoded.cast<Map<String, dynamic>>();
      }
      return null;
    } catch (e) {
      print('SqlServerClient queryJson error: $e');
      return null;
    }
  }

  /// Insère un utilisateur dans SQL Server
  Future<void> insertUser({
    required String id,
    required String email,
    required String passwordHash,
    required String createdAt,
  }) async {
    final sql = '''
      IF NOT EXISTS (SELECT 1 FROM users WHERE id = '${escape(id)}')
      BEGIN
        INSERT INTO users (id, email, password_hash, created_at)
        VALUES ('${escape(id)}', '${escape(email)}', '${escape(passwordHash)}', '${escape(createdAt)}');
      END;
    ''';
    await execute(sql);
  }

  /// Insère une entrée d'historique dans SQL Server
  Future<void> insertHistory({
    required String id,
    required String userId,
    required String prompt,
    String? subject,
    required String script,
    required String audioUrl,
    required double duration,
    required String createdAt,
  }) async {
    final sub = subject != null ? "'${escape(subject)}'" : 'NULL';
    final sql = '''
      IF NOT EXISTS (SELECT 1 FROM course_history WHERE id = '${escape(id)}')
      BEGIN
        INSERT INTO course_history (id, user_id, prompt, subject, script, audio_url, duration, created_at)
        VALUES (
          '${escape(id)}',
          '${escape(userId)}',
          N'${escape(prompt)}',
          ${sub != 'NULL' ? "N$sub" : 'NULL'},
          N'${escape(script)}',
          '${escape(audioUrl)}',
          $duration,
          '${escape(createdAt)}'
        );
      END;
    ''';
    await execute(sql);
  }
}
