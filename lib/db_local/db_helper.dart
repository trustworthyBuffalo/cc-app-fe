import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("app.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // Table chat settings
    await db.execute('''
      CREATE TABLE chat_settings (
        userId TEXT PRIMARY KEY,
        nickname TEXT,
        backgroundPath TEXT
      )
    ''');
  }

  // ===== CRUD =====

  Future<Map<String, dynamic>?> getChatSetting(String userId) async {
    final db = await database;
    var result = await db.query(
      "chat_settings",
      where: "userId = ?",
      whereArgs: [userId],
    );

    if (result.isNotEmpty) return result.first;
    return null;
  }

  Future<void> saveChatSetting({
    required String userId,
    String? nickname,
    String? backgroundPath,
  }) async {
    final db = await database;
    await db.insert(
      "chat_settings",
      {
        "userId": userId,
        "nickname": nickname,
        "backgroundPath": backgroundPath,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
