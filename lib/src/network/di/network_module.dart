import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:teaching_bloc/src/di/base_module.dart';
import 'package:teaching_bloc/src/network/base_api_client.dart';
import 'package:teaching_bloc/src/network/dio_client.dart';

class NetworkModule implements BaseModule {
  @override
  void configure(GetIt getIt) {
    getIt.registerFactory<ApiClient>(
      () => DioClient(Dio()),
    );
  }
}
