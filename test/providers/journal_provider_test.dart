import 'package:ennaa_ffeeelinggu/src/models/journal_entry.dart';
import 'package:ennaa_ffeeelinggu/src/providers/journal_provider.dart';
import 'package:ennaa_ffeeelinggu/src/services/database_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'journal_provider_test.mocks.dart';

@GenerateMocks([DatabaseService])
void main() {
  group('JournalProvider', () {
    late JournalProvider journalProvider;
    late MockDatabaseService mockDatabaseService;

    setUp(() {
      mockDatabaseService = MockDatabaseService();
      journalProvider = JournalProvider(databaseService: mockDatabaseService);
    });

    test('addEntry calls DatabaseService.addEntry', () async {
      final entry = JournalEntry(
        mood: 8,
        activity: 'Coding',
        timestamp: DateTime.now(),
      );

      when(mockDatabaseService.addEntry(entry)).thenAnswer((_) async => 1);
      when(mockDatabaseService.getEntries()).thenAnswer((_) async => [entry]);

      await journalProvider.addEntry(entry);

      verify(mockDatabaseService.addEntry(entry)).called(1);
      verify(mockDatabaseService.getEntries()).called(1);
      expect(journalProvider.entries.length, 1);
      expect(journalProvider.entries.first, entry);
    });
  });
}
