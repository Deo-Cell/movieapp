import 'app_sizes.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  // Déclaration des familles de polices
  static const String openSans = 'OpenSans';
  static const String inter = 'Inter';

  // Styles de base
  static  TextStyle _baseStyle({
    required String fontFamily,
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
    double letterSpacing = 0.0,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  // Styles pour OpenSans
  static TextStyle openSansDisplayLarge = _baseStyle(
    fontFamily: openSans,
    fontSize: AppFontSize.heroTitle,
    fontWeight: FontWeight.w900,
  );

  static TextStyle openSansBodyMedium = _baseStyle(
    fontFamily: openSans,
    fontSize: AppFontSize.headline,
  );

  // Styles pour Inter
  static TextStyle interDisplayLarge = _baseStyle(
    fontFamily: inter,
    fontSize: AppFontSize.heroTitle,
    fontWeight: FontWeight.w900,
  );

  static TextStyle interBodyMedium = _baseStyle(
    fontFamily: inter,
    fontSize: AppFontSize.caption,
  );

  // Styles thématiques
  static TextStyle get appBarTitle => interDisplayLarge.copyWith(
        fontSize: AppFontSize.subhead,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get buttonLabel => openSansBodyMedium.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
      );

  static TextStyle get inputFieldText => interBodyMedium.copyWith(
        color: Colors.grey[800],
      );

  // Extensions pour le responsive (optionnel)
  static TextStyle responsiveStyle({
    required BuildContext context,
    required TextStyle baseStyle,
  }) {
    final scaleFactor = MediaQuery.of(context).textScaler.scale(1.0);
    return baseStyle.copyWith(fontSize: baseStyle.fontSize! * scaleFactor);
  }
}