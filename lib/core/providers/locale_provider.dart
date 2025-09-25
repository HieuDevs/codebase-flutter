import 'package:codebase/utils/language_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(LocaleNotifier.new);

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
