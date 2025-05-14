import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/common/state.dart';
import 'package:movieapp/core/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movieapp/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movieapp/features/movie/presentation/bloc/movie_event.dart';


class MovieRecommendationContainer extends StatelessWidget {
  final String imageUrl;
  final int movieId;

  const MovieRecommendationContainer({
    super.key,
    required this.imageUrl,
    required this.movieId,
      
    
  });

  @override
  Widget build(BuildContext context) {
    MoviePageState movieState = MoviePageState();
    return GestureDetector(
      onTap: () {
         context.read<MovieBloc>().add(GetAllMovieDetailsEvent(movieId));
          movieState.id = 1;
          context.go('/movie/$movieId',extra: movieState);
      },
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity(),
        child: ClipPath(
          clipper:
              ParallelogramClipper(borderRadius: 20), // Ajout du radius ici
          child: Container(
            width: 145,
            //height: 201.43,
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) =>  Center(
                child: CircularProgressIndicator(
                  color: AppColors.neonAqua,
                ),
              ),
              errorWidget: (context, url, error) => Center(
                child: Icon(Icons.error, color: Colors.grey.shade400, size: 50),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ParallelogramClipper extends CustomClipper<Path> {
  final double borderRadius;

  ParallelogramClipper({this.borderRadius = 10});

  @override
  Path getClip(Size size) {
    Path path = Path();
    double offset = 15; // Décalage pour créer l'effet de parallélogramme
    double r = borderRadius; // Rayon des coins arrondis

    path.moveTo(offset + r, 0);
    path.lineTo(size.width - r, 0);
    path.quadraticBezierTo(
        size.width, 0, size.width, r); // Arrondi en haut à droite

    path.lineTo(size.width - offset, size.height - r);
    path.quadraticBezierTo(size.width - offset, size.height,
        size.width - offset - r, size.height); // Arrondi en bas à droite

    path.lineTo(r, size.height);
    path.quadraticBezierTo(
        0, size.height, 0, size.height - r); // Arrondi en bas à gauche

    path.lineTo(offset, r);
    path.quadraticBezierTo(
        offset, 0, offset + r, 0); // Arrondi en haut à gauche

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
