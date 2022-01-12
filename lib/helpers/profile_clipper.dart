import 'package:flutter/material.dart';

class ProfileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, 4 * size.height / 5 - 15);

    path.arcToPoint(Offset(10, 4 * size.height / 5),
        radius: Radius.circular(15.0), clockwise: false);

    Offset curvePoint = Offset(size.width / 2, size.height);
    Offset endPoint = Offset(size.width - 10, 4 * size.height / 5);
    path.quadraticBezierTo(
      curvePoint.dx,
      curvePoint.dy,
      endPoint.dx,
      endPoint.dy,
    );

    path.arcToPoint(Offset(size.width, 4 * size.height / 5 - 15),
        radius: Radius.circular(15.0), clockwise: false);

    path.lineTo(size.width, 15);

    path.arcToPoint(Offset(size.width - 15, 0),
        radius: Radius.circular(15.0), clockwise: false);

    path.lineTo(15, 0);

    path.arcToPoint(Offset(0, 15),
        radius: Radius.circular(15.0), clockwise: false);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
