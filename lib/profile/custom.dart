import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class CurveClipper extends CustomClipper<Path> {
  // Layer 1
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, 4 * size.height / 6);

    Offset curvePoint = Offset(size.width / 2, size.height);
    Offset endPoint = Offset(size.width, 4 * size.height / 6);

    path.quadraticBezierTo(
        curvePoint.dx, curvePoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
