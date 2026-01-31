import 'package:ennaa_ffeeelinggu/src/widgets/mood_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MoodSelector updates selection', (WidgetTester tester) async {
    int selectedMood = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MoodSelector(
            onMoodSelected: (mood) {
              selectedMood = mood;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('😀'));
    await tester.pump();

    expect(selectedMood, 8);
  });
}
