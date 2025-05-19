import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  CurvePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path();
    for (int i = 0; i < 5; i++) {
      path.moveTo(0, size.height * 0.2 * i);
      path.quadraticBezierTo(
        size.width * 0.3,
        size.height * 0.25 * i,
        size.width,
        size.height * 0.2 * i,
      );
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
