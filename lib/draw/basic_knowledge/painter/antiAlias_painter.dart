import 'package:flutter/material.dart';


class AntiAliasPainter extends CustomPainter {
  void drawIsAntiAliasColor(Canvas canvas) {
    Paint paint = Paint();
    final r = 60.0;

    canvas.drawCircle(
      Offset(r, r),
      r,
      paint
        ..color = Colors.blue
        ..strokeWidth = 5,
    );
    canvas.drawCircle(
      Offset(r + 120.0 + 10, r),
      r,
      paint
        ..isAntiAlias = false
        ..color = Colors.red,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawIsAntiAliasColor(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}