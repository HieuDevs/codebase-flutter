import 'package:codebase/core/common/constants.dart';

import 'package:codebase/core/extensions/iterable.dart';

import 'package:codebase/core/l10n/app_localizations/app_localizations.dart';

import 'package:codebase/core/providers/locale_provider.dart';
import 'package:codebase/core/providers/theme_provider.dart';
import 'package:codebase/core/routes/props.dart';
import 'package:codebase/core/routes/routes.dart';
import 'package:codebase/core/routes/app_navigator.dart';
import 'package:codebase/shared/resources/theme.dart';
import 'package:codebase/features/home/home_page.dart';
import 'package:codebase/features/auth/auth_page.dart';
import 'package:codebase/features/splash/splash_page.dart';
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
              navigatorKey: AppNavigator.navigatorKey,
              onUnknownRoute: (settings) => MaterialPageRoute(builder: (context) => SplashPage(props: NoProps())),
              initialRoute: RouteNames.splash,
              onGenerateRoute: (settings) {
                final routeName = settings.name;
                final props = settings.arguments ?? NoProps();
                if (props is! RouteProps) {
                  throw Exception('Invalid props for route: $routeName');
                }
                switch (routeName) {
                  case RouteNames.splash:
                    return MaterialPageRoute(builder: (context) => SplashPage(props: props));
                  case RouteNames.home:
                    return MaterialPageRoute(builder: (context) => HomePage(props: props));
                  case RouteNames.auth:
                    return MaterialPageRoute(builder: (context) => AuthPage(props: props));
                  default:
                    return MaterialPageRoute(builder: (context) => SplashPage(props: props));
                }
              },
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
            );
          },
        ),
      ),
    );
  }
}
