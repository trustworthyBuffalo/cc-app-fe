import 'dart:io';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DB {

  static late Database db;

  static Future<void> dbInit()  async {

    sqfliteFfiInit();
    var dbPath = "my_database.db";

    db = await databaseFactoryFfi.openDatabase(dbPath);

    print("database connected");


  }

  static Future<Database> getDB() async {
    return db;
  }
}