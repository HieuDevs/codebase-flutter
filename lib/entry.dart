import 'dart:async';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:lua/core/api/dio_service.dart';
import 'package:lua/core/common/config.dart';
import 'package:lua/core/di/injection_container.dart';
import 'package:lua/core/logger/app_logger.dart';
import 'package:lua/core/logger/log_config.dart';
import 'package:lua/core/logger/log_level.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> entry({required Widget app}) async {
  await Future.wait([_initialize(), setupDI(), _requestTrackingTransparencyPermission()]);
  getIt.get<DioService>().initialize(baseUrl: Config.baseUrl, enableCertificatePinning: false);
  runApp(ProviderScope(child: app));
  // FlutterError.onError = (errorDetails) {
  //   debugPrint('Error: ${errorDetails.exceptionAsString()}');
  // };
  // ErrorWidget.builder = (errorDetails) {
  //   return MaterialApp(
  //     home: Scaffold(body: Center(child: Text('Error: ${errorDetails.exceptionAsString()}'))),
  //   );
  // };
}

Future<void> _requestTrackingTransparencyPermission() async {
  if (Platform.isIOS) {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      final result = await AppTrackingTransparency.requestTrackingAuthorization();
      debugPrint('Tracking permission: $result');
    } else {
      debugPrint('Tracking already set: $status');
    }
  }
}

Future<void> _initialize() async {
  AppLogger.instance.initialize(
    config: const LogConfig(
      minLevel: LogLevel.debug,
      enableConsoleOutput: true,
      enableFileOutput: true,
      enableColors: true,
      showTimestamp: true,
      showStackTrace: true,
      showClassName: true,
      showMethodName: true,
      maxFileSize: 5 * 1024 * 1024, // 5MB
      maxFiles: 5,
    ),
  );
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  FlutterNativeSplash.remove();
  await Config.loadEnv(envType: EnvType.production);
}
