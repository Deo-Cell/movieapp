import 'package:flutter/material.dart';

Widget buildGradientCircle(double width, double height, Color color,
    {LinearGradient? linearGradient}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: linearGradient ?? RadialGradient(
        colors: [color.withValues(alpha: 0.4), Colors.transparent],
        radius: 0.8,
      ),
    ),
  );
}
