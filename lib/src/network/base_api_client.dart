abstract class ApiClient {
  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters});
}
