
import 'package:flutter/material.dart';

class Level1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        // 使用CustomPaint
        painter: _PaperPainter(),
      ),
    );
  }
}

class _PaperPainter extends CustomPainter {

  void drawIsAntiAliasColor(Canvas canvas) {
    Paint paint = Paint();
    canvas.drawCircle(
        Offset(180, 180),
        170,
        paint
          ..color = Colors.blue
          ..strokeWidth = 5);
    canvas.drawCircle(
        Offset(180 + 360.0, 180),
        170,
        paint
          ..isAntiAlias = false
          ..color = Colors.red);
  }

  void drawStyleStrokeWidth(Canvas canvas) {
    Paint paint =  Paint()..color=Colors.red;
    canvas.drawCircle(
        Offset(180, 180),
        150,
        paint
          ..style = PaintingStyle.stroke
          ..strokeWidth =50);
    canvas.drawCircle(
        Offset(180 + 360.0, 180),
        150,
        paint
          ..strokeWidth =50
          ..style = PaintingStyle.fill);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // drawIsAntiAliasColor(canvas);
    drawStyleStrokeWidth(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}