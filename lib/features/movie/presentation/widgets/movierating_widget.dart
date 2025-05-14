import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';

class MovieRatingWidget extends StatelessWidget {
  final double voteAverage;

  const MovieRatingWidget({super.key, required this.voteAverage});

  @override
  Widget build(BuildContext context) {
    int fullStars = (voteAverage / 2).floor();
    double remainder = voteAverage / 2 - fullStars;
    bool hasHalfStar = remainder >= 0.5;

    List<Widget> stars = [];

    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(
        Icons.star,
        color: AppColors.ratingColor,
        size: 14,
      ));
    }

    if (hasHalfStar) {
      stars.add(Icon(
        Icons.star_half,
        color: AppColors.ratingColor,
        size: 14,
      ));
    }

    int emptyStars = 5 - stars.length;
    for (int i = 0; i < emptyStars; i++) {
      stars.add(Icon(
        Icons.star_border,
        color: AppColors.ratingColor,
        size: 14,
      ));
    }

    return SizedBox(
      height: 14,
      width: 94,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: stars,
      ),
    );
  }
}
