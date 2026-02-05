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
    return Scaffold(
      appBar: null, // No AppBar for bottom sheet
      resizeToAvoidBottomInset: true, // Allow content to resize when keyboard appears
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0, // Adjust for keyboard
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Take minimum space
            children: [
              const Text(
                'New Entry',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
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
      ),
    );
  }
}
