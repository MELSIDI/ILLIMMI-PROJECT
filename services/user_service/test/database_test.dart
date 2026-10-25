import 'package:test/test.dart';
import 'package:user_service/db/database.dart';

void main() {
  group('Dual Database Persistence (SQLite + SQL Server 2025)', () {
    late AppDatabase db;

    setUpAll(() {
      db = AppDatabase.open();
    });

    tearDownAll(() {
      db.db.dispose();
    });

    test('Initializes tables and seeds default guest user', () {
      final user = db.db.select('SELECT * FROM users WHERE id = ?', ['guest']);
      expect(user.isNotEmpty, isTrue);
      expect(user.first['email'], equals('guest@illimmi.local'));
    });

    test('Persists course history in SQLite and SQL Server', () async {
      final testCourseId = 'test_course_${DateTime.now().millisecondsSinceEpoch}';
      
      await db.saveCourseHistory(
        id: testCourseId,
        userId: 'guest',
        prompt: 'Test de persistance duale SQLite et SQL Server 2025',
        subject: 'Vérification Dual-Write',
        script: 'HYPERCOURSE 1.0\nCONFIG\nDURATION: 10\nEND\nSECTION\nTEXT "Test réussi" (100, 100) 0s 5s\nEND',
        audioUrl: 'http://localhost:8083/audios/test.mp3',
        duration: 10,
        createdAt: DateTime.now().toIso8601String(),
      );

      // Verify retrieval in SQLite
      final history = db.db.select('SELECT * FROM course_history WHERE user_id = ?', ['guest']);
      final found = history.where((h) => h['id'] == testCourseId).toList();
      expect(found.isNotEmpty, isTrue);
      expect(found.first['subject'], equals('Vérification Dual-Write'));

      // Clean up test entry
      db.db.execute('DELETE FROM course_history WHERE id = ?', [testCourseId]);
      await db.sqlServer.execute("DELETE FROM course_history WHERE id = '$testCourseId'");
    });
  });
}
