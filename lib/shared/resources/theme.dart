import 'package:lua/shared/resources/assets.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Font Weight Constants
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  static const Color white = Color(0xFFFFFFFF);
  static const Color black900 = Color(0xFF000000);
  static const Color gray900 = Color(0xFF1A1A1A);
  static const Color gray800 = Color(0xFF2D2D2D);
  static const Color gray700 = Color(0xFF3D3D3D);
  static const Color gray600 = Color(0xFF404040);
  static const Color gray500 = Color(0xFF4A4A4A);
  static const Color gray400 = Color(0xFF6B6B6B);
  static const Color gray300 = Color(0xFFA0A0A0);
  static const Color gray200 = Color(0xFFB8B8B8);
  static const Color gray150 = Color(0xFFD4D4D4);
  static const Color gray100 = Color(0xFFE5E5E5);
  static const Color gray50 = Color(0xFFE8E8E8);
  static const Color gray40 = Color(0xFFE2E8F0);
  static const Color gray30 = Color(0xFFF1F5F9);
  static const Color gray20 = Color(0xFFF5F5F5);
  static const Color gray10 = Color(0xFFFAFAFA);
  static const Color backgroundSecondary = Color(0xFFF2F2F7);
  static const Color errorLight = Color(0xFFE53E3E);
  static const Color errorLightContainer = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFFFC8181);
  static const Color errorDarkContainer = Color(0xFF5B1F1F);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppAssets.fontMontserrat,
      colorScheme: const ColorScheme.light(
        primary: gray900,
        onPrimary: white,
        primaryContainer: gray800,
        onPrimaryContainer: white,
        secondary: gray500,
        onSecondary: white,
        secondaryContainer: gray50,
        onSecondaryContainer: gray900,
        tertiary: gray400,
        onTertiary: white,
        tertiaryContainer: gray20,
        onTertiaryContainer: gray900,
        error: errorLight,
        onError: white,
        errorContainer: errorLightContainer,
        onErrorContainer: errorLight,
        surface: white,
        onSurface: gray900,
        surfaceContainerHighest: gray10,
        outline: gray40,
        outlineVariant: gray30,
        shadow: black900,
        scrim: black900,
        inverseSurface: gray900,
        onInverseSurface: white,
        inversePrimary: gray100,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: gray900, fontSize: 20, fontWeight: FontWeight.w600),
        iconTheme: IconThemeData(color: gray900),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: white,
        shadowColor: black900.withValues(alpha: 0.1),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: gray900,
          foregroundColor: white,
          elevation: 2,
          shadowColor: black900.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: gray900,
          side: const BorderSide(color: gray900, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: gray900,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: gray10,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: gray40, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: gray900, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorLight, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontWeight: extraBold, fontSize: 48, height: 1.2),
        displayMedium: TextStyle(fontWeight: bold, fontSize: 40, height: 1.2),
        displaySmall: TextStyle(fontWeight: semiBold, fontSize: 32, height: 1.25),
        headlineLarge: TextStyle(fontWeight: semiBold, fontSize: 28, height: 1.25),
        headlineMedium: TextStyle(fontWeight: medium, fontSize: 24, height: 1.3),
        headlineSmall: TextStyle(fontWeight: medium, fontSize: 20, height: 1.3),
        titleLarge: TextStyle(fontWeight: medium, fontSize: 20, height: 1.3),
        titleMedium: TextStyle(fontWeight: medium, fontSize: 18, height: 1.4),
        titleSmall: TextStyle(fontWeight: medium, fontSize: 16, height: 1.4),
        bodyLarge: TextStyle(fontWeight: regular, fontSize: 18, height: 1.5),
        bodyMedium: TextStyle(fontWeight: regular, fontSize: 17, height: 1.294),
        bodySmall: TextStyle(fontWeight: regular, fontSize: 14, height: 1.5),
        labelLarge: TextStyle(fontWeight: medium, fontSize: 14, height: 1.3),
        labelMedium: TextStyle(fontWeight: medium, fontSize: 12, height: 1.3),
        labelSmall: TextStyle(fontWeight: medium, fontSize: 10, height: 1.3),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppAssets.fontMontserrat,
      colorScheme: const ColorScheme.dark(
        primary: gray100,
        onPrimary: gray900,
        primaryContainer: gray150,
        onPrimaryContainer: gray900,
        secondary: gray200,
        onSecondary: gray900,
        secondaryContainer: gray700,
        onSecondaryContainer: gray100,
        tertiary: gray300,
        onTertiary: gray900,
        tertiaryContainer: gray800,
        onTertiaryContainer: gray100,
        error: errorDark,
        onError: gray900,
        errorContainer: errorDarkContainer,
        onErrorContainer: errorDark,
        surface: gray900,
        onSurface: gray100,
        surfaceContainerHighest: gray800,
        outline: gray600,
        outlineVariant: gray800,
        shadow: black900,
        scrim: black900,
        inverseSurface: gray100,
        onInverseSurface: gray900,
        inversePrimary: gray900,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: gray100, fontSize: 20, fontWeight: FontWeight.w600),
        iconTheme: IconThemeData(color: gray100),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: gray800,
        shadowColor: black900.withValues(alpha: 0.3),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: gray100,
          foregroundColor: gray900,
          elevation: 3,
          shadowColor: black900.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: gray100,
          side: const BorderSide(color: gray100, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: gray100,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: gray800,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: gray600, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: gray100, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorDark, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontWeight: extraBold, fontSize: 48, height: 1.2),
        displayMedium: TextStyle(fontWeight: bold, fontSize: 40, height: 1.2),
        displaySmall: TextStyle(fontWeight: semiBold, fontSize: 32, height: 1.25),
        headlineLarge: TextStyle(fontWeight: semiBold, fontSize: 28, height: 1.25),
        headlineMedium: TextStyle(fontWeight: medium, fontSize: 24, height: 1.3),
        headlineSmall: TextStyle(fontWeight: medium, fontSize: 20, height: 1.3),
        titleLarge: TextStyle(fontWeight: medium, fontSize: 20, height: 1.3),
        titleMedium: TextStyle(fontWeight: medium, fontSize: 18, height: 1.4),
        titleSmall: TextStyle(fontWeight: medium, fontSize: 16, height: 1.4),
        bodyLarge: TextStyle(fontWeight: regular, fontSize: 18, height: 1.5),
        bodyMedium: TextStyle(fontWeight: regular, fontSize: 17, height: 1.294),
        bodySmall: TextStyle(fontWeight: regular, fontSize: 14, height: 1.5),
        labelLarge: TextStyle(fontWeight: medium, fontSize: 14, height: 1.3),
        labelMedium: TextStyle(fontWeight: medium, fontSize: 12, height: 1.3),
        labelSmall: TextStyle(fontWeight: medium, fontSize: 10, height: 1.3),
      ),
    );
  }
}
