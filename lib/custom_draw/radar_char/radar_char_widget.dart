import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/draw.dart';
import 'package:flutter_unit/custom_draw/custom_draw.dart';

class RadarCharPage extends StatefulWidget {
  @override
  _RadarCharPageState createState() => _RadarCharPageState();
}

class _RadarCharPageState extends State<RadarCharPage> {
  RadarChar x = RadarChar(values: [
    50,
    50,
    50,
    50,
    50,
    50,
    50,
  ], background: Colors.blue.withOpacity(0.2));
  RadarChar y = RadarChar(values: [
    100,
    100,
    100,
    100,
    100,
    100,
    100,
  ], background: Colors.grey.withOpacity(0.2));

  @override
  Widget build(BuildContext context) {
    // return  RadarCharWidget(
    //   size: Size(300, 300),
    //   charList: [x, y],
    // );

    return Scaffold(
      body: Container(
        height: 1920,
        width: 1080,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadarCharWidget(
              size: Size(300, 300),
              charList: [x, y],
            ),
            // CupertinoButton(
            //     child: Text('x +'),
            //     onPressed: () {
            //       x = x + x;
            //       setState(() {});
            //     }),
            // CupertinoButton(
            //     child: Text('x -'),
            //     onPressed: () {
            //       x -= x;
            //       setState(() {});
            //     }),
            // CupertinoButton(
            //     child: Text('y +'),
            //     onPressed: () {
            //       y += y;
            //       setState(() {});
            //     }),
            // CupertinoButton(
            //     child: Text('y -'),
            //     onPressed: () {
            //       y -= y;
            //       setState(() {});
            //     }),
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

  RadarChar get maxRadarChar {
    final list = <double>[];
    for (int i = 0; i < charList[0].values.length; i++) {
      double max = double.minPositive;
      for (int j = 0; j < charList.length; j++) {
        if (max < charList[j].values[i]) max = charList[j].values[i];
      }
      list.add(max);
    }

    return RadarChar(values: list);
  }

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
  /// 高
  late double r;
  late double yOffset;
  late List<Animation<RadarChar>> animations;
  late List<Offset> coordinate; // x, y, z ...
  late AnimationController controller;

  int get valueLength => widget.charList[0].values.length;

  double get angleUnit => 2 * pi / valueLength;

  @override
  void initState() {
    super.initState();
    r = 0.0;
    animations = [];
    coordinate = [];
    controller = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    initData(widget);

    controller.reset();
    controller.forward();
  }

  void initData(RadarCharWidget oldWidget) {
    r = widget.size.height / 2;
    final sideLength = 2 * r * sin(pi / valueLength); // 边长
    // Y 坐标偏移量, 保证坐标远点在中心
    yOffset = valueLength % 2 == 0
        ? 0
        : (sqrt(r * r - sideLength * sideLength / 4) - r) / 2;

    final maxChar = widget.maxRadarChar;
    final maxOldChar = oldWidget.maxRadarChar;

    animations.clear();
    coordinate.clear();

    /// 计算各个边顶点的坐标
    final t = Offset(r, r);
    for (int i = 0; i < valueLength; i++) {
      final angle = i * angleUnit;
      coordinate.add(Offset(t.dx * sin(angle), t.dy * cos(angle)));
    }

    /// 计算每个图的百分比
    for (int i = 0; i < widget.charList.length; i++) {
      var oldChar = oldWidget.charList[i];
      var char = widget.charList[i];
      char /= maxChar;
      oldChar /= maxOldChar;

      animations.add(Tween<RadarChar>(begin: oldChar, end: char).animate(controller));
    }
  }

  @override
  void didUpdateWidget(covariant RadarCharWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.charList[0].values.length != widget.charList[0].values.length)
      initData(widget);
    else
      initData(oldWidget);
    controller.reset();
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
            height: r,
            repaint: controller,
            yOffset: yOffset,
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
  final double yOffset;

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
    this.yOffset = 0,
    AnimationController? repaint,
  }) : super(repaint: repaint);

  void drawTriangle(Canvas canvas, Size size, List<Offset> list, {Paint? paint}) {
    canvas.save();
    canvas.translate(0, yOffset);

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
      canvas.translate(0, yOffset);
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
