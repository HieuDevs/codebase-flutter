import 'package:lua/core/common/constants.dart';

import 'package:lua/core/extensions/iterable.dart';

import 'package:lua/core/l10n/app_localizations/app_localizations.dart';

import 'package:lua/core/providers/locale_provider.dart';
import 'package:lua/core/providers/theme_provider.dart';
import 'package:lua/core/routes/props.dart';
import 'package:lua/core/routes/routes.dart';
import 'package:lua/core/routes/app_navigator.dart';
import 'package:lua/shared/resources/theme.dart';
import 'package:lua/features/home/presentation/home_page.dart';
import 'package:lua/features/auth/auth_page.dart';
import 'package:lua/features/splash/splash_page.dart';
import 'package:lua/utils/language_utils.dart';
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
              onUnknownRoute: (settings) =>
                  MaterialPageRoute(builder: (context) => SplashPage(props: NoProps())),
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
                return locales!.firstWhere(
                  supportedLocales.contains,
                  orElse: () => LanguageUtils.getDefaultLocale(),
                );
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
