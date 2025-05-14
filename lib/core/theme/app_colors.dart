import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Couleurs néon principales
  static const Color neonAqua = Color(0xFF09FBD3);
  static const Color neonBlue = Color(0xFF08F7FE);
  static const Color neonPink = Color(0xFFFE53BB);
  static const Color neonPurple = Color(0xFF9E95C4);
  static const Color neonBlueTrans = Color(0xFF6AB9CA);
  
  // Couleurs de base
  static const Color darkBackground = Color(0xFF19191B);
  static const Color ratingOrange = Color(0xFFF2A33A);

  // Nouvelle palette Material adaptée aux néons
  static const MaterialColor primary = MaterialColor(
    0xFF09FBD3,
    <int, Color>{
      50: Color(0xFFE0FFFA),
      100: Color(0xFFB3FFF4),
      200: neonAqua,
      300: Color(0xFF80FBE0),
      400: Color(0xFF4DF7CC),
      500: Color(0xFF09FBD3),
      600: Color(0xFF07D9B8),
      700: Color(0xFF06B79D),
      800: Color(0xFF049582),
      900: Color(0xFF037367),
    },
  );

  static const MaterialColor secondary = MaterialColor(
    0xFF08F7FE,
    <int, Color>{
      50: Color(0xFFDDFEFF),
      100: Color(0xFFB3FDFF),
      200: neonBlue,
      300: Color(0xFF80F3FE),
      400: Color(0xFF4DEAFE),
      500: Color(0xFF08F7FE),
      600: Color(0xFF07D5E0),
      700: Color(0xFF06B3C2),
      800: Color(0xFF0591A4),
      900: Color(0xFF046F86),
    },
  );

  static const MaterialColor tertiary = MaterialColor(
    0xFFFE53BB,
    <int, Color>{
      50: Color(0xFFFFE5F4),
      100: Color(0xFFFFCCE9),
      200: neonPink,
      300: Color(0xFFFE3AA8),
      400: Color(0xFFFE2795),
      500: Color(0xFFFE53BB),
      600: Color(0xFFE04AA7),
      700: Color(0xFFC24193),
      800: Color(0xFFA4387F),
      900: Color(0xFF862F6B),
    },
  );

  // Configuration des thèmes
  static ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    secondary: secondary,
    tertiary: tertiary,
    surface: Colors.white,
    error: Color(0xFFB00020),
    onPrimary: darkBackground,
    onSecondary: darkBackground,
    onTertiary: darkBackground,
    onSurface: darkBackground,
    onError: Colors.white,
  );

  static ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primary[200]!,
    secondary: secondary[200]!,
    tertiary: tertiary[200]!,
    surface: darkBackground,
    error: Color(0xFFCF6679),
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onTertiary: Colors.black,
    onSurface: Colors.white,
    onError: Colors.black,
  );

  // Couleurs spécialisées
  static LinearGradient neonGradientAvatar = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      neonPink.withOpacity(1),
      neonPurple.withOpacity(0.050),
      neonBlueTrans.withOpacity(0.050),
      neonAqua,
    ],
    stops: [0.0, 0.43, 0.64, 1.0]
  );

   static LinearGradient  neonGradientBorder = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      neonPink.withOpacity(1),
      neonAqua,
    ],
  );

  static LinearGradient  haloGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      darkBackground
    ],
  );

  static const Color ratingColor = ratingOrange;
}
