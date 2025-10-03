import 'dart:isolate';

import 'package:lua/core/storage/get_storage_key.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:vibration/vibration.dart';

enum VibrationType { single, double, pattern, lite, extraLite, streakPattern }

enum IsolateBackgroundVibrationMethod { vibrate, cancel }

class _IsolateTaskBackgroundVibration {
  final SendPort sendPort;
  final RootIsolateToken? rootIsolateToken;

  const _IsolateTaskBackgroundVibration({required this.sendPort, this.rootIsolateToken});
}

class _PortModel {
  final String method;
  final dynamic data;
  final SendPort? sendPort;
  _PortModel({required this.method, required this.data, this.sendPort});
}

class IsolateBackgroundVibration {
  static late SendPort? _sendPort;

  static Future<void> init() async {
    final receivePort = ReceivePort();
    final RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
    await Isolate.spawn(
      _isolateEntry,
      _IsolateTaskBackgroundVibration(sendPort: receivePort.sendPort, rootIsolateToken: rootIsolateToken),
      errorsAreFatal: false,
    );

    receivePort.listen((message) {
      if (message is SendPort) {
        _sendPort = message;
      }
    });
  }

  static void _isolateEntry(_IsolateTaskBackgroundVibration task) {
    if (task.rootIsolateToken != null) {
      BackgroundIsolateBinaryMessenger.ensureInitialized(task.rootIsolateToken!);
    }
    final ReceivePort receivePort = ReceivePort();
    task.sendPort.send(receivePort.sendPort);

    receivePort.listen((message) async {
      if (message is _PortModel) {
        final enumMethod = IsolateBackgroundVibrationMethod.values.firstWhere(
          (e) => e.name == message.method,
          orElse: () => IsolateBackgroundVibrationMethod.vibrate,
        );

        switch (enumMethod) {
          case IsolateBackgroundVibrationMethod.vibrate:
            final vibrationType = message.data as VibrationType;
            try {
              await _performVibration(vibrationType);
            } catch (e) {
              debugPrint('Vibration error: $e');
            } finally {
              message.sendPort?.send(null);
            }
            break;
          case IsolateBackgroundVibrationMethod.cancel:
            try {
              await Vibration.cancel();
            } catch (e) {
              debugPrint('Vibration cancel error: $e');
            } finally {
              message.sendPort?.send(null);
            }
            break;
        }
      }
    });
  }

  static Future<void> _performVibration(VibrationType vibrationType) async {
    if (!(await Vibration.hasVibrator())) {
      return;
    }

    switch (vibrationType) {
      case VibrationType.single:
        await Vibration.vibrate(duration: 100);
        break;
      case VibrationType.double:
        await Vibration.vibrate(pattern: [0, 500, 200, 500], intensities: [0, 255, 0, 255]);
        break;
      case VibrationType.pattern:
        await Vibration.vibrate(pattern: [0, 400, 200, 500, 200, 500, 200, 500], intensities: [0, 255, 0, 255, 0, 255, 0, 255]);
        break;
      case VibrationType.lite:
        await Vibration.vibrate(duration: 50, amplitude: 150);
        break;
      case VibrationType.extraLite:
        await Vibration.vibrate(duration: 20, amplitude: 100);
        break;
      case VibrationType.streakPattern:
        await Vibration.vibrate(pattern: [0, 400, 200, 500, 200, 500], intensities: [0, 60, 80, 100, 110, 120]);
        break;
    }
  }

  static Future<void> vibrate(VibrationType vibrationType) async {
    final bool? isTurnOnHapticEffect = AppGetStorage.instance.appStorage.read<bool>(GetStorageKey.kIsTurnOnHapticFeedback);
    if (isTurnOnHapticEffect != null && !isTurnOnHapticEffect) {
      return;
    }

    final receivePort = ReceivePort();
    _sendPort?.send(_PortModel(method: IsolateBackgroundVibrationMethod.vibrate.name, data: vibrationType, sendPort: receivePort.sendPort));
    await receivePort.first;
    receivePort.close();
  }

  static Future<void> cancel() async {
    final receivePort = ReceivePort();
    _sendPort?.send(_PortModel(method: IsolateBackgroundVibrationMethod.cancel.name, data: null, sendPort: receivePort.sendPort));
    await receivePort.first;
    receivePort.close();
  }
}
