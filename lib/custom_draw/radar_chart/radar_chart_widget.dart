import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/draw.dart';
import 'package:flutter_unit/custom_draw/custom_draw.dart';

class RadarChartPage extends StatefulWidget {
  @override
  _RadarChartPageState createState() => _RadarChartPageState();
}

class _RadarChartPageState extends State<RadarChartPage> {
  RadarChart x = RadarChart(values: [
    50,
    50,
    50,
    50,
    50,
  ], background: Colors.blue.withOpacity(0.2));
  RadarChart y = RadarChart(values: [
    100,
    100,
    100,
    100,
    100,
  ], background: Colors.grey.withOpacity(0.2));
  RadarChart z = RadarChart(values: [
    25,
    25,
    25,
    25,
    25,
  ], background: Colors.amber.withOpacity(0.2));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1920,
        width: 1080,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadarChartWidget(
              size: Size(300, 300),
              radarChartList: [x, y, z],
              layerCount: 5,
              // baseCoordinateColor: Colors.blue.withOpacity(0.2),
            ),
          ],
        ),
      ),
    );
  }
}

class RadarChartWidget extends StatefulWidget {
  final Size size;
  final List<RadarChart> radarChartList;
  final int layerCount;
  final Color dashColor;
  final Color backgroundColor;

  RadarChart get maxRadarChart {
    final list = <double>[];
    for (int i = 0; i < radarChartList[0].values.length; i++) {
      double max = double.minPositive;
      for (int j = 0; j < radarChartList.length; j++) {
        if (max < radarChartList[j].values[i]) max = radarChartList[j].values[i];
      }
      list.add(max);
    }

    return RadarChart(values: list);
  }

