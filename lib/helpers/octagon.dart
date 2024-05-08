import 'dart:math';
import 'package:flutter/material.dart';

class OctagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    size = const Size(300, 300);
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final double sideLength = size.width / sqrt(2 + sqrt(2));

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    final double radius = sideLength / (sqrt(2) + 1);

    final List<Offset> points = [];

    for (int i = 0; i < 8; i++) {
      final double angle = (i * 45) * (pi / 180.0);
      final double x = centerX + radius * cos(angle);
      final double y = centerY + radius * sin(angle);
      points.add(Offset(x, y));
    }

    final Path path = Path()..moveTo(points[0].dx, points[0].dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
