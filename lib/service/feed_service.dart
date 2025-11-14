import 'dart:convert';

import 'package:cobaaja/model/http_client.dart';
import 'package:cobaaja/model/thread.dart';
import 'package:cobaaja/model/url.dart';
import 'package:cobaaja/model/wrapper.dart';
import 'package:cobaaja/service/storage_service.dart';
import 'package:http/http.dart' as http;

class ThreadService {
  static Future<ApiResult> getAllThread() async {
    // get token
    String? token = await Storage.getToken();
    if (token == null) {
      return ApiResult.errorSendToServer("token not available");
    }

    final route = "threads";
    final client = LoggingClient(http.Client());

    final url = Uri.https(URL.baseUrl, route);

    try {
      final resp = await client.get(
        url,
        headers: {"Authorization": "Bearer $token"},
      );

      final respData = json.decode(resp.body);
      print(respData);
      if (resp.statusCode == 200) {
        var threads = threadsFromListJson(respData["data"]);

        return ApiResult.success(threads);
      } else {
        return ApiResult.failure(respData["message"]);
      }
    } catch (e) {
      return ApiResult.errorSendToServer(e);
    }
  }
}
