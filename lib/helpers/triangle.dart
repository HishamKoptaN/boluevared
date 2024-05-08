import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Color color;
  TrianglePainter(this.color);
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()..color = color;
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
