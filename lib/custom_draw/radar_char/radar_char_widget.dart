import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/custom_draw/radar_char/radar_char.dart';
import 'package:flutter_unit/draw/draw.dart';

class RadarCharPage extends StatefulWidget {
  @override
  _RadarCharPageState createState() => _RadarCharPageState();
}

class _RadarCharPageState extends State<RadarCharPage> {
  RadarChar x = RadarChar(x: 50, y: 50, z: 50, background: Colors.blue.withOpacity(0.2));
  RadarChar y = RadarChar(x: 100, y: 100, z: 100, background: Colors.grey.withOpacity(0.2));

  @override
  Widget build(BuildContext context) {
    // return  RadarCharWidget(
    //   size: Size(300, 300),
    //   charList: [x, y],
    // );

    print('object $x');
    print('object $y');

    return Scaffold(
      body: SizedBox(
        width: 1000,
        height: 1000,
        child: Column(
          children: [
            RadarCharWidget(
              size: Size(300, 300),
              charList: [x, y],
            ),
            CupertinoButton(
                child: Text('x +'),
                onPressed: () {
                  x += RadarChar(x: 10, y: 10, z: 10);
                  setState(() {});
                }),
            CupertinoButton(
                child: Text('x -'),
                onPressed: () {
                  x -= RadarChar(x: 10, y: 10, z: 10);
                  setState(() {});
                }),
            CupertinoButton(
                child: Text('y +'),
                onPressed: () {
                  y += RadarChar(x: 10, y: 10, z: 10);
                  setState(() {});
                }),
            CupertinoButton(
                child: Text('y -'),
                onPressed: () {
                  y -= RadarChar(x: 10, y: 10, z: 10);
                  setState(() {});
                }),
          ],
        ),
      ),
    );
  }
}

class RadarCharWidget extends StatefulWidget {
  final Size size;
  final List<RadarChar> charList;
  final Color? backgroundColor;

  double get xMax => charList.reduce((cur, next) => cur.x > next.x ? cur : next).x;

  double get yMax => charList.reduce((cur, next) => cur.y > next.y ? cur : next).y;

  double get zMax => charList.reduce((cur, next) => cur.z > next.z ? cur : next).z;

  const RadarCharWidget({
    Key? key,
    required this.size,
    required this.charList,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _RadarCharWidgetState createState() => _RadarCharWidgetState();
}

class _RadarCharWidgetState extends State<RadarCharWidget> with SingleTickerProviderStateMixin {
  static const heightFactor = 0.8;

  /// 高
  late double height;
  late AnimationController controller;
  late List<Animation<RadarChar>> animations;
  late List<Offset> coordinate; // x, y, z ...
  late RadarChar maxChar;

  @override
  void initState() {
    super.initState();
    height = 0.0;
    controller = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animations = [];
    coordinate = [];
    initData(widget);

    controller.reset();
    controller.forward();
  }

  void initData(RadarCharWidget oldWidget) {
    // 宽高
    height = widget.size.height * heightFactor;
    final sideLength = height / cos(pi / 6); // 边长
    final offsetLength = sideLength / 2 / cos(pi / 6); //   /// 原点到顶点的距离

    animations.clear();
    coordinate.clear();
    maxChar = RadarChar(x: widget.xMax, y: widget.yMax, z: widget.zMax);
    // 确定原点坐标 TODO:
    final z = Offset(0, offsetLength);
    final y = Offset(offsetLength * sin(pi / 3), -offsetLength * cos(pi / 3));
    final x = Offset(-offsetLength * sin(pi / 3), -offsetLength * cos(pi / 3));
    coordinate.add(x);
    coordinate.add(y);
    coordinate.add(z);

    print('object $maxChar');
    // coordinate
    // for (int i = 0; i < widget.charList.length ; i++ ) {
    //   // coordinate.add(value)
    // }

    for (int i = 0; i < widget.charList.length; i++) {
      var oldChar = oldWidget.charList[i];
      var char = widget.charList[i];
      char /= maxChar;

      oldChar /= RadarChar(x: oldWidget.xMax, y: oldWidget.yMax, z: oldWidget.zMax);

      animations.add(Tween<RadarChar>(begin: oldChar, end: char).animate(controller));
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
    return RepaintBoundary(
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: CustomPaint(
          size: widget.size,
          painter: _RadarCharPainter(
            coordinate,
            animations,
            height: height,
            repaint: controller,
          ),
        ),
      ),
    );
  }
}

class _RadarCharPainter extends CustomPainter {
  final List<Offset> coordinate;
  final List<Animation<RadarChar>> animations;
  final double height;
  final int step;
  final Size dashedSize;
  final double dashedSpace;
  final Color backgroundColor;

  final _path = Path();

  final _solidPint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = strokeWidth
    ..color = Colors.black;

  _RadarCharPainter(
    this.coordinate,
    this.animations, {
    this.height = .0,
    this.step = 5,
    this.dashedSize = const Size(5, .33),
    this.dashedSpace = 5,
    this.backgroundColor = Colors.transparent,
    AnimationController? repaint,
  }) : super(repaint: repaint);

  void drawTriangle(Canvas canvas, Size size, List<Offset> list, {Paint? paint}) {
    canvas.save();
    canvas.translate(0, -(size.height - height) / 2);

    _path.reset();
    _path.moveTo(list[0].dx, list[0].dy);
    for (int i = 1; i < list.length; i++) {
      _path.lineTo(list[i].dx, list[i].dy);
    }
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
      _solidPint..color = Colors.black;
      for (int i = 0; i < coordinate.length; i++) {
        canvas.drawLine(Offset.zero, coordinate[i], _solidPint);
      }
      canvas.restore();
    }

    /// 绘制内部虚线三角
    // void drawInnerTriangle(Offset x, Offset y) {
    //   canvas.save();
    //   canvas.translate(0, -(size.height - height) / 2);
    //
    //   /// x -> y 轴的虚线
    //   drawDashLine(x, y);
    //
    //   /// y -> z 轴的虚线，翻转画布
    //   canvas.rotate(2 * pi / 3);
    //   drawDashLine(x, y);
    //
    //   /// z -> 轴虚线，翻转画布
    //   canvas.rotate(2 * pi / 3);
    //   drawDashLine(x, y);
    //   canvas.restore();
    // }

    /// 绘制外边框
    drawTriangle(canvas, size, coordinate,
        paint: _solidPint
          ..color = backgroundColor
          ..style = PaintingStyle.fill);
    drawCoordinate();

    // /// 绘制内部三角
    // for (int i = 1; i < step; i++) {
    //   final scale = i / step;
    //   drawInnerTriangle(x.scale(scale, scale), y.scale(scale, scale));
    // }
  }

  void _drawCharList(Canvas canvas, Size size) {
    for (final char in animations) {
      drawTriangle(
        canvas,
        size,
        char.value.toOffsets(coordinate),
        paint: _solidPint
          ..color = char.value.background
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    drawTable(canvas, size);

    canvas.scale(1, -1);
    _drawBaseCoordinate(canvas, size);
    _drawCharList(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
