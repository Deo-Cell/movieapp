import 'package:flutter/material.dart';
import 'package:movieapp/core/common/text_component.dart';

class CustomNotchedContainer extends StatelessWidget {
  final String name;
  const CustomNotchedContainer({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        CustomPaint(
          size: Size(151, 65), // Taille du conteneur
          painter: NotchedPainter(),
        ),
        Padding(
            padding: EdgeInsets.only(top: 8, left: 58),
            child: TextComponent(
              name.split(' ')[0],
              textcolor: Colors.white,
              fontweight: FontWeight.w400,
              fontsize: 18,
              fontfamily: "OpenSans",
            )),
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 58),
          child: TextComponent(
            name.split(' ').length > 1
                ? name.split(' ')[1]
                : "", // Vérification sécurisée
            textcolor: Colors.white,
            fontweight: FontWeight.w400,
            fontsize: 18,
            fontfamily: "OpenSans",
          ),
        ),
      ]),
    );
  }
}

class NotchedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFFC4C4C4).withValues(alpha: 0.14);

    // Dessiner le rectangle arrondi
    Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(size.height / 2)));

    // Définir l'encoche circulaire
    Path circlePath = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(0, size.height / 2), radius: size.height / 1.87));

    // Soustraire l'encoche du rectangle
    Path finalPath = Path.combine(PathOperation.difference, path, circlePath);

    // Dessiner le résultat
    canvas.drawPath(finalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

void main() {
  runApp(MaterialApp(
      home: CustomNotchedContainer(
    name: "Rachel Zigler",
  )));
}
