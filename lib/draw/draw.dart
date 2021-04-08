export 'paper.dart';
export 'level1.dart';
export 'level2.dart';
export 'level3.dart';
export 'level4.dart';
export 'level5.dart';
export 'level6.dart';
export 'radar_char_widget.dart';

import 'package:flutter/material.dart';

final double strokeWidth = .5; // 线宽
final double step = 25; // 小格边长
final _gridPint = Paint()
  ..style = PaintingStyle.stroke
  ..strokeWidth = strokeWidth
  ..color = Colors.grey.withOpacity(0.3);

void _drawBottomRight(Canvas canvas, Size size) {
  canvas.save();
  for (double i = size.height / 2; i < size.height; i += step) {
    canvas.drawLine(Offset.zero, Offset(size.width / 2, 0), _gridPint);
    canvas.translate(0, step);
  }
  canvas.restore();

  canvas.save();
  for (double i = size.width / 2; i < size.width; i += step) {
    canvas.drawLine(Offset.zero, Offset(0, size.height / 2), _gridPint);
    canvas.translate(step, 0);
  }
  canvas.restore();
}

void _drawAxis(Canvas canvas, Size size) {
  final _paint = Paint()
    ..color = Colors.blue.withOpacity(0.33)
    ..strokeWidth = 1.5;
  canvas.drawLine(Offset(-size.width / 2, 0), Offset(size.width / 2, 0), _paint);
  canvas.drawLine(Offset(0, -size.height / 2), Offset(0, size.height / 2), _paint);
  canvas.drawLine(Offset(0, size.height / 2), Offset(0 - 7.0, size.height / 2 - 10), _paint);
  canvas.drawLine(Offset(0, size.height / 2), Offset(0 + 7.0, size.height / 2 - 10), _paint);
  canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2 - 10, 7), _paint);
  canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2 - 10, -7), _paint);
}

void _drawText(Canvas canvas, Size size) {
  // y > 0 轴 文字
  canvas.save();
  for (int i = 0; i < size.height / 2 / step; i++) {
    if (step < 30 && i.isOdd || i == 0) {
      canvas.translate(0, step);
      continue;
    } else {
      var str = (i * step).toInt().toString();
      _drawAxisText(canvas, str, color: Colors.green);
    }
    canvas.translate(0, step);
  }
  canvas.restore();
  // x > 0 轴 文字
  canvas.save();
  for (int i = 0; i < size.width / 2 / step; i++) {
    if (i == 0) {
      _drawAxisText(canvas, "O", color: Colors.black);
      canvas.translate(step, 0);
      continue;
    }
    if (step < 30 && i.isOdd) {
      canvas.translate(step, 0);
      continue;
    } else {
      var str = (i * step).toInt().toString();
      _drawAxisText(canvas, str, color: Colors.green, x: true);
    }
    canvas.translate(step, 0);
  }
  canvas.restore();
  // y < 0 轴 文字
  canvas.save();
  for (int i = 0; i < size.height / 2 / step; i++) {
    if (step < 30 && i.isOdd || i == 0) {
      canvas.translate(0, -step);
      continue;
    } else {
      var str = (-i * step).toInt().toString();
      _drawAxisText(canvas, str, color: Colors.green);
    }
    canvas.translate(0, -step);
  }
  canvas.restore();
  // x < 0 轴 文字
  canvas.save();
  for (int i = 0; i < size.width / 2 / step; i++) {
    if (step < 30 && i.isOdd || i == 0) {
      canvas.translate(-step, 0);
      continue;
    } else {
      var str = (-i * step).toInt().toString();
      _drawAxisText(canvas, str, color: Colors.green, x: true);
    }
    canvas.translate(-step, 0);
  }
  canvas.restore();
}


// 定义成员变量
final TextPainter _textPainter = TextPainter(textDirection: TextDirection.ltr);
// 绘制方法


void _drawAxisText(Canvas canvas, String str,
    {Color color = Colors.black, bool x = false}) {
  TextSpan text = TextSpan(
      text: str,
      style: TextStyle(  fontSize: 11,  color: color ));
  _textPainter.text = text;
  _textPainter.layout(); // 进行布局

  Size size = _textPainter.size;
  Offset offset = Offset.zero;
  if (x) {
    offset = Offset(-size.width / 2, size.height / 2);
  } else {
    offset = Offset(size.height / 2, -size.height / 2 + 2);
  }
  _textPainter.paint(canvas, offset);
}

void drawTable(Canvas canvas, Size size) {
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

  _drawText(canvas, size);
}
