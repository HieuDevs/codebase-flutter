import 'dart:isolate';

import 'package:lua/core/storage/get_storage_key.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:media_kit/media_kit.dart';

enum SoundType { correctAnswer, wrongAnswer }

enum IsolateBackgroundSoundMethod { playSoundEffect }

class _IsolateTaskBackgroundSound {
  final SendPort sendPort;
  final RootIsolateToken? rootIsolateToken;

  const _IsolateTaskBackgroundSound({required this.sendPort, this.rootIsolateToken});
}

class _PortModel {
  final String method;
  final dynamic data;
  final SendPort? sendPort;
  _PortModel({required this.method, required this.data, this.sendPort});
}

class IsolateBackgroundSound {
  static late SendPort? _sendPort;
  static late Player? _player;

  static Future<void> init() async {
    final receivePort = ReceivePort();
    final RootIsolateToken? rootIsolateToken = RootIsolateToken.instance;
    await Isolate.spawn(
      _isolateEntry,
      _IsolateTaskBackgroundSound(sendPort: receivePort.sendPort, rootIsolateToken: rootIsolateToken),
      errorsAreFatal: false,
    );

    receivePort.listen((message) {
      if (message is SendPort) {
        _sendPort = message;
      }
    });
  }

  static void _isolateEntry(_IsolateTaskBackgroundSound task) {
    if (task.rootIsolateToken != null) {
      BackgroundIsolateBinaryMessenger.ensureInitialized(task.rootIsolateToken!);
    }
    MediaKit.ensureInitialized();
    final ReceivePort receivePort = ReceivePort();
    task.sendPort.send(receivePort.sendPort);
    _player = Player();
    receivePort.listen((message) async {
      if (message is _PortModel) {
        final enumMethod = IsolateBackgroundSoundMethod.values.firstWhere(
          (e) => e.name == message.method,
          orElse: () => IsolateBackgroundSoundMethod.playSoundEffect,
        );
        switch (enumMethod) {
          case IsolateBackgroundSoundMethod.playSoundEffect:
            final path = message.data;
            try {
              await _player?.open(Media('asset:///$path'));
              await _player?.play();
            } catch (e) {
              debugPrint('error: $e');
            } finally {
              message.sendPort?.send(null);
            }
            break;
        }
      }
    });
  }

  static Future<void> playSound(SoundType soundType) async {
    final bool? isTurnOnSoundEffect = AppGetStorage.instance.appStorage.read<bool>(GetStorageKey.kIsTurnOnSoundEffect);
    if (isTurnOnSoundEffect != null && !isTurnOnSoundEffect) {
      return;
    }
    final receivePort = ReceivePort();
    final assetSourcePath = _getAssetSourcePath(soundType);
    _sendPort?.send(
      _PortModel(method: IsolateBackgroundSoundMethod.playSoundEffect.name, data: assetSourcePath, sendPort: receivePort.sendPort),
    );
    await receivePort.first;
    receivePort.close();
  }

  static String _getAssetSourcePath(SoundType soundType) {
    switch (soundType) {
      case SoundType.correctAnswer:
        return 'assets/media/audio/correct_answer.mp3';
      case SoundType.wrongAnswer:
        return 'assets/media/audio/wrong_answer.mp3';
    }
  }
}
