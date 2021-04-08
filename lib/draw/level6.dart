import 'dart:math';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/draw.dart';

class Level6 extends StatelessWidget {
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
  final _paint = Paint();

  void _drawFill(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.deepPurpleAccent
      ..style = PaintingStyle.fill;
    path
      ..moveTo(0, 0) //移至(0,0)点
      ..lineTo(60, 80) //从(0,0)画线到(60, 80) 点
      ..lineTo(60, 0) //从(60,80)画线到(60, 0) 点
      ..lineTo(0, -80) //从(60, 0) 画线到(0, -80)点
      ..close(); ///闭合路径
    // canvas.drawPath(path, paint);

    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    path
      ..moveTo(0, 0)
      ..lineTo(-60, 80)
      ..lineTo(-60, 0)
      ..lineTo(0, -80);
    canvas.drawPath(path, paint);
  }


  @override
  void paint(Canvas canvas, Size size) {
    drawTable(canvas, size);
    // _drawRect(canvas);
    // _drawRRect(canvas);
    // _drawFill(canvas);
    _drawFill(canvas);
  }


  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
