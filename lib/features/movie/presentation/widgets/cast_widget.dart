import 'package:flutter/material.dart';
import 'package:movieapp/core/theme/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movieapp/features/movie/data/models/actor_model.dart';
import 'package:movieapp/features/movie/presentation/widgets/castborder_widget.dart';

Widget buildCastSection(List<ActorModel> actors, int index) {
  if (index < 0 || index >= actors.length) {
    // Retourne un widget vide ou un fallback si l'index est invalide
    return const SizedBox();
  }
  return Stack(
    clipBehavior: Clip.none,
    children: [
       Positioned(
        top: -4,
        left: 35,
          child: CustomNotchedContainer(name: actors[index].name ?? "Unknown")),
      ClipOval(
        child: CachedNetworkImage(
          imageUrl: actors[index].posterUrl ?? '',
          height: 61,
          width: 61,
          fit: BoxFit.cover,
          placeholder: (context, url) =>  CircularProgressIndicator(
            color: AppColors.neonAqua,
          ),
          errorWidget: (context, url, error) =>
              const Icon(Icons.error, color: Colors.grey),
        ),
      ),
     
    ],
  );
}
