import 'package:ennaa_ffeeelinggu/src/models/journal_entry.dart';
import 'package:ennaa_ffeeelinggu/src/providers/journal_provider.dart';
import 'package:ennaa_ffeeelinggu/src/screens/entry_screen.dart';
import 'package:ennaa_ffeeelinggu/src/screens/home_screen.dart';
import 'package:ennaa_ffeeelinggu/src/screens/main_screen.dart'; // Add this import
import 'package:ennaa_ffeeelinggu/src/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../providers/journal_provider_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  tz.initializeTimeZones();

  group('HomeScreen', () {
    late MockDatabaseService mockDatabaseService;
    late JournalProvider journalProvider;

    setUp(() {
      mockDatabaseService = MockDatabaseService();
      journalProvider = JournalProvider(databaseService: mockDatabaseService);
    });

    // Helper to pump MainScreen with necessary providers
    Future<void> pumpMainScreen(WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider<JournalProvider>.value(
          value: journalProvider,
          child: const MaterialApp(home: MainScreen()),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('HomeScreen displays "No entries yet" when empty', (WidgetTester tester) async {
      when(mockDatabaseService.getEntries()).thenAnswer((_) async => []);
      await pumpMainScreen(tester);

      expect(find.text('No entries yet. Add your first mood and activity!'), findsOneWidget);
    });

    testWidgets('HomeScreen displays the latest entry', (WidgetTester tester) async {
      final now = DateTime.now();
      final entry = JournalEntry(id: 1, mood: 8, activity: 'Working', timestamp: now);

      when(mockDatabaseService.getEntries()).thenAnswer((_) async => [entry]);
      await pumpMainScreen(tester);

      expect(find.text('Your Latest Entry:'), findsOneWidget);
      expect(find.text('Mood: 😀'), findsOneWidget);
      expect(find.text('Activity: Working'), findsOneWidget);
    });


  });
}
