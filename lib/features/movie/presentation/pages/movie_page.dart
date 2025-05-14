import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/common/toast.dart';
import 'package:movieapp/core/theme/app_sizes.dart';
import 'package:movieapp/core/theme/app_colors.dart';
import 'package:movieapp/core/common/text_component.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movieapp/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movieapp/features/movie/presentation/bloc/movie_state.dart';
import 'package:movieapp/features/movie/presentation/widgets/movie_card.dart';
import 'package:movieapp/features/movie/presentation/widgets/searchbar_widget.dart';
import 'package:movieapp/features/movie/presentation/widgets/gradient_circle_widget.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieBloc, MovieState>(
      listener: (context, state) {
        if (state is MovieError) {
          CustomToast.showError(context, message: state.error);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            _buildBackground(),
            _buildContent(context, state),
          
          ],
        );
      },
    );
  }

  Widget _buildBackground() {
    return Stack(children: [
      // Votre code de fond existant reste le même
      Positioned(
        top: -75,
        left: -190,
        child: buildGradientCircle(320, 380, AppColors.neonAqua),
      ),
      Positioned(
        bottom: 280,
        right: -270,
        child: buildGradientCircle(400, 480, AppColors.neonPink),
      ),
      Positioned(
          bottom: -50,
          left: -10,
          child: buildGradientCircle(200, 200, AppColors.neonBlue)),
      Positioned(
          bottom: 80,
          left: 180,
          child: buildGradientCircle(40, 40, AppColors.neonAqua,
              linearGradient: AppColors.neonGradientBorder)),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: Container(color: Colors.black.withOpacity(0.1)),
      ),
    ]);
  }

  Widget _buildContent(BuildContext context, MovieState state) {
    if (state is MovieLoading) {
      return Center(
        child: LoadingAnimationWidget.inkDrop(
          color: AppColors.neonAqua,
          size: 100,
        ),
      );
    }

    if (state is AllMoviesLoaded) {
      return SingleChildScrollView(
        // Ajout d'un SingleChildScrollView ici
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: AppSpacing.sectionGap2),
              TextComponent(
                "What would you\n\t\tlike to watch ?",
                fontsize: AppFontSize.subhead,
                textcolor: Colors.white,
                fontfamily: 'OpenSans',
                fontweight: FontWeight.w700,
              ),
              SizedBox(height: AppSpacing.sectionGap),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SearchBarWidget(),
              ),
              SizedBox(height: AppSpacing.sectionGap),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, bottom: AppSpacing.sectionGap),
                child: Row(
                  children: [
                    TextComponent(
                      "New movies",
                      textcolor: Colors.white,
                      fontsize: 17,
                      fontfamily: 'OpenSans',
                      fontweight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.nowPlayingMovies.length,
                  itemBuilder: (context, index) {
                    final movie = state.nowPlayingMovies[index];
                    return FadeInUp(
                      from: 50,
                       controller: (controller) => controller = controller,
                      delay: const Duration(milliseconds: 300),
                      child: MoviePosterContainer(
                        imageUrl: movie.posterUrl,
                        movieId: movie.id!,
                      
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: AppSpacing.sectionGap),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, bottom: AppSpacing.sectionGap - 10),
                child: Row(
                  children: [
                    TextComponent(
                      "Upcoming movies",
                      textcolor: Colors.white,
                      fontsize: 17,
                      fontfamily: 'OpenSans',
                      fontweight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.upcomingMovies.length,
                  itemBuilder: (context, index) {
                    final movie = state.upcomingMovies[index];
                    return FadeInUp(
                      from: 50,
                       controller: (controller) => controller = controller,
                      delay: const Duration(milliseconds: 300),
                      child: MoviePosterContainer(
                        imageUrl: movie.posterUrl,
                        movieId: movie.id!,
                      
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: AppSpacing.sectionGap),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, bottom: AppSpacing.sectionGap - 10),
                child: Row(
                  children: [
                    TextComponent(
                      "Popular movies",
                      textcolor: Colors.white,
                      fontsize: 17,
                      fontfamily: 'OpenSans',
                      fontweight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.popularMovies.length,
                  itemBuilder: (context, index) {
                    final movie = state.popularMovies[index];
                    return FadeInUp(
                      from: 50,
                       controller: (controller) => controller = controller,
                      delay: const Duration(milliseconds: 300),
                      child: MoviePosterContainer(
                        imageUrl: movie.posterUrl,
                        movieId: movie.id!,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: AppSpacing.sectionGap),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, bottom: AppSpacing.sectionGap - 10),
                child: Row(
                  children: [
                    TextComponent(
                      "Toprated movies",
                      textcolor: Colors.white,
                      fontsize: 17,
                      fontfamily: 'OpenSans',
                      fontweight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.topRatedMovies.length,
                  itemBuilder: (context, index) {
                    final movie = state.topRatedMovies[index];
                    return FadeInUp(
                      from: 50,
                       controller: (controller) => controller = controller,
                      delay: const Duration(milliseconds: 300),
                      child: MoviePosterContainer(
                        imageUrl: movie.posterUrl,
                        movieId: movie.id!,
                      
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: AppSpacing.sectionGap * 4),
            ],
          ),
        ),
      );
    }

    // Gestion de l'état initial ou des erreurs
    return Center(
      child: TextComponent(
        "Unable to load movies",
        textcolor: Colors.white,
      ),
    );
  }
}
