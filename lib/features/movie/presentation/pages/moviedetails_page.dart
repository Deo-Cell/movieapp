import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/common/state.dart';
import 'package:movieapp/core/theme/app_sizes.dart';
import 'package:movieapp/core/theme/app_colors.dart';
import 'package:movieapp/core/common/text_component.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movieapp/core/utils/extensions/hour_extension.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movieapp/features/movie/presentation/bloc/movie_bloc.dart';
import 'package:movieapp/features/movie/presentation/bloc/movie_event.dart';
import 'package:movieapp/features/movie/presentation/bloc/movie_state.dart';
import 'package:movieapp/features/movie/presentation/widgets/cast_widget.dart';
import 'package:movieapp/features/movie/presentation/widgets/movierating_widget.dart';

class MoviedetailsPage extends StatefulWidget {
  final int movieId;
  const MoviedetailsPage({super.key, required this.movieId});

  @override
  State<MoviedetailsPage> createState() => _MoviedetailsPageState();
}

class _MoviedetailsPageState extends State<MoviedetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  bool animate = true;
  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
          if (state is MovieLoading) {
            return Stack(
              children: [
                Container(
                  color: Colors.transparent,
                  child: Center(
                    child: LoadingAnimationWidget.inkDrop(
                      color: AppColors.neonAqua,
                      size: 100,
                    ),
                  ),
                ),
              ],
            );
          }
          if (state is MovieDetailsComplete) {
            final movie = state.movieDetails;
            return Stack(
              children: [
                Stack(children: [
                  SizedBox(
                    //width: 424,
                    height: 422,
                    child: FadeInUp(
                      from: 20,
                      animate: animate,
                      controller: (controller) => controller = controller,
                      delay: const Duration(milliseconds: 200),
                      child: CachedNetworkImage(
                      imageUrl: movie.backdropUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white54,
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.error,
                            color: Colors.grey.shade400, size: 50),
                      ),
                                            ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.12),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 28, top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            setState(() {
                              animate = !animate;
                            });
                            await Future.delayed(
                                const Duration(milliseconds: 620));
                            final movie = GoRouterState.of(context).extra
                                as MoviePageState;
                            if (movie.id == 0) {
                              context
                                  .read<MovieBloc>()
                                  .add(GetAllMoviesEvent());
                              context.go('/home');
                            } else if (movie.id == 1) {
                              context.go('/chatai');
                            }
                          }
                        },
                        child: Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            child: Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24,
                              ),
                            )),
                      ),
                      Container(
                          height: 45,
                          width: 44,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 1)),
                          child: Center(
                            child: Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 24,
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: AppScreenSize.screenheight(context) * 0.4,
                        left: AppScreenSize.screenwidth(context) * 0.12,
                        right: AppScreenSize.screenwidth(context) * 0.09),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: FittedBox(
                            fit: BoxFit
                                .scaleDown, // Réduit la taille si nécessaire
                            child: FadeInUp(
                              from: 60,
                              animate: animate,
                              controller: (controller) =>
                                  controller = controller,
                              delay: const Duration(milliseconds: 350),
                              child: TextComponent(
                                "${movie.title}",
                                textcolor: Colors.white.withOpacity(0.85),
                                fontfamily: 'OpenSans',
                                fontsize: 24,
                                fontweight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeInUp(
                          from: 70,
                          animate: animate,
                          controller: (controller) => controller = controller,
                          delay: const Duration(milliseconds: 450),
                          child: TextComponent(
                            "${movie.reldate} • ${movie.genres?.take(3).join(' • ')} • ${movie.runtime!.toFormattedString()}",
                            textcolor: Colors.white.withOpacity(0.75),
                            fontfamily: 'OpenSans',
                            fontsize: 13,
                            fontweight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeInUp(
                          from: 80,
                          animate: animate,
                          controller: (controller) => controller = controller,
                          delay: const Duration(milliseconds: 550),
                          child: MovieRatingWidget(
                            voteAverage: movie.voteAverage!,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 550,
                          child: FadeInUp(
                            from: 90,
                            animate: animate,
                            controller: (controller) => controller = controller,
                            delay: const Duration(milliseconds: 650),
                            child: TextComponent(
                              "${movie.overview}",
                              textcolor: Colors.white.withValues(alpha: 0.75),
                              fontfamily: 'OpenSans',
                              fontsize: 14,
                              fontweight: FontWeight.w400,
                              textAlign: TextAlign.center,
                              expandable: false,
                              initialMaxLines: 4,
                              expandText: 'Voir plus',
                              collapseText: 'Voir moins',
                            ),
                          ),
                        ),
                        const SizedBox(height: 26),
                        Divider(
                          color: Colors.white.withValues(alpha: 0.15),
                        )
                      ],
                    )),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: AppScreenSize.screenheight(context) * 0.3,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black, AppColors.darkBackground],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 1])),
                  ),
                ),
                Positioned(
                  bottom: AppScreenSize.screenheight(context) * 0.24,
                  right: 0,
                  left: 20,
                  child: TextComponent(
                    "Casts",
                    textcolor: Colors.white,
                    fontfamily: 'OpenSans',
                    fontsize: 20,
                    fontweight: FontWeight.w700,
                  ),
                ),
                Positioned(
                    bottom: AppScreenSize.screenheight(context) * 0.16,
                    right: 5,
                    left: 18,
                    child: Row(
                      children: [
                        FadeInLeft(
                            animate: animate,
                            controller: (controller) => controller = controller,
                            delay: const Duration(milliseconds: 700),
                            child: buildCastSection(state.actors, 0)),
                        const SizedBox(width: 138),
                        FadeInRight(
                            animate: animate,
                            controller: (controller) => controller = controller,
                            delay: const Duration(milliseconds: 700),
                            child: buildCastSection(state.actors, 1)),
                        const SizedBox(width: 15),
                      ],
                    )),
                Positioned(
                    bottom: AppScreenSize.screenheight(context) * 0.05,
                    right: 24,
                    left: 18,
                    child: Row(
                      children: [
                        FadeInLeft(
                            animate: animate,
                            controller: (controller) => controller = controller,
                            delay: const Duration(milliseconds: 700),
                            child: buildCastSection(state.actors, 2)),
                        const SizedBox(width: 138),
                        FadeInRight(
                            animate: animate,
                            controller: (controller) => controller = controller,
                            delay: const Duration(milliseconds: 700),
                            child: buildCastSection(state.actors, 3)),
                      ],
                    )),
                Positioned(
                    top: AppScreenSize.screenheight(context) * 0.33,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        if (state.trailers.isNotEmpty) {
                          showTrailerPlayer(context, state.trailers[0].key!);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Aucun trailer disponible'),
                            ),
                          );
                        }
                      },
                      child: FadeInRight(
                        animate: animate,
                        controller: (controller) => controller = controller,
                        delay: const Duration(milliseconds: 700),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.35),
                            shape: BoxShape.circle,
                            border: GradientBoxBorder(
                              gradient: AppColors.neonGradientBorder,
                              width: 3,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            );
          }

          return Center(
            child: TextComponent(
              "Unable to load movies",
              textcolor: Colors.white,
            ),
          );
        }));
  }
}

