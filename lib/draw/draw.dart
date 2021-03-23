export 'paper.dart';
export 'level1.dart';
export 'level2.dart';
export 'level3.dart';
export 'level4.dart';
export 'level5.dart';

import 'package:flutter/material.dart';

final double strokeWidth = .5; // 线宽
final double step = 20; // 小格边长
final _gridPint = Paint()
  ..style = PaintingStyle.stroke
  ..strokeWidth = strokeWidth
  ..color = Colors.grey;

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

void _drawAxis(Canvas canvas, Size size) {
  final _paint = Paint()
    ..color = Colors.blue
    ..strokeWidth = 1.5;
  canvas.drawLine(Offset(-size.width / 2, 0), Offset(size.width / 2, 0), _paint);
  canvas.drawLine(Offset(0, -size.height / 2), Offset(0, size.height / 2), _paint);
  canvas.drawLine(Offset(0, size.height / 2), Offset(0 - 7.0, size.height / 2 - 10), _paint);
  canvas.drawLine(Offset(0, size.height / 2), Offset(0 + 7.0, size.height / 2 - 10), _paint);
  canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2 - 10, 7), _paint);
  canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2 - 10, -7), _paint);
}


void drawTable(Canvas canvas, Size size) {
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

  _drawAxis(canvas, size);
}
