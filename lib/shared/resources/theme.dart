import 'package:codebase/shared/resources/assets.dart';
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
  static const Color primaryPurple = Color(0xFF9C88FF);
  static const Color secondaryPurple = Color(0xFFB19CD9);
  static const Color accentPurple = Color(0xFFD4C5F9);
  static const Color lightPurple = Color(0xFFE8E0FF);
  static const Color darkPurple = Color(0xFF6B46C1);
  static const Color deepPurple = Color(0xFF4C1D95);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppAssets.fontMontserrat,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryPurple,
        brightness: Brightness.light,
        primary: primaryPurple,
        secondary: secondaryPurple,
        tertiary: accentPurple,
        surface: Colors.white,
        surfaceContainerHighest: lightPurple,
        onSurface: const Color(0xFF1A1A1A),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        error: const Color(0xFFE53E3E),
        onError: Colors.white,
        outline: const Color(0xFFE2E8F0),
        outlineVariant: const Color(0xFFF1F5F9),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Color(0xFF1A1A1A), fontSize: 20, fontWeight: FontWeight.w600),
        iconTheme: IconThemeData(color: Color(0xFF1A1A1A)),
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        shadowColor: primaryPurple.withValues(alpha: 0.1),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: primaryPurple.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryPurple,
          side: const BorderSide(color: primaryPurple, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryPurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightPurple.withValues(alpha: 0.3),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightPurple, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryPurple, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE53E3E), width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontWeight: extraBold, fontSize: 57),
        displayMedium: TextStyle(fontWeight: bold, fontSize: 45),
        displaySmall: TextStyle(fontWeight: semiBold, fontSize: 36),
        headlineLarge: TextStyle(fontWeight: semiBold, fontSize: 32),
        headlineMedium: TextStyle(fontWeight: medium, fontSize: 28),
        headlineSmall: TextStyle(fontWeight: medium, fontSize: 24),
        titleLarge: TextStyle(fontWeight: medium, fontSize: 22),
        titleMedium: TextStyle(fontWeight: medium, fontSize: 16),
        titleSmall: TextStyle(fontWeight: medium, fontSize: 14),
        bodyLarge: TextStyle(fontWeight: regular, fontSize: 16),
        bodyMedium: TextStyle(fontWeight: regular, fontSize: 14),
        bodySmall: TextStyle(fontWeight: regular, fontSize: 12),
        labelLarge: TextStyle(fontWeight: medium, fontSize: 14),
        labelMedium: TextStyle(fontWeight: medium, fontSize: 12),
        labelSmall: TextStyle(fontWeight: medium, fontSize: 11),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: AppAssets.fontMontserrat,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryPurple,
        brightness: Brightness.dark,
        primary: primaryPurple,
        secondary: secondaryPurple,
        tertiary: accentPurple,
        surface: const Color(0xFF1A1A1A),
        surfaceContainerHighest: const Color(0xFF2D2D2D),
        onSurface: const Color(0xFFE5E5E5),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        error: const Color(0xFFFC8181),
        onError: const Color(0xFF1A1A1A),
        outline: const Color(0xFF404040),
        outlineVariant: const Color(0xFF2D2D2D),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Color(0xFFE5E5E5), fontSize: 20, fontWeight: FontWeight.w600),
        iconTheme: IconThemeData(color: Color(0xFFE5E5E5)),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: const Color(0xFF2D2D2D),
        shadowColor: primaryPurple.withValues(alpha: 0.2),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple,
          foregroundColor: Colors.white,
          elevation: 3,
          shadowColor: primaryPurple.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryPurple,
          side: const BorderSide(color: primaryPurple, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryPurple,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2D2D2D),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF404040), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryPurple, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFC8181), width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontWeight: extraBold, fontSize: 57),
        displayMedium: TextStyle(fontWeight: bold, fontSize: 45),
        displaySmall: TextStyle(fontWeight: semiBold, fontSize: 36),
        headlineLarge: TextStyle(fontWeight: semiBold, fontSize: 32),
        headlineMedium: TextStyle(fontWeight: medium, fontSize: 28),
        headlineSmall: TextStyle(fontWeight: medium, fontSize: 24),
        titleLarge: TextStyle(fontWeight: medium, fontSize: 22),
        titleMedium: TextStyle(fontWeight: medium, fontSize: 16),
        titleSmall: TextStyle(fontWeight: medium, fontSize: 14),
        bodyLarge: TextStyle(fontWeight: regular, fontSize: 16),
        bodyMedium: TextStyle(fontWeight: regular, fontSize: 14),
        bodySmall: TextStyle(fontWeight: regular, fontSize: 12),
        labelLarge: TextStyle(fontWeight: medium, fontSize: 14),
        labelMedium: TextStyle(fontWeight: medium, fontSize: 12),
        labelSmall: TextStyle(fontWeight: medium, fontSize: 11),
      ),
    );
  }
}
