class JournalEntry {
  final int? id;
  final int mood;
  final String activity;
  final DateTime timestamp;

  JournalEntry({
    this.id,
    required this.mood,
    required this.activity,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mood': mood,
      'activity': activity,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory JournalEntry.fromMap(Map<String, dynamic> map) {
    return JournalEntry(
      id: map['id'],
      mood: map['mood'],
      activity: map['activity'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