void showTrailerPlayer(BuildContext context, String videoId) {
  final Size screenSize = MediaQuery.of(context).size;

  YoutubePlayerController controller = YoutubePlayerController(
    initialVideoId: videoId,
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
      controlsVisibleAtStart: false,
    ),
  );

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Trailer",
    barrierColor: Colors.black.withOpacity(0.8),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (_, __, ___) {
      return Material(
        type: MaterialType.transparency,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête avec titre et bouton de fermeture
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "BANDE-ANNONCE OFFICIELLE",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.close, color: Colors.white, size: 24),
                      ),
                    ),
                  ],
                ),
              ),

              // Lecteur YouTube avec container stylisé
              Container(
                width: screenSize.width,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.neonAqua.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                clipBehavior: Clip
                    .antiAlias, // Pour que le borderRadius s'applique au contenu
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Lecteur YouTube
                    YoutubePlayer(
                      controller: controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: AppColors.neonBlue,
                      progressColors: const ProgressBarColors(
                        playedColor: AppColors.neonAqua,
                        handleColor: AppColors.neonPink,
                      ),
                      onReady: () {
                        // Tu peux ajouter des actions spécifiques quand le lecteur est prêt
                      },
                    ),

                    // Overlay de chargement (disparaît quand la vidéo commence)
                  ],
                ),
              ),

              // Contrôles supplémentaires sous la vidéo

              // Afficher le temps actuel et la durée totale
            ],
          ),
        ),
      );
    },
    transitionBuilder: (_, animation, __, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        ),
      );
    },
  );
}

// Fonction utilitaire pour construire les boutons de contrôle
Widget _buildControlButton({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  bool isPrimary = false,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: isPrimary ? 60 : 44,
          width: isPrimary ? 60 : 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isPrimary
                ? AppColors.neonBlue.withOpacity(0.3)
                : Colors.white.withOpacity(0.1),
            border: isPrimary
                ? GradientBoxBorder(
                    gradient: AppColors.neonGradientBorder,
                    width: 2,
                  )
                : Border.all(color: Colors.white30, width: 1),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: AppColors.neonAqua.withOpacity(0.5),
                      blurRadius: 12,
                      spreadRadius: 0,
                    )
                  ]
                : null,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: isPrimary ? 28 : 20,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

// Fonction pour formater la durée en MM:SS
String _formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}
