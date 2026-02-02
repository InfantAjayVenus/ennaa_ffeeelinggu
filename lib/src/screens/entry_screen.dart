import 'package:ennaa_ffeeelinggu/src/models/journal_entry.dart';
import 'package:ennaa_ffeeelinggu/src/providers/journal_provider.dart';
import 'package:ennaa_ffeeelinggu/src/widgets/mood_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensure column takes minimum space
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'New Entry',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
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
                  final journalProvider =
                      Provider.of<JournalProvider>(context, listen: false);
                  journalProvider.addEntry(
                    JournalEntry(
                      mood: selectedMood,
                      activity: activityController.text,
                      timestamp: DateTime.now(),
                    ),
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Entry saved!'),
                    ),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
