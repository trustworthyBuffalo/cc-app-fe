import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static final FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<void> setToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  static Future<String?> getToken() async {
    final String? token = await storage.read(key: "token");

    return token;
  }
}
