import 'package:ennaa_ffeeelinggu/src/providers/journal_provider.dart';
import 'package:ennaa_ffeeelinggu/src/screens/entry_screen.dart';
import 'package:ennaa_ffeeelinggu/src/services/notification_service.dart';
import 'package:ennaa_ffeeelinggu/src/widgets/mood_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  tz.initializeTimeZones();

  group('EntryScreen', () {
    // Helper function to pump the EntryScreen with necessary providers
    Future<void> pumpEntryScreen(WidgetTester tester, {Key? key}) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (context) => JournalProvider(),
          child: MaterialApp(
            home: EntryScreen(key: key),
          ),
        ),
      );
    }

    testWidgets('EntryScreen has all required widgets', (WidgetTester tester) async {
      await pumpEntryScreen(tester);

      expect(find.text('New Entry'), findsOneWidget);
      expect(find.byType(MoodSelector), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('EntryScreen updates state on input change', (WidgetTester tester) async {
      final entryScreenKey = GlobalKey<State<EntryScreen>>();
      await pumpEntryScreen(tester, key: entryScreenKey);

      await tester.tap(find.text('😁'));
      await tester.pump();

      final entryScreenState = entryScreenKey.currentState as dynamic;
      expect(entryScreenState.selectedMood, 9);

      await tester.enterText(find.byType(TextField), 'Writing tests');
      await tester.pump();
      expect(entryScreenState.activityController.text, 'Writing tests');
    });
  });
}

