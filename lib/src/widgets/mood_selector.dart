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
    // Split emojis into two rows
    final List<MapEntry<int, String>> firstRowEmojis = _emojis.entries.take(5).toList();
    final List<MapEntry<int, String>> secondRowEmojis = _emojis.entries.skip(5).take(5).toList();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: firstRowEmojis.map((entry) => _buildEmojiWidget(entry)).toList(),
        ),
        const SizedBox(height: 10), // Space between rows
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: secondRowEmojis.map((entry) => _buildEmojiWidget(entry)).toList(),
        ),
      ],
    );
  }

  Widget _buildEmojiWidget(MapEntry<int, String> entry) {
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
  }
}
