import 'package:lua/core/api/dio_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  // Register Dio Service
  getIt.registerSingleton<DioService>(DioService());
}
