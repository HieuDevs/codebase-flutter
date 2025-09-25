import 'package:codebase/app.dart';
import 'package:codebase/core/isolates/isolate_background_sound.dart';
import 'package:codebase/core/isolates/isolate_vibration.dart';
import 'package:codebase/entry.dart';
import 'package:codebase/core/common/constants.dart';
import 'package:flutter_isolate_worker/isolate_worker.dart';
import 'package:get_storage/get_storage.dart';

final isolatePool = IsolateWorkerPool(numIsolates: 2);

void main() async {
  await Future.wait([
    isolatePool.start(),
    GetStorage.init(AppConstants.appGetStorage),
    IsolateBackgroundSound.init(),
    IsolateBackgroundVibration.init(),
  ]);
  entry(app: const MyApp());
}
