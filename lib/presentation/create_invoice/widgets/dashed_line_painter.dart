import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpacing;

  const DashedLinePainter({
    required this.color,
    this.dashWidth = 4,
    this.dashSpacing = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1
          ..style = PaintingStyle.stroke;

    double startX = 0;
    final y = size.height / 2;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), paint);
      startX += dashWidth + dashSpacing;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
