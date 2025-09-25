import 'package:codebase/utils/language_utils.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(() => LocaleNotifier());

class LocaleNotifier extends Notifier<Locale?> {
  @override
  Locale? build() {
    final locale = LanguageUtils.getSavedLocale();
    return locale;
  }

  void setLocale(Locale? locale) {
    state = locale;
    if (locale == null) {
      LanguageUtils.removeLocale();
      return;
    }
    LanguageUtils.saveLocale(locale);
  }
}
