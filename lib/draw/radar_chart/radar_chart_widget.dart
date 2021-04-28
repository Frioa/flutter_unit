import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/draws.dart';

class RadarChartWidget extends StatefulWidget {
  final Size size;
  final List<RadarChart> radarCharts;
  final List<String> descList;
  final TextStyle? descStyle;
  final int layerCount;
  final Color dashColor;
  final Color backgroundColor;
  final EdgeInsets padding;
  final AnimationController? controller;

  RadarChart get maxRadarChart {
    final list = <double>[];
    for (int i = 0; i < radarCharts[0].values.length; i++) {
      double max = double.minPositive;
      for (int j = 0; j < radarCharts.length; j++) {
        if (max < radarCharts[j].values[i]) max = radarCharts[j].values[i];
      }
      list.add(max);
    }
    return RadarChart(values: list);
  }

  RadarChartWidget({
    Key? key,
    required this.size,
    required this.radarCharts,
    this.descList = const [],
    this.descStyle,
    this.layerCount = 5,
    this.dashColor = Colors.grey,
    this.backgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.symmetric(vertical: 24),
    this.controller,
  }) : super(key: key) {
    assert(() {
      if (radarCharts.length < 1) throw 'radarCharts is isEmpty';
      for (int i = 1; i < radarCharts.length; i++)
        if (radarCharts[i - 1].values.length != radarCharts[i].values.length) {
          throw 'The length of each RadarChart.values must be equal';
        }
      return true;
    }());
  }

  @override
  _RadarChartWidgetState createState() => _RadarChartWidgetState();
}

class _RadarChartWidgetState extends State<RadarChartWidget> with SingleTickerProviderStateMixin {
  late double radius;

  // 原点坐标
  late Offset origin;

  // 坐标系 x, y, z ... 各个顶点
  late List<Offset> baseCoordinate;
  late AnimationController controller;
  late List<Animation<RadarChart>> animations;

  // 多边形边数
  int get polygonSide => widget.radarCharts[0].values.length;

  // 每条边的角度
  double get unitAngle => 2 * pi / polygonSide;

  @override
  void initState() {
    super.initState();
    radius = 0.0;
    baseCoordinate = [];
    animations = [];
    controller = widget.controller ??
        AnimationController(
          duration: const Duration(milliseconds: 800),
          vsync: this,
        );

    updateData(widget);
    controller.forward();
  }

  @override
  void didUpdateWidget(covariant RadarChartWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget == widget) return;
    if (oldWidget.radarCharts.length != widget.radarCharts.length ||
        oldWidget.radarCharts[0].values.length != widget.radarCharts[0].values.length) {
      animations.clear();
      baseCoordinate.clear();
      updateData(widget);
    } else
      updateData(oldWidget);
    controller.reset();
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void updateData(RadarChartWidget oldWidget) {
    radius = widget.size.height / 2;
    final sideLength = 2 * radius * sin(pi / polygonSide);
    // 边数为奇数边时，需要计算原点坐标偏移量
    origin = Offset(
        0,
        polygonSide % 2 == 0
            ? 0
            : -(sqrt(radius * radius - sideLength * sideLength / 4) - radius) / 2);

    /// 计算坐标系，如果需要
    if (baseCoordinate.length != polygonSide) {
      /// 计算各个边顶点的坐标
      final t = Offset(radius, radius);
      baseCoordinate.clear();
      for (int i = 0; i < polygonSide; i++) {
        final angle = i * unitAngle;
        baseCoordinate.add(Offset(t.dx * sin(angle), -t.dy * cos(angle)));
      }
    }

    for (int i = 0; i < widget.radarCharts.length; i++) {
      var chart = widget.radarCharts[i];
      chart /= widget.maxRadarChart;

      if (i == animations.length) {
        // 初始化 animations, 从 0 开始做动画
        animations.add(Tween<RadarChart>(begin: chart * 0, end: chart).animate(controller));
      } else {
        // 更新 animations, 从当前旧数据开始到新数据
        animations[i] =
            Tween<RadarChart>(begin: animations[i].value, end: chart).animate(controller);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: widget.padding,
        child: CustomPaint(
          size: widget.size,
          painter: _RadarChartPainter(
            baseCoordinate,
            animations,
            radius: radius,
            repaint: controller,
            origin: origin,
            descList: widget.descList,
            style: widget.descStyle,
            layerCount: widget.layerCount,
            backgroundColor: widget.backgroundColor,
          ),
        ),
      ),
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  final List<Offset> coordinate;
  final List<Animation<RadarChart>> animations;
  final List<String> descList;
  final TextStyle? style;
  final double radius;
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
    this.descList = const [],
    this.style = const TextStyle(fontSize: 12, color: Colors.black),
    this.radius = .0,
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
    _drawPolygon(canvas, size, coordinate, _coordinatePint);

    canvas.save();
    canvas.translate(origin.dx, origin.dy);
    for (int i = 0; i < coordinate.length; i++) {
      canvas.drawLine(Offset.zero, coordinate[i], _solidPint);
    }
    canvas.restore();
  }

  void _drawRadarCharList(Canvas canvas, Size size) {
    for (final radarChart in animations) {
      _radarCharPint.color = radarChart.value.background;
      _drawPolygon(canvas, size, radarChart.value.toOffsets(coordinate), _radarCharPint);
    }
  }

  void _drawText(Canvas canvas, Size size) {
    for (int i = 0; i < descList.length; i++) {
      if (i >= coordinate.length) return;

      final textSpan = TextSpan(text: descList[i], style: style);
      final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.rtl);
      textPainter.layout();

      // 文字中心点坐标距原坐标的比值
      final scale = 1 + sqrt(pow(textPainter.width, 2) + pow(textPainter.height, 2)) / 2 / radius;

      // 移动坐标轴到顶点
      canvas.save();
      canvas.translate(origin.dx, origin.dy);
      canvas.translate(coordinate[i].dx * scale, coordinate[i].dy * scale);

      // 将文字中心绘制在画布原点
      textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    /// 绘制背景
    _drawBaseRadarChar(canvas, size);
    // 绘制内部虚线
    _drawInnerNetShape(canvas, size);

    /// 绘制数据模型
    _drawRadarCharList(canvas, size);

    /// 绘制坐标系文案
    _drawText(canvas, size);
  }

  @override
  bool shouldRepaint(_RadarChartPainter oldDelegate) => oldDelegate != this;
}
