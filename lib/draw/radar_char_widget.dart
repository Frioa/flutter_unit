import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/draw.dart';

class RadarCharPage extends StatefulWidget {
  @override
  _RadarCharPageState createState() => _RadarCharPageState();
}

class _RadarCharPageState extends State<RadarCharPage> {
  @override
  Widget build(BuildContext context) {
    return RadarCharWidget(
      size: Size(300, 300),
      charList: [
        RadarChar(x: 2, y: 5330, z: 636, background: Colors.blue.withOpacity(0.2)),
        RadarChar(x: 100, y: 100, z: 100, background: Colors.grey.withOpacity(0.2)),
      ],
    );
  }
}

class RadarCharWidget extends StatefulWidget {
  final Size size;
  final List<RadarChar> charList;

  const RadarCharWidget({Key? key, required this.size, required this.charList}) : super(key: key);

  @override
  _RadarCharWidgetState createState() => _RadarCharWidgetState();
}

class _RadarCharWidgetState extends State<RadarCharWidget> with SingleTickerProviderStateMixin {
  static const heightFactor = 0.8;

  late AnimationController controller;

  /// 高
  double height = .0;

  /// 边长
  double sideLength = .0;

  /// 原点到顶点的距离
  double offsetLength = .0;

  /// 三轴的顶点
  Offset x = Offset.zero;
  Offset y = Offset.zero;
  Offset z = Offset.zero;

  double get _xMax => widget.charList.reduce((cur, next) => cur.x > next.x ? cur : next).x;

  double get _yMax => widget.charList.reduce((cur, next) => cur.y > next.y ? cur : next).y;

  double get _zMax => widget.charList.reduce((cur, next) => cur.z > next.z ? cur : next).z;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    initData(widget);

    controller.reset();
    controller.forward();
  }

  void initData(RadarCharWidget oldWidget) {
    height = widget.size.height * heightFactor;
    sideLength = height / cos(pi / 6);
    offsetLength = sideLength / 2 / cos(pi / 6);

    z = Offset(0, offsetLength);
    y = Offset(offsetLength * sin(pi / 3), -offsetLength * cos(pi / 3));
    x = Offset(-offsetLength * sin(pi / 3), -offsetLength * cos(pi / 3));

    for (int i = 0; i < widget.charList.length; i++) {
      final oldChar = oldWidget.charList[i];
      final char = widget.charList[i];
      final scaleX = char.x / _xMax;
      final scaleY = char.y / _yMax;
      final scaleZ = char.z / _zMax;

      char.xOffset = x.scale(scaleX, scaleX);
      char.yOffset = y.scale(scaleY, scaleY);
      char.zOffset = z.scale(scaleZ, scaleZ);

      char.xAnimate = Tween<Offset>(begin: oldChar.xOffset, end: char.xOffset).animate(controller);
      char.yAnimate = Tween<Offset>(begin: oldChar.yOffset, end: char.yOffset).animate(controller);
      char.zAnimate = Tween<Offset>(begin: oldChar.zOffset, end: char.zOffset).animate(controller);
    }
  }

  @override
  void didUpdateWidget(covariant RadarCharWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    initData(oldWidget);
    controller.reset();
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: CustomPaint(
          size: widget.size,
          painter: _RadarCharPainter(
            x,
            y,
            z,
            widget.charList,
            height: height,
            repaint: controller,
          ),
        ),
      ),
    );
  }
}

class _RadarCharPainter extends CustomPainter {
  final Offset x;
  final Offset y;
  final Offset z;
  final double height;
  final List<RadarChar> charList;
  final int step;
  final Size dashedSize;
  final double dashedSpace;

  final _path = Path();

  final _solidPint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..color = Colors.black;

  _RadarCharPainter(
    this.x,
    this.y,
    this.z,
    this.charList, {
    this.height = .0,
    this.step = 5,
    this.dashedSize = const Size(5, .33),
    this.dashedSpace = 5,
    AnimationController? repaint,
  }) : super(repaint: repaint);

  void drawTriangle(Canvas canvas, Size size, Offset x, Offset y, Offset z, {Paint? paint}) {
    canvas.save();
    canvas.translate(0, -(size.height - height) / 2);

    _path.reset();
    _path.moveTo(x.dx, x.dy);
    _path.lineTo(z.dx, z.dy);
    _path.lineTo(y.dx, y.dy);
    _path.close();

    canvas.drawPath(_path, paint ?? _solidPint);
    canvas.restore();
  }

  void _drawBaseCoordinate(Canvas canvas, Size size) {
    void drawDashLine(Offset x, Offset y) {
      double distance = (x - y).distance;
      int dashedNum = distance ~/ (dashedSpace + dashedSize.width);
      double k = (y.dy - x.dy) / (y.dx - x.dx);
      double b = x.dy - x.dx * k;

      /// 利用直线方程画虚线
      for (int i = 0; i <= dashedNum; i++) {
        final dx = x.dx + (dashedSpace + dashedSize.width) * i;
        final dy = k * dx + b;
        final dashedX = dx + dashedSize.width;
        final dashedY = k * dashedX + b;

        canvas.drawLine(
          Offset(dx, dy),
          Offset(dashedX.clamp(min(x.dx, y.dx), max(x.dx, y.dx)),
              dashedY.clamp(min(x.dy, y.dy), max(x.dy, y.dy))),
          _solidPint,
        );
      }
    }

    void drawCoordinate() {
      canvas.save();
      canvas.translate(0, -(size.height - height) / 2);
      canvas.drawLine(Offset.zero, x, _solidPint..color = Colors.black);
      canvas.drawLine(Offset.zero, y, _solidPint);
      canvas.drawLine(Offset.zero, z, _solidPint);
      canvas.restore();
    }

    /// 绘制内部虚线三角
    void drawInnerTriangle(Offset x, Offset y) {
      canvas.save();
      canvas.translate(0, -(size.height - height) / 2);

      /// x -> y 轴的虚线
      drawDashLine(x, y);

      /// y -> z 轴的虚线，翻转画布
      canvas.rotate(2 * pi / 3);
      drawDashLine(x, y);

      /// z -> 轴虚线，翻转画布
      canvas.rotate(2 * pi / 3);
      drawDashLine(x, y);
      canvas.restore();
    }

    /// 绘制外边框
    drawTriangle(canvas, size, x, y, z);
    drawCoordinate();

    /// 绘制内部三角
    for (int i = 1; i < step; i++) {
      final scale = i / step;
      drawInnerTriangle(x.scale(scale, scale), y.scale(scale, scale));
    }
  }

  void _drawCharList(Canvas canvas, Size size) {
    for (final char in charList) {
      drawTriangle(
        canvas,
        size,
        char.xAnimate.value,
        char.yAnimate.value,
        char.zAnimate.value,
        paint: _solidPint
          ..color = char.background
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    /// 坐标系
    drawTable(canvas, size);

    canvas.scale(1, -1);

    _drawBaseCoordinate(canvas, size);
    _drawCharList(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

@immutable
class RadarChar implements Equatable {
  final double x;
  final double y;
  final double z;
  final Color background;

  late Animation<Offset> xAnimate;
  late Animation<Offset> yAnimate;
  late Animation<Offset> zAnimate;

  Offset xOffset = Offset.zero;
  Offset yOffset = Offset.zero;
  Offset zOffset = Offset.zero;

  double get sum => x + y + z;

  RadarChar({
    this.x = .0,
    this.y = .0,
    this.z = .0,
    this.background = Colors.blue,
  });

  @override
  List<Object> get props => [x, y, z, background];

  @override
  bool get stringify => true;
}
