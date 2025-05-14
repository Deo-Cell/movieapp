import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';

Widget buildCustomFAB({required VoidCallback onTap}) {
  
  final double fabSize = 70.0; // Larger size for FAB
  return Transform.translate(
      offset: const Offset(0, 22), // Adjust this value to move FAB down
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: fabSize,
          height: fabSize,
          decoration: BoxDecoration(
              shape: BoxShape.circle, gradient: AppColors.neonGradientBorder),
          child: Padding(
            padding: const EdgeInsets.all(3.4),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.darkBackground.withValues(alpha: 0.8),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 44),
            ),
          ),
        ),
      ));
}
