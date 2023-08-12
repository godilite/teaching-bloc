import 'package:dio/dio.dart';
import 'package:teaching_bloc/src/network/base_api_client.dart';

class DioClient implements ApiClient {
  final Dio _dio;

  DioClient(this._dio);

  @override
  Future<dynamic> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.get(url, queryParameters: queryParameters);
    return response.data;
  }
}
