import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_sizes.dart';

Widget buildBottomNavBar(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Section gauche des icônes
          _buildNavBarSection([
            "home",
            "tv",
          ],
          context,
            isLeftSection: true,),
          // Espace pour le FAB
          const SizedBox(width: 80),
          // Section droite des icônes
          _buildNavBarSection([
            "card",
            "download",
          ],
          context,
            isLeftSection: false,
          ),
          // Section du FAB),
        ],
      ),
    );
  }

Widget _buildNavBarSection(List<String> svgPaths, BuildContext context, {bool isLeftSection = true}) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          svgPaths.length,
          (index) => Container(
            padding: EdgeInsets.only(
              // Add extra padding to push icons towards edges
              left: isLeftSection && index == 0 ? 0.0 : 16.0,
              right: !isLeftSection && index == svgPaths.length - 1 ? 0.0 : 11.0,
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/images/${svgPaths[index]}.svg",
                width: Responsive.responsiveSize(30, context),
                height: Responsive.responsiveSize(30, context),
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }