class ApiResult<T> {
  final T? data;
  final String? error;

  ApiResult.success(this.data) : error = null;
  ApiResult.failure(this.error) : data = null;

  // set error response for failure sending data to server
  static ApiResult errorSendToServer(dynamic e) {
    return ApiResult.failure("conneting to server error: $e");
  }

  bool get isSuccess => error == null;
}
