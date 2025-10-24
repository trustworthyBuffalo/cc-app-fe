import 'dart:convert';

import 'package:cobaaja/config/db.dart';
import 'package:cobaaja/model/http_client.dart';
import 'package:cobaaja/model/url.dart';
import 'package:http/http.dart' as http;

class User {


  static Future<http.Response?> register (String name, String email, String password) async {

    var body = {
      "name" : name,
      "email" : email,
      "password" : password,
    };
    final endPoint =  "/user/register";
    final url = Uri.https(URL.url, endPoint);
    final client = LoggingClient(http.Client());
    
    try {

      // requesting
      final response = await client.post(url, 
            headers: { "Content-Type": "application/json" },
            body: json.encode(body), );

      return response;

    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

static Future<http.Response?> login (String email, String password) async {

    final body = {
      "email" : email,
      "password" : password,
    };

    var endPoint = "/user/login";

    var url = Uri.https(URL.url, endPoint);
  
    try {

      // request
      final response = await http.post(url, 
            headers: { "Content-Type": "application/json" },
            body: json.encode(body), );

    print(response.body);
    return response;

    } catch(e) {
      print("Error: $e");
      return null;
    }
    
  }

static Future<http.Response?> getMe() async {

  var endPoint = "/user/getme";

  final url = Uri.https(URL.url, endPoint);
  
  try {
    

    // request
    final response = await http.get(url);

    print(response.body);
    return response;
    
    }

    catch(e) {
  
      print("Error: $e");
      return null;
    }

}

static Future<bool> checkToken() async {
    
    // checks active tokens to prevent repeated logins

    final db = await DB.getDB();
    final data = await db.rawQuery('SELECT count(*) AS `count` FROM tokens');

    if (data[0]['count']! as int > 0) {
      print(data[0]['count']! as int);
      return true;
    }

    return false;
}
}