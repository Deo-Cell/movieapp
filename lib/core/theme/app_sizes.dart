import 'package:flutter/material.dart';
// Tailles de texte avec nommage UI-driven

class AppFontSize {
  AppFontSize._();

  // Échelle typographique principale
  static const double appBarTitle = 21.0;
  static const double headline = 34.0;
  static const double subhead = 28.0;
  static const double body = 16.0;
  static const double caption = 14.0;
  static const double overline = 12.0;

  // Cas spécifiques
  static const double heroTitle = 45.0;
  static const double cardTitle = 21.0;
  static const double buttonLabel = 16.0;
  static const double inputFieldText = 17.0;
  static const double letterSpacingWide = 1.5;
}

// Espacements systématiques (basés sur 4dp grid)
class AppSpacing {
  AppSpacing._();

  static const double baseUnit = 4.0;

  // Espacements verticaux
  static const double sectionGap = 32.0;
  static const double sectionGap2 = 44.0;
  static const double cardPadding = 16.0;
  static const double inputFieldPadding = 12.0;
  static const double buttonPadding = 8.0;

  // Séparateurs horizontaux
  static const double widgetGap = 16.0;
  static const double iconTextGap = 8.0;
}

// Rayons de bordure avec sémantique UI
class AppCorners {
  AppCorners._();

  static const double button = 8.0;
  static const double card = 12.0;
  static const double dialog = 24.0;
  static const double fab = 16.0;
  static const double chip = 20.0;
  static const double fullCircle = 360.0;
}

// Système d'icônes hiérarchisé
class AppIcons {
  AppIcons._();

  static const double navbar = 24.0;
  static const double listItem = 20.0;
  static const double floatingActionButton = 36.0;
  static const double inlineIndicator = 16.0;
  static const double avatar = 48.0;
}

class AppScreenSize {
  AppScreenSize._();
  static  double screenwidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  static double screenheight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

// Bonus : Gestion responsive
class Responsive {
  Responsive._();

  static double scaleFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 600 ? 1.0 : 1.2;
  }

  static double responsiveSize(double baseSize, BuildContext context) {
    return baseSize * scaleFactor(context);
  }
}