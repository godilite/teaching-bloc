import 'package:get_it/get_it.dart';
import 'package:teaching_bloc/src/di/base_module.dart';
import 'package:teaching_bloc/src/network/di/network_module.dart';

class AppModule extends BaseModule {
  @override
  void configure(GetIt getIt) {
    NetworkModule().configure(getIt);
  }
}
