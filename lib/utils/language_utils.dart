import 'dart:io';
import 'package:lua/core/l10n/app_localizations/app_localizations.dart';
import 'package:lua/core/storage/get_storage_key.dart';
import 'package:flutter/material.dart';

class LanguageUtils {
  static const Map<String, Map<String, String>> _languageNames = {
    'en': {'name': 'English', 'flag': '🇺🇸'},
    'vi': {'name': 'Tiếng Việt', 'flag': '🇻🇳'},
    'ja': {'name': '日本語', 'flag': '🇯🇵'},
    'ko': {'name': '한국어', 'flag': '🇰🇷'},
    'zh': {'name': '中文', 'flag': '🇨🇳'},
    'es': {'name': 'Español', 'flag': '🇪🇸'},
    'fr': {'name': 'Français', 'flag': '🇫🇷'},
    'de': {'name': 'Deutsch', 'flag': '🇩🇪'},
  };

  static Locale getDefaultLocale() {
    return const Locale('en', 'US');
  }

  static Locale getLocaleInSystemDevice() {
    final systemLocale = Platform.localeName;
    final languageCode = systemLocale.split('_')[0];
    final countryCode = systemLocale.contains('_') ? systemLocale.split('_')[1] : null;

    final deviceLocale = countryCode != null ? Locale(languageCode, countryCode) : Locale(languageCode);
    return deviceLocale;
  }

  static Locale getSavedLocale() {
    final locale = AppGetStorage.instance.appStorage.read<String>(GetStorageKey.kLocale);
    if (locale == null) {
      final deviceLocale = getLocaleInSystemDevice();
      return getClosestSupportedLocale(deviceLocale);
    }
    return getClosestSupportedLocale(Locale(locale));
  }

  static Locale getClosestSupportedLocale(Locale locale) {
    final supportedLocales = AppLocalizations.supportedLocales;
    return supportedLocales.contains(locale) ? locale : const Locale('en', 'US');
  }

  static Locale getLocaleByLanguageCode(String languageCode) {
    final supportedLocales = AppLocalizations.supportedLocales;
    final locale = supportedLocales.firstWhere((loc) => loc.languageCode == languageCode, orElse: () => getDefaultLocale());
    return locale;
  }

  static void saveLocale(Locale locale) {
    AppGetStorage.instance.appStorage.write(GetStorageKey.kLocale, locale.languageCode);
  }

  static void removeLocale() {
    AppGetStorage.instance.appStorage.remove(GetStorageKey.kLocale);
  }

  static String getLanguageName(String languageCode) {
    return _languageNames[languageCode]?['name'] ?? languageCode;
  }

  static String getLanguageFlag(String languageCode) {
    return _languageNames[languageCode]?['flag'] ?? languageCode;
  }
}
