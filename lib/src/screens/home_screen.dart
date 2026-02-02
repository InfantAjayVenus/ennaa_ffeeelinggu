import 'package:ennaa_ffeeelinggu/src/models/journal_entry.dart';
import 'package:ennaa_ffeeelinggu/src/providers/journal_provider.dart';
import 'package:ennaa_ffeeelinggu/src/screens/entry_screen.dart';
import 'package:ennaa_ffeeelinggu/src/screens/history_screen.dart';
import 'package:ennaa_ffeeelinggu/src/utils/emoji_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<JournalProvider>(context, listen: false).fetchEntries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ennaa Fffeeelinggu'),
      ),
      body: Consumer<JournalProvider>(
        builder: (context, journalProvider, child) {
          final latestEntry = journalProvider.entries.isNotEmpty ? journalProvider.entries.first : null;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (latestEntry != null) ...[
                  const Text(
                    'Your Latest Entry:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mood: ${EmojiHelper.getEmoji(latestEntry.mood)}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Activity: ${latestEntry.activity}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Timestamp: ${DateFormat('yyyy-MM-dd HH:mm').format(latestEntry.timestamp)}',
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ] else
                  const Text(
                    'No entries yet. Add your first mood and activity!',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      builder: (context) => const EntryScreen(),
                    );
                    // Refresh entries after the EntryScreen is dismissed
                    Provider.of<JournalProvider>(context, listen: false).fetchEntries();
                  },
                  child: const Text('Add New Entry'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HistoryScreen()),
                    );
                  },
                  child: const Text('View History'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
