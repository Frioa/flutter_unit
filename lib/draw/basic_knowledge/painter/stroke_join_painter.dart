import 'package:flutter/material.dart';

class StrokeJoinPainter extends CustomPainter {
  void drawStrokeJoin(Canvas canvas) {
    Paint paint = Paint();
    Path path = Path();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    path.moveTo(25, 25);
    path.lineTo(25, 75);
    path.relativeLineTo(50, -25);
    path.relativeLineTo(0, 50);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.bevel);

    path.reset();
    path.moveTo(25 + 75.0, 25);
    path.lineTo(25 + 75.0, 75);
    path.relativeLineTo(50, -25);
    path.relativeLineTo(0, 50);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.miter);

    path.reset();
    path.moveTo(25 + 75.0 * 2, 25);
    path.lineTo(25 + 75.0 * 2, 75);
    path.relativeLineTo(50, -25);
    path.relativeLineTo(0, 50);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.round);
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawStrokeJoin(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