  const RadarChartWidget({
    Key? key,
    required this.size,
    required this.radarChartList,
    this.layerCount = 5,
    this.dashColor = Colors.grey,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  _RadarChartWidgetState createState() => _RadarChartWidgetState();
}

class _RadarChartWidgetState extends State<RadarChartWidget> with SingleTickerProviderStateMixin {
  // 半径
  late double radius;

  // 原点坐标
  late Offset origin;

  // 坐标系 x, y, z ... 各个顶点
  late List<Offset> baseCoordinate;
  late AnimationController controller;
  late List<Animation<RadarChart>> animations;

  // 多边形边数
  int get polygonSide => widget.radarChartList[0].values.length;

  // 每条边的角度
  double get unitAngle => 2 * pi / polygonSide;

  @override
  void initState() {
    super.initState();
    radius = 0.0;
    baseCoordinate = [];
    animations = [];
    controller = AnimationController(duration: const Duration(seconds: 1), vsync: this);

    updateData(widget);
    controller.forward();
  }

  void updateData(RadarChartWidget oldWidget) {
    radius = widget.size.height / 2;
    // 边长
    final sideLength = 2 * radius * sin(pi / polygonSide);
    // 边数为奇数边时，需要计算原点坐标偏移量
    origin = Offset(
        0,
        polygonSide % 2 == 0
            ? 0
            : (sqrt(radius * radius - sideLength * sideLength / 4) - radius) / 2);

    final maxChar = widget.maxRadarChart;
    final maxOldChar = oldWidget.maxRadarChart;

    animations.clear();
    baseCoordinate.clear();

    /// 计算各个边顶点的坐标
    final t = Offset(radius, radius);
    for (int i = 0; i < polygonSide; i++) {
      final angle = i * unitAngle;
      baseCoordinate.add(Offset(t.dx * sin(angle), t.dy * cos(angle)));
    }

    /// 计算每个图的百分比
    for (int i = 0; i < widget.radarChartList.length; i++) {
      var oldChar = oldWidget.radarChartList[i];
      var char = widget.radarChartList[i];
      char /= maxChar;
      oldChar /= maxOldChar;

      animations.add(Tween<RadarChart>(begin: oldChar, end: char).animate(controller));
    }
  }

  @override
  void didUpdateWidget(covariant RadarChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.radarChartList[0].values.length != widget.radarChartList[0].values.length)
      updateData(widget);
    else
      updateData(oldWidget);
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
      child: CustomPaint(
        size: widget.size,
        painter: _RadarChartPainter(
          baseCoordinate,
          animations,
          height: radius,
          repaint: controller,
          origin: origin,
          layerCount: widget.layerCount,
          backgroundColor: widget.backgroundColor,
        ),
      ),
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  final List<Offset> coordinate;
  final List<Animation<RadarChart>> animations;
  final double height;
  final int layerCount;
  final Size dashedSize;
  final double dashedSpace;
  final Color dashColor;
  final Color backgroundColor;
  final Offset origin;

  late Paint _radarCharPint;
  late Paint _dashPint;
  late Paint _coordinatePint;
  late Paint _solidPint;

  final _chartPath = Path();

  double get unitAngle => 2 * pi / coordinate.length;

  _RadarChartPainter(
    this.coordinate,
    this.animations, {
    this.height = .0,
    this.layerCount = 5,
    this.dashedSize = const Size(5, .5),
    this.dashedSpace = 5,
    this.dashColor = Colors.grey,
    this.backgroundColor = Colors.transparent,
    this.origin = Offset.zero,
    AnimationController? repaint,
  }) : super(repaint: repaint) {
    _radarCharPint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth;

    _dashPint = Paint();
    _dashPint.color = dashColor;
    _dashPint.strokeWidth = dashedSize.height;
    _dashPint.style = PaintingStyle.stroke;

    _coordinatePint = Paint();
    _coordinatePint.color = backgroundColor;
    _coordinatePint.strokeWidth = .5;
    _coordinatePint.style = PaintingStyle.fill;

    _solidPint = Paint();
    _solidPint.color = Colors.black;
    _solidPint.strokeWidth = .5;
    _solidPint.style = PaintingStyle.stroke;
  }

  // 绘制虚线从 x -> y
  void _drawDashLine(Canvas canvas, Offset x, Offset y) {
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
      if (dashedX > y.dx) break;

      canvas.drawLine(
        Offset(
          dx.clamp(min(x.dx, y.dx), max(x.dx, y.dx)),
          dy.clamp(min(x.dy, y.dy), max(x.dy, y.dy)),
        ),
        Offset(
          dashedX.clamp(min(x.dx, y.dx), max(x.dx, y.dx)),
          dashedY.clamp(min(x.dy, y.dy), max(x.dy, y.dy)),
        ),
        _dashPint,
      );
    }
  }

  void _drawPolygon(Canvas canvas, Size size, List<Offset> list, Paint paint) {
    canvas.save();
    canvas.translate(origin.dx, origin.dy);

    _chartPath.reset();
    _chartPath.moveTo(list[0].dx, list[0].dy);
    for (int i = 1; i < list.length; i++) {
      _chartPath.lineTo(list[i].dx, list[i].dy);
    }
    _chartPath.close();

    canvas.drawPath(_chartPath, paint);
    canvas.restore();
  }

  void _drawInnerNetShape(Canvas canvas, Size size) {
    /// 绘制内部虚线
    void drawInnerShape(Offset x, Offset y) {
      canvas.save();
      canvas.translate(origin.dx, origin.dy);
      for (int i = 0; i < coordinate.length; i++) {
        canvas.rotate(unitAngle);
        _drawDashLine(canvas, x, y);
      }
      canvas.restore();
    }

    for (int i = 1; i < layerCount; i++) {
      final scale = i / layerCount;
      final x = coordinate[coordinate.length ~/ 2 + 1];
      final y = coordinate[coordinate.length ~/ 2];
      drawInnerShape(x.scale(scale, scale), y.scale(scale, scale));
    }
  }

  void _drawBaseRadarChar(Canvas canvas, Size size) {
    // 绘制坐标形状
    _drawPolygon(
      canvas,
      size,
      coordinate,
      _coordinatePint,
    );

    canvas.save();
    canvas.translate(origin.dx, origin.dy);
    for (int i = 0; i < coordinate.length; i++) {
      canvas.drawLine(Offset.zero, coordinate[i], _solidPint);
    }
    canvas.restore();
  }

  void _drawRadarCharList(Canvas canvas, Size size) {
    for (final radarChart in animations) {
      _drawPolygon(
        canvas,
        size,
        radarChart.value.toOffsets(coordinate),
        _radarCharPint..color = radarChart.value.background,
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(1, -1);

    _drawBaseRadarChar(canvas, size);
    _drawInnerNetShape(canvas, size);
    _drawRadarCharList(canvas, size);
  }

  @override
  bool shouldRepaint(_RadarChartPainter oldDelegate) => oldDelegate != this;
}
