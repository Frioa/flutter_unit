import 'package:flutter/material.dart';

class StrokeCapPainter extends CustomPainter {
  void drawStrokeCap(Canvas canvas, Size size) {
    Paint paint = Paint();
    final start = 25.0;

    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    canvas.drawLine(
      Offset(start, start),
      Offset(start, start * 2.5),
      paint..strokeCap = StrokeCap.butt,
    );
    canvas.drawLine(
      Offset(start + start, start),
      Offset(start + start, start * 2.5),
      paint..strokeCap = StrokeCap.round,
    );
    canvas.drawLine(
      Offset(start + start * 2, start),
      Offset(start + start * 2, start * 2.5),
      paint..strokeCap = StrokeCap.square,
    );
    canvas.drawLine(
      Offset(0.0, start),
      Offset(size.width, start),
      paint
        ..isAntiAlias = false
        ..strokeWidth = 1
        ..color = Colors.lightBlueAccent,
    );
    canvas.drawLine(
      Offset(0.0, start * 2.5),
      Offset(size.width, start * 2.5),
      paint
        ..isAntiAlias = false
        ..strokeWidth = 1
        ..color = Colors.lightBlueAccent,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawStrokeCap(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
