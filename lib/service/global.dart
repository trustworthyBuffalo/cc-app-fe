import 'package:cobaaja/config/db.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<String> isLogin(Database db) async {
  final result = await db.rawQuery("SELECT COUNT(*) AS total FROM tokens");
  final count = result.first['total'];

  if (count! as int > 0) {
    print("user auto login");

    final token = await getToken(db);

    print("token : $token");

    return token;
  } else {
    print("user not login");

    return "";
  }
}

Future<String> getToken(Database db) async {
  final result = await db.rawQuery("SELECT token FROM tokens");
  final token = result.last['token'];

  if (token == null) {
    return "";
  }

  return token as String;
}

Future<void> insertToken(String token) async {

  final db =  DB.getDB();

  await db.insert("tokens", {"token" : token});
  
}