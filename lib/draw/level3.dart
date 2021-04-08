import 'dart:math';

import 'package:flutter/material.dart';

class Level3 extends StatelessWidget {
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
  late Paint _gridPint; // 画笔
  final double step = 20; // 小格边长
  final double strokeWidth = .5; // 线宽
  final Color color = Colors.grey; // 线颜色

  _PaperPainter() {
    _gridPint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  void drawCircle(Canvas canvas, Size size) {
    canvas.restore();
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;
    // 画布起点移到屏幕中心
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(Offset(0, 0), 50, paint);
    canvas.drawLine(
        Offset(20, 20),
        Offset(50, 50),
        paint
          ..color = Colors.red
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);
    canvas.save();
  }

  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();
    for (double i = size.height / 2; i < size.height; i += step) {
      canvas.drawLine(Offset.zero, Offset(size.width, 0), _gridPint);
      canvas.translate(0, step);
    }
    canvas.restore();

    canvas.save();
    for (double i = size.width / 2; i < size.width; i += step) {
      canvas.drawLine(Offset.zero, Offset(0, size.height), _gridPint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  void _drawDot(Canvas canvas, Size size) {
    final int count = 12;
    final paint = Paint()
      ..color = Colors.orangeAccent
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;
    canvas.save();
    // canvas.translate(size.width / 2, size.height / 2);

    for (int i = 0; i < count; i++) {
      canvas.drawLine(Offset(80, 0), Offset(100, 0), paint);
      canvas.rotate(2 * pi / 12);
    }

    canvas.restore();
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    _drawBottomRight(canvas, size);

    canvas.save();
    canvas.scale(1, -1); //沿x轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();
    //
    canvas.save();
    canvas.scale(-1, -1); //沿x轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();
    //
    //
    canvas.save();
    canvas.scale(-1, 1); //沿x轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    drawCircle(canvas, size);
    _drawDot(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
