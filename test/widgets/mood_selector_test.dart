import 'package:ennaa_ffeeelinggu/src/widgets/mood_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';

void main() {
  testWidgets('MoodSelector updates selection and provides visual feedback', (WidgetTester tester) async {
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

    // Helper to find AnimatedDefaultTextStyle within a GestureDetector by emoji text
    Finder findAnimatedDefaultTextStyleByEmoji(String emoji) {
      return find.descendant(
        of: find.byWidgetPredicate(
          (widget) => widget is GestureDetector && (widget.child as AnimatedScale).child is AnimatedDefaultTextStyle && ((widget.child as AnimatedScale).child as AnimatedDefaultTextStyle).child is Text && (((widget.child as AnimatedScale).child as AnimatedDefaultTextStyle).child as Text).data == emoji,
        ),
        matching: find.byType(AnimatedDefaultTextStyle),
      );
    }

    // Initial state: mood 5 (😐) is selected, so its font size should be 36
    expect(tester.widget<AnimatedDefaultTextStyle>(findAnimatedDefaultTextStyleByEmoji('😐')).style.fontSize, 36);
    expect(tester.widget<AnimatedDefaultTextStyle>(findAnimatedDefaultTextStyleByEmoji('😀')).style.fontSize, 30);


    await tester.tap(find.text('😀'));
    await tester.pumpAndSettle(); // Wait for animations to complete

    expect(selectedMood, 8);

    // Verify visual feedback: mood 8 (😀) should now be selected and larger
    expect(tester.widget<AnimatedDefaultTextStyle>(findAnimatedDefaultTextStyleByEmoji('😀')).style.fontSize, 36);
    expect(tester.widget<AnimatedDefaultTextStyle>(findAnimatedDefaultTextStyleByEmoji('😐')).style.fontSize, 30);
  });
}
