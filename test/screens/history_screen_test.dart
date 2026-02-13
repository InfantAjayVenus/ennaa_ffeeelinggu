import 'package:ennaa_ffeeelinggu/src/models/journal_entry.dart';
import 'package:ennaa_ffeeelinggu/src/providers/journal_provider.dart';
import 'package:ennaa_ffeeelinggu/src/screens/history_screen.dart';
import 'package:ennaa_ffeeelinggu/src/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../providers/journal_provider_test.mocks.dart'; // Import the generated mock

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  tz.initializeTimeZones();

  group('HistoryScreen', () {
    late MockDatabaseService mockDatabaseService;
    late JournalProvider journalProvider;

    setUp(() {
      mockDatabaseService = MockDatabaseService();
      journalProvider = JournalProvider(databaseService: mockDatabaseService);
    });

    // Helper to pump HistoryScreen with necessary providers
    Future<void> pumpHistoryScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<JournalProvider>.value(
          value: journalProvider,
          child: MaterialApp(
            home: Scaffold( // HistoryScreen now expects a Scaffold from its parent
              appBar: AppBar(title: const Text('Journal History')),
              body: const HistoryScreen(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('HistoryScreen displays a list of mock entries', (WidgetTester tester) async {
      final now = DateTime.now();
      final entries = [
        JournalEntry(id: 1, mood: 7, activity: 'Reading', timestamp: now.subtract(const Duration(hours: 1))),
        JournalEntry(id: 2, mood: 9, activity: 'Working', timestamp: now),
      ];

      when(mockDatabaseService.getEntries()).thenAnswer((_) async => entries);
      await pumpHistoryScreen(tester);

      expect(find.text('Mood: 🙂'), findsOneWidget);
      expect(find.text('Activity: Reading'), findsOneWidget);
      expect(find.text('Mood: 😁'), findsOneWidget);
      expect(find.text('Activity: Working'), findsOneWidget);
    });

    testWidgets('HistoryScreen displays "No journal entries yet" when empty', (WidgetTester tester) async {
      when(mockDatabaseService.getEntries()).thenAnswer((_) async => []);
      await pumpHistoryScreen(tester);

      expect(find.text('No journal entries yet. Add one from the Entry Screen!'), findsOneWidget);
    });
  });
}
