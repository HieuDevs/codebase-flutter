import 'package:codebase/core/common/constants.dart';
import 'package:codebase/core/l10n/app_localizations/app_localizations.dart';

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
        child: MaterialApp(
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) => supportedLocales.contains(locale) ? locale : const Locale('en'),
          localeListResolutionCallback: (locales, supportedLocales) {
            if (locales?.isEmpty ?? true) return const Locale('en');
            return locales!.firstWhere(supportedLocales.contains, orElse: () => const Locale('en'));
          },
          locale: const Locale('en'),
          title: AppConstants.appName,
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Hello World'),
                  const SizedBox(height: 20),
                  ElevatedButton(onPressed: () {}, child: const Text('Button')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
