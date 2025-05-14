import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_sizes.dart';

extension MediaQueryExt on BuildContext {
  MediaQueryData get mediaQueryData => MediaQuery.of(this);

  double get screenWidth => mediaQueryData.size.width;
  double get screenHeight => mediaQueryData.size.height;

  double scaleWidth(double factor) => screenWidth * factor;
  double scaleHeight(double factor) => screenHeight * factor;
}

extension TextScale on BuildContext {
  double get heroTitle => Responsive.responsiveSize(AppFontSize.heroTitle, this);
}
