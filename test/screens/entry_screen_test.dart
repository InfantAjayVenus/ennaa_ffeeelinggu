import 'package:ennaa_ffeeelinggu/src/screens/entry_screen.dart';
import 'package:ennaa_ffeeelinggu/src/widgets/mood_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('EntryScreen has all required widgets',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EntryScreen()));

    expect(find.byType(MoodSelector), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('EntryScreen updates state on input change',
      (WidgetTester tester) async {
    final entryScreenKey = GlobalKey<State<EntryScreen>>();
    await tester.pumpWidget(MaterialApp(home: EntryScreen(key: entryScreenKey)));

    await tester.tap(find.text('😁'));
    await tester.pump();

    final entryScreenState = entryScreenKey.currentState as dynamic;
    expect(entryScreenState.selectedMood, 9);


    await tester.enterText(find.byType(TextField), 'Writing tests');
    await tester.pump();
    expect(entryScreenState.activityController.text, 'Writing tests');
  });
}

