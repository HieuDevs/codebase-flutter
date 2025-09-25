import 'package:codebase/core/storage/get_storage_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final themeMode = AppGetStorage.instance.appStorage.read<String>(GetStorageKey.kThemeMode) ?? 'system ';
    return themeMode == 'dark'
        ? ThemeMode.dark
        : themeMode == 'light'
        ? ThemeMode.light
        : ThemeMode.system;
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    AppGetStorage.instance.appStorage.write(GetStorageKey.kThemeMode, mode.name);
  }

  void toggleTheme() {
    switch (state) {
      case ThemeMode.light:
        state = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        state = ThemeMode.system;
        break;
      case ThemeMode.system:
        state = ThemeMode.light;
        break;
    }
    AppGetStorage.instance.appStorage.write(GetStorageKey.kThemeMode, state.name);
  }

  bool get isDarkMode {
    switch (state) {
      case ThemeMode.light:
        return false;
      case ThemeMode.dark:
        return true;
      case ThemeMode.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
    }
  }
}
