import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for HapticFeedback

class MoodSelector extends StatefulWidget {
  final Function(int) onMoodSelected;

  const MoodSelector({super.key, required this.onMoodSelected});

  @override
  State<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  int _selectedMood = 5;

  final Map<int, String> _emojis = {
    1: '😭',
    2: '😞',
    3: '😧',
    4: '😦',
    5: '😐',
    6: '😏',
    7: '🙂',
    8: '😀',
    9: '😁',
    10: '😂',
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _emojis.entries.map((entry) {
        final bool isSelected = _selectedMood == entry.key;
        return GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact(); // Haptic feedback
            setState(() {
              _selectedMood = entry.key;
            });
            widget.onMoodSelected(entry.key);
          },
          child: AnimatedScale(
            scale: isSelected ? 1.5 : 1.0, // Scale animation for visual feedback
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            child: AnimatedDefaultTextStyle(
              style: TextStyle(
                fontSize: isSelected ? 36 : 30, // Font size animation
                color: isSelected ? Colors.blue : Colors.grey,
              ),
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutBack,
              child: Text(entry.value),
            ),
          ),
        );
      }).toList(),
    );
  }
}
