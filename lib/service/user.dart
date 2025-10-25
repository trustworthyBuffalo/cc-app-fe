import 'dart:convert';

import 'package:cobaaja/model/http_client.dart';
import 'package:cobaaja/model/url.dart';
import 'package:cobaaja/model/user.dart';
import 'package:cobaaja/model/wrapper.dart';
import 'package:cobaaja/service/global.dart';
import 'package:http/http.dart' as http;

class UserService {

  static Future<ApiResult> login(String email, String password) async {

    final body = {
      "email": email,
      "password" : password,
    };

    final endPoint = "/user/login";
    final url = Uri.https(URL.url, endPoint);
    final client = LoggingClient(http.Client());

    //== Req  
    try {

      final res = await client.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body)
      );

      // get resp, check status
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        print(data);

        // get token and save for auto login;
        await insertToken(data['data']['token']);

        return ApiResult.success(data['data']['token']);
      }
      
      else {
        final data = json.decode(res.body);
        print(data);
        return ApiResult.failure(data['message']);
      }
    }

    catch (e) {
      print(e);
      return ApiResult.failure("error when conneting to server");
    }
  }

  static Future<ApiResult> getMe(String token) async {
    
    final endPoint = "/user/getme";
    final url = Uri.https(URL.url, endPoint);
    final client = LoggingClient(http.Client());

    //== req
    try {

      final res = await client.get(
        url,
        headers: {
          "Content-Type" : "application/json",
          "Authorization" : "Bearer $token" 
          }, 
      );

      final data =  json.decode(res.body);
      print(data);

      // check respon
      if (res.statusCode == 200) {
        final userModel = User.fromJson(data['data']);

        return ApiResult.success(userModel);
        
      } else {
        return ApiResult.failure(data['message']);
      }
    }

    catch (e) {
      print(e);

      return ApiResult.failure("failed when connecting to server");
    }
  }

}