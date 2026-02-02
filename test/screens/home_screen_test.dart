import 'package:ennaa_ffeeelinggu/src/models/journal_entry.dart';
import 'package:ennaa_ffeeelinggu/src/providers/journal_provider.dart';
import 'package:ennaa_ffeeelinggu/src/screens/entry_screen.dart';
import 'package:ennaa_ffeeelinggu/src/screens/history_screen.dart';
import 'package:ennaa_ffeeelinggu/src/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../providers/journal_provider_test.mocks.dart';

void main() {
  group('HomeScreen', () {
    late MockDatabaseService mockDatabaseService;
    late JournalProvider journalProvider;

    setUp(() {
      mockDatabaseService = MockDatabaseService();
      journalProvider = JournalProvider(databaseService: mockDatabaseService);
    });

    testWidgets('HomeScreen displays "No entries yet" when empty', (WidgetTester tester) async {
      when(mockDatabaseService.getEntries()).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ChangeNotifierProvider<JournalProvider>.value(
          value: journalProvider,
          child: const MaterialApp(home: HomeScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No entries yet. Add your first mood and activity!'), findsOneWidget);
      expect(find.text('Add New Entry'), findsOneWidget);
      expect(find.text('View History'), findsOneWidget);
    });

    testWidgets('HomeScreen displays the latest entry', (WidgetTester tester) async {
      final now = DateTime.now();
      final entry = JournalEntry(id: 1, mood: 8, activity: 'Working', timestamp: now);

      when(mockDatabaseService.getEntries()).thenAnswer((_) async => [entry]);

      await tester.pumpWidget(
        ChangeNotifierProvider<JournalProvider>.value(
          value: journalProvider,
          child: const MaterialApp(home: HomeScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Your Latest Entry:'), findsOneWidget);
      expect(find.text('Mood: 😀'), findsOneWidget);
      expect(find.text('Activity: Working'), findsOneWidget);
    });

    testWidgets('Tapping "Add New Entry" opens EntryScreen as a modal', (WidgetTester tester) async {
      when(mockDatabaseService.getEntries()).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ChangeNotifierProvider<JournalProvider>.value(
          value: journalProvider,
          child: const MaterialApp(home: HomeScreen()),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add New Entry'));
      await tester.pumpAndSettle(); // Wait for the modal to appear

      expect(find.byType(EntryScreen), findsOneWidget);
    });

    testWidgets('Tapping "View History" navigates to HistoryScreen', (WidgetTester tester) async {
      when(mockDatabaseService.getEntries()).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ChangeNotifierProvider<JournalProvider>.value(
          value: journalProvider,
          child: MaterialApp(home: const HomeScreen(), routes: {
            '/history': (context) => const HistoryScreen(),
          }),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('View History'));
      await tester.pumpAndSettle();

      expect(find.byType(HistoryScreen), findsOneWidget);
    });
  });
}
