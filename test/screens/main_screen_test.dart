import 'package:ennaa_ffeeelinggu/src/providers/journal_provider.dart';
import 'package:ennaa_ffeeelinggu/src/screens/history_screen.dart';
import 'package:ennaa_ffeeelinggu/src/screens/home_screen.dart';
import 'package:ennaa_ffeeelinggu/src/screens/main_screen.dart';
import 'package:ennaa_ffeeelinggu/src/services/notification_service.dart'; // Add this import
import 'package:ennaa_ffeeelinggu/src/screens/entry_screen.dart'; // Add this import
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:timezone/data/latest.dart' as tz;
import '../providers/journal_provider_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  tz.initializeTimeZones();

  group('MainScreen', () {
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

    testWidgets('MainScreen displays HomeScreen initially', (WidgetTester tester) async {
      when(mockDatabaseService.getEntries()).thenAnswer((_) async => []); // Mock empty entries for HomeScreen
      await pumpMainScreen(tester);

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(HistoryScreen), findsNothing);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('History'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.history), findsOneWidget);
    });

    testWidgets('Tapping History tab navigates to HistoryScreen', (WidgetTester tester) async {
      when(mockDatabaseService.getEntries()).thenAnswer((_) async => []); // Mock empty entries for both screens
      await pumpMainScreen(tester);

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(HistoryScreen), findsNothing);

      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsNothing);
      expect(find.byType(HistoryScreen), findsOneWidget);
    });

    testWidgets('Tapping Home tab navigates to HomeScreen', (WidgetTester tester) async {
      when(mockDatabaseService.getEntries()).thenAnswer((_) async => []); // Mock empty entries for both screens
      await pumpMainScreen(tester);

      // Navigate to History first
      await tester.tap(find.text('History'));
      await tester.pumpAndSettle();
      expect(find.byType(HistoryScreen), findsOneWidget);

      // Then navigate back to Home
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(HistoryScreen), findsNothing);
    });

    testWidgets('Tapping FAB opens EntryScreen as a modal', (WidgetTester tester) async {
      when(mockDatabaseService.getEntries()).thenAnswer((_) async => []); // Mock empty entries
      await pumpMainScreen(tester);

      // Tap the FAB to open the EntryScreen modal
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle(); // Wait for the modal to appear

      expect(find.byType(EntryScreen), findsOneWidget);
    });
  });
}
