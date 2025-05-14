import 'package:flutter/material.dart';

class FixedSizeNotchedShape extends NotchedShape {
  final double gap;
  final double notchSize;

  const FixedSizeNotchedShape({this.gap = 8.0, this.notchSize = 60.0});

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    if (guest == null || !host.overlaps(guest)) {
      return Path()..addRect(host);
    }

    final fixedGuest = Rect.fromCenter(
      center: guest.center,
      width: notchSize,
      height: notchSize,
    );

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(host, Radius.circular(0)));

    final circleOffset = Offset(0, gap);
    final circlePath = Path()
      ..addOval(
        Rect.fromCenter(
          center: fixedGuest.center + circleOffset,
          width: fixedGuest.width * 1.3,
          height: fixedGuest.height * 1.3,
        ),
      );

    return Path.combine(PathOperation.difference, path, circlePath);
  }
}
