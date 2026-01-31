import 'package:ennaa_ffeeelinggu/src/widgets/mood_selector.dart';
import 'package:flutter/material.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  // TODO: This is not ideal, but it's the simplest solution for now.
  // In a real app, you would want to expose the state in a more testable way.
  @visibleForTesting
  int selectedMood = 5;
  @visibleForTesting
  final TextEditingController activityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MoodSelector(
              onMoodSelected: (mood) {
                setState(() {
                  selectedMood = mood;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: activityController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Activity',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save logic will be implemented in a later task
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
