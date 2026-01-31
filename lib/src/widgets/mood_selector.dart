import 'package:flutter/material.dart';

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
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedMood = entry.key;
            });
            widget.onMoodSelected(entry.key);
          },
          child: Text(
            entry.value,
            style: TextStyle(
              fontSize: 30,
              color: _selectedMood == entry.key ? Colors.blue : Colors.grey,
            ),
          ),
        );
      }).toList(),
    );
  }
}
