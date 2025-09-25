import 'package:codebase/core/common/constants.dart';

import 'package:codebase/core/extensions/iterable.dart';

import 'package:codebase/core/l10n/app_localizations/app_localizations.dart';

import 'package:codebase/core/providers/locale_provider.dart';
import 'package:codebase/core/providers/theme_provider.dart';
import 'package:codebase/shared/resources/theme.dart';
import 'package:codebase/features/home/homepage.dart';
import 'package:codebase/utils/language_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.translucent,
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(360, 690),
        child: Consumer(
          builder: (context, ref, child) {
            return MaterialApp(
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback: (locale, supportedLocales) =>
                  supportedLocales.contains(locale) ? locale : LanguageUtils.getDefaultLocale(),
              localeListResolutionCallback: (locales, supportedLocales) {
                if (locales.isNullOrEmpty()) return LanguageUtils.getDefaultLocale();
                return locales!.firstWhere(supportedLocales.contains, orElse: () => LanguageUtils.getDefaultLocale());
              },
              locale: ref.watch(localeProvider),
              themeMode: ref.watch(themeProvider),
              title: AppConstants.appName,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              home: const HomePage(),
            );
          },
        ),
      ),
    );
  }
}
