import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/draw.dart';

class Level4 extends StatelessWidget {
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

  final List<Offset> points = [
    Offset(-120, -20),
    Offset(-80, -80),
    Offset(-40, -40),
    Offset(0, -100),
    Offset(40, -140),
    Offset(80, -160),
    Offset(120, -100),
  ];

  _PaperPainter() {}

  void _drawPointsWithLines(Canvas canvas) {
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.lines, points, _paint);
  }

  void _drawPointLineWithPolygon(Canvas canvas) {
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.polygon, points, _paint);
  }

  void _drawRawPoints(Canvas canvas) {
    Float32List pos = Float32List.fromList(
        [-120, -20, -80, -80, -40, -40, 0, -100, 40, -140, 80, -160, 120, -100]);
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawRawPoints(PointMode.points, pos, _paint);
  }

  void _drawAxis(Canvas canvas, Size size) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(-size.width / 2, 0), Offset(size.width / 2, 0), _paint);
    canvas.drawLine(Offset(0, -size.height / 2), Offset(0, size.height / 2), _paint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(0 - 7.0, size.height / 2 - 10), _paint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(0 + 7.0, size.height / 2 - 10), _paint);
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2 - 10, 7), _paint);
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2 - 10, -7), _paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawTable(canvas, size);
    // _drawPointsWithLines(canvas);
    _drawAxis(canvas, size);

    _drawPointLineWithPolygon(canvas);
    _drawRawPoints(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
