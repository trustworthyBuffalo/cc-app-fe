import 'dart:convert';

import 'package:cobaaja/model/url.dart';
import 'package:http/http.dart' as http;

class User {


  static Future<http.Response?> register (String name, String email, String password) async {

    var body = {
      "name" : name,
      "email" : email,
      "password" : password,
    };

    var url = Uri.https(URL.url, "/user/register");

    try {
      final response = await http.post(url, 
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

    var url = Uri.https(URL.url, "/user/login");
  
    try {
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
  final url = Uri.https(URL.url, "/user/getme");
  
  try {
    final response = await http.get(url);

    print(response.body);
    print(response.body);
    return response;
    
    }
    catch(e) {
  
      print("Error: $e");
      return null;
    }

}
}