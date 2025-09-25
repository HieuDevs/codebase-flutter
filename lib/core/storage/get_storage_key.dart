import 'package:codebase/core/common/constants.dart';
import 'package:get_storage/get_storage.dart';

abstract class GetStorageKey {
  static const kIsDarkMode = 'is_dark_mode';
  static const kIsTurnOnSoundEffect = 'is_turn_on_sound_effect';
  static const kIsTurnOnHapticFeedback = 'is_turn_on_haptic_feedback';
  static const kLocale = 'locale';
}

class AppGetStorage {
  static AppGetStorage? _instance;

  AppGetStorage._internal();

  static AppGetStorage get instance {
    _instance ??= AppGetStorage._internal();
    return _instance!;
  }

  GetStorage get appStorage => GetStorage(AppConstants.appGetStorage);
}
