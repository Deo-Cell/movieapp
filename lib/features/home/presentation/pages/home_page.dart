import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movieapp/core/theme/app_colors.dart';
import 'package:movieapp/features/movie/presentation/pages/movie_page.dart';
import 'package:movieapp/features/home/presentation/widgets/fab_widget.dart';
import 'package:movieapp/features/home/presentation/widgets/bottombar_widget.dart';
import 'package:movieapp/features/movie/presentation/widgets/notchedshape_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      extendBody: true,
      body: MoviePage(),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
                child: Container(
                  height: 150,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),

          BottomAppBar(
            color: AppColors.neonBlue.withValues(alpha: 0.07),
            shape: const FixedSizeNotchedShape(gap: 22.0, notchSize: 60.0),
            notchMargin: 8,
            child: buildBottomNavBar(context),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildCustomFAB(onTap: () {
        context.go('/chatai');
      }),
    );
  }
}
