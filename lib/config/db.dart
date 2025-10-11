import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DB {

  static late Database db;

  static Future<void> dbInit()  async {
    sqfliteFfiInit();
    db = await databaseFactoryFfi.openDatabase("my_database.db");
    print("database connected");
  }

  static Future<Database> getDB() async {
    return db;
  }
}