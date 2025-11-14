import 'dart:convert';

import 'package:cobaaja/config/global_data.dart';
import 'package:cobaaja/model/http_client.dart';
import 'package:cobaaja/model/url.dart';
import 'package:cobaaja/model/user.dart';
import 'package:cobaaja/model/wrapper.dart';
import 'package:cobaaja/service/storage_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  static final String rootRoute = "/user";
  static final String jsonType = "application/json";

  static Future<ApiResult> register(UserRegister registerData) async {
    final String route = "user/register";

    final url = Uri.https(URL.baseUrl, route);
    final client = LoggingClient(http.Client());

    // sending request
    try {
      final resp = await client.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(registerData.toMap()),
      );

      if (resp.statusCode == 200) {
        return ApiResult.success(true);
      } else {
        final dataResp = json.decode(resp.body);
        print(dataResp["message"]);
        return ApiResult.failure(dataResp["message"]);
      }
    } catch (e) {
      return ApiResult.errorSendToServer(e);
    }
  }

  static Future<ApiResult> login(UserLogin loginData) async {
    final String route = "user/login";

    final url = Uri.https(URL.baseUrl, route);
    final client = LoggingClient(http.Client());

    try {
      final resp = await client.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(loginData.toMap()),
      );

      final dataResp = json.decode(resp.body);
      if (resp.statusCode == 200) {
        await Storage.setToken(dataResp["data"]["token"]);
        var userData = await UserService.me();

        if (userData.isSuccess) {
          UserGlobalData.userData = userData.data as User;
        }

        return ApiResult.success(true);
      } else {
        return ApiResult.failure(dataResp["message"]);
      }
    } catch (e) {
      return ApiResult.errorSendToServer(e);
    }
  }

  static Future<ApiResult> me() async {
    final String? token = await Storage.getToken();

    if (token == null) {
      return ApiResult.errorSendToServer("tokn session invalid");
    }

    final String route = "user/getme";

    final url = Uri.https(URL.baseUrl, route);
    final client = LoggingClient(http.Client());

    try {
      var resp = await client.get(
        url,
        headers: {"Authorization": "Bearer $token"},
      );

      var respData = json.decode(resp.body);

      if (resp.statusCode == 200) {
        var userData = User.fromJson(respData["data"]);

        return ApiResult.success(userData);
      } else {
        return ApiResult.failure(respData["message"]);
      }
    } catch (e) {
      return ApiResult.errorSendToServer(e);
    }
  }
}
