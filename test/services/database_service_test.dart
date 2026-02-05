import 'package:ennaa_ffeeelinggu/src/models/journal_entry.dart';
import 'package:ennaa_ffeeelinggu/src/services/database_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Initialize FFI
  sqfliteFfiInit();

  // Use a mock database for testing
  databaseFactory = databaseFactoryFfi;

  group('DatabaseService', () {
    late DatabaseService databaseService;

    setUp(() {
      databaseService = DatabaseService.instance;
    });

    tearDown(() async {
      // Clear the database after each test
      final db = await databaseService.database;
      await db.delete(DatabaseService.table);
    });

    test('addEntry and getEntries', () async {
      final timestamp = DateTime.now();
      final entry = JournalEntry(
        mood: 8,
        activity: 'Coding',
        timestamp: timestamp,
      );

      await databaseService.addEntry(entry);

      final entries = await databaseService.getEntries();

      expect(entries.length, 1);
      expect(entries.first.mood, 8);
      expect(entries.first.activity, 'Coding');
      // Compare timestamps up to the millisecond
      expect(
        entries.first.timestamp.toIso8601String().substring(0, 23),
        timestamp.toIso8601String().substring(0, 23),
      );
    });
  });
}
