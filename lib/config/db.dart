import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DB {
  // singleton variable
  static late Database db;

  // db init open connection handler
  static Future<void> dbInit() async {
    if (Platform.isWindows) {
      await DB.dbInitWindows();
    } else if (Platform.isAndroid) {
      await DB.dbInitAndroid();
    } else if (Platform.isLinux) {
      await DB.dbInitLinux();
    }

    print("[Database Connnected]");
  }

  // Initial connection for Android Platform
  static Future<void> dbInitAndroid() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, 'my_database_andro.db');

    print(path);
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // buat table dulu pertama
        await dbCreateTable(db);
      },
    );
  }

  // Initial connection for Windows Platform
  static Future<void> dbInitWindows() async {
    sqfliteFfiInit();

    // open connection
    var dbPath = "my_database_win.db";
    db = await databaseFactoryFfi.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await dbCreateTable(db);
        },
      ),
    );
  }

  static Future<void> dbInitLinux() async {
    sqfliteFfiInit();

    // open connection
    var dbPath = "my_database_lnx.db";
    db = await databaseFactoryFfi.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await dbCreateTable(db);
        },
      ),
    );
  }

  // Get connection
  static Database getDB() {
    return db;
  }
}

Future<void> dbCreateTable(Database db) async {
  for (var i = 0; i < queryList.length; i++) {
    await db.execute(queryList[i]);

    print("[Create Table...] ==>> ${queryList[i]}");
  }
}

final List<String> queryList = [];
