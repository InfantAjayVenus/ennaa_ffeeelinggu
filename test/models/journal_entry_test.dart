import 'package:ennaa_ffeeelinggu/src/models/journal_entry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('JournalEntry', () {
    test('toMap and fromMap', () {
      final timestamp = DateTime.now();
      final entry = JournalEntry(
        id: 1,
        mood: 8,
        activity: 'Coding',
        timestamp: timestamp,
      );

      final map = entry.toMap();

      expect(map['id'], 1);
      expect(map['mood'], 8);
      expect(map['activity'], 'Coding');
      expect(map['timestamp'], timestamp.toIso8601String());

      final fromMapEntry = JournalEntry.fromMap(map);

      expect(fromMapEntry.id, 1);
      expect(fromMapEntry.mood, 8);
      expect(fromMapEntry.activity, 'Coding');
      expect(fromMapEntry.timestamp, timestamp);
    });
  });
}
