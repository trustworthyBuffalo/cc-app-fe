import 'dart:ffi';
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
    }

    else if (Platform.isAndroid) {
      await DB.dbInitAndroid();
    }
  }

  // Initial connection for Android Platform
  static Future<void> dbInitAndroid() async {
    var databasePath = await getDatabasesPath();
    var path = join(databasePath, 'my_database_andro.db');

    print(path);
    db = await openDatabase(path, version: 1, onOpen: (db) async {

        try {

          // table just for flag
          await db.execute("SELECT `status_init` FROM init;");

        } catch(e) {

          print("create tables...");
          
          // empty table in database, create for init
          initialCreateTableAndroid.map((q) async {
           await db.execute(q); 
          },);
        }
        
    
    },);

    print("database connected");
  }


  // Initial connection for Windows Platform
  static Future<void> dbInitWindows()  async {

    sqfliteFfiInit();

    // open connection
    var dbPath = "my_database_win.db";
    db = await databaseFactoryFfi.openDatabase(dbPath);

    print("database connected");


  }

  // Get connection
  static Future<Database> getDB() async {
    return db;
  }
}


final List<String> initialCreateTableAndroid = [
  '''
  CREATE TABLE init (
	  init_status INTEGER NOT NULL
    );
  ''',
  '''
  CREATE TABLE IF NOT EXISTS tokens (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    token TEXT NOT NULL
   );
  '''
];