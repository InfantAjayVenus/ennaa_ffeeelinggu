import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ennaa_ffeeelinggu/src/models/journal_entry.dart';

class DatabaseService {
  static const _databaseName = 'journal.db';
  static const _databaseVersion = 1;

  static const table = 'journal_entries';

  static const columnId = 'id';
  static const columnMood = 'mood';
  static const columnActivity = 'activity';
  static const columnTimestamp = 'timestamp';

  DatabaseService._privateConstructor();
  static final DatabaseService instance = DatabaseService._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnMood INTEGER NOT NULL,
        $columnActivity TEXT NOT NULL,
        $columnTimestamp TEXT NOT NULL
      )
    ''');
  }

  Future<int> addEntry(JournalEntry entry) async {
    final db = await instance.database;
    return await db.insert(table, entry.toMap());
  }

  Future<List<JournalEntry>> getEntries() async {
    final db = await instance.database;
    final maps = await db.query(table, orderBy: '$columnTimestamp DESC');
    return List.generate(maps.length, (i) {
      return JournalEntry.fromMap(maps[i]);
    });
  }
}
