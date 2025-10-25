import 'package:http/http.dart' as http;

class LoggingClient extends http.BaseClient {
  final http.Client _inner;

  LoggingClient(this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // TODO: implement send

    print("⬆ [HTTP REQUEST][${request.method} ${request.url}]");
    final response = await _inner.send(request);
    print("⬇ [HTTP RESP] [${response.statusCode}] [${response.reasonPhrase}]]");
    return response;
  }
}