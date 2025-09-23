import 'dart:async';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:codebase/core/common/config.dart';
import 'package:codebase/core/di/injection_container.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> entry({required Widget app}) async {
  await Future.wait([_initialize(), setupDI(), _requestTrackingTransparencyPermission()]);
  runApp(app);
  FlutterError.onError = (errorDetails) {
    debugPrint('Error: ${errorDetails.exceptionAsString()}');
  };
  ErrorWidget.builder = (errorDetails) {
    return Center(child: Text('Error: ${errorDetails.exceptionAsString()}'));
  };
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
  final widgetBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetBinding);
  FlutterNativeSplash.remove();
  await Config.loadEnv(envType: EnvType.production);
}
