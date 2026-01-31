import 'package:ennaa_ffeeelinggu/src/models/journal_entry.dart';
import 'package:ennaa_ffeeelinggu/src/services/database_service.dart';
import 'package:flutter/material.dart';

class JournalProvider with ChangeNotifier {
  final DatabaseService _databaseService;

  JournalProvider({DatabaseService? databaseService})
      : _databaseService = databaseService ?? DatabaseService.instance;

  List<JournalEntry> _entries = [];
  List<JournalEntry> get entries => _entries;

  Future<void> addEntry(JournalEntry entry) async {
    await _databaseService.addEntry(entry);
    await fetchEntries();
  }

  Future<void> fetchEntries() async {
    _entries = await _databaseService.getEntries();
    notifyListeners();
  }
}
