import 'package:flutter/material.dart';

class RevenueWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Start at bottom left
    path.lineTo(0, size.height * 0.7);

    // Create revenue-like wave pattern
    final points = [
      // Short wave at start
      Offset(size.width * 0.1, size.height * 0.62),
      Offset(size.width * 0.2, size.height * 0.58),

      // Normal wave 1
      Offset(size.width * 0.4, size.height * 0.68),
      Offset(size.width * 0.55, size.height * 0.56),

      // Normal wave 2
      Offset(size.width * 0.7, size.height * 0.66),
      Offset(size.width * 0.82, size.height * 0.6),

      // Short wave at end
      Offset(size.width * 0.9, size.height * 0.64),
      Offset(size.width, size.height * 0.6),
    ];
    path.moveTo(0, size.height * 0.7);

    // Draw smooth curve through points
    for (var i = 0; i < points.length - 2; i++) {
      var xc = (points[i].dx + points[i + 1].dx) / 2;
      var yc = (points[i].dy + points[i + 1].dy) / 2;
      path.quadraticBezierTo(points[i].dx, points[i].dy, xc, yc);
    }

    // Connect last points
    path.quadraticBezierTo(
      points[points.length - 2].dx,
      points[points.length - 2].dy,
      points[points.length - 1].dx,
      points[points.length - 1].dy,
    );

    // Complete the path
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
