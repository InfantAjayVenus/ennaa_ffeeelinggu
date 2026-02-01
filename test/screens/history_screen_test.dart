import 'package:ennaa_ffeeelinggu/src/models/journal_entry.dart';
import 'package:ennaa_ffeeelinggu/src/providers/journal_provider.dart';
import 'package:ennaa_ffeeelinggu/src/screens/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../providers/journal_provider_test.mocks.dart'; // Import the generated mock

void main() {
  group('HistoryScreen', () {
    late MockDatabaseService mockDatabaseService;
    late JournalProvider journalProvider;

    setUp(() {
      mockDatabaseService = MockDatabaseService();
      journalProvider = JournalProvider(databaseService: mockDatabaseService);
    });

    testWidgets('HistoryScreen displays a list of mock entries', (WidgetTester tester) async {
      final now = DateTime.now();
      final entries = [
        JournalEntry(id: 1, mood: 7, activity: 'Reading', timestamp: now.subtract(const Duration(hours: 1))),
        JournalEntry(id: 2, mood: 9, activity: 'Working', timestamp: now),
      ];

      when(mockDatabaseService.getEntries()).thenAnswer((_) async => entries);

      await tester.pumpWidget(
        ChangeNotifierProvider<JournalProvider>.value(
          value: journalProvider,
          child: const MaterialApp(home: HistoryScreen()),
        ),
      );
      await tester.pumpAndSettle(); // Wait for data to load

      expect(find.text('Journal History'), findsOneWidget);
      expect(find.text('Mood: 🙂'), findsOneWidget);
      expect(find.text('Activity: Reading'), findsOneWidget);
      expect(find.text('Mood: 😁'), findsOneWidget);
      expect(find.text('Activity: Working'), findsOneWidget);
    });

    testWidgets('HistoryScreen displays "No journal entries yet" when empty', (WidgetTester tester) async {
      when(mockDatabaseService.getEntries()).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ChangeNotifierProvider<JournalProvider>.value(
          value: journalProvider,
          child: const MaterialApp(home: HistoryScreen()),
        ),
      );
      await tester.pumpAndSettle(); // Wait for data to load

      expect(find.text('No journal entries yet. Add one from the Entry Screen!'), findsOneWidget);
    });
  });
}
