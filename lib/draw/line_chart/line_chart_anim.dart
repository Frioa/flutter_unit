import 'dart:math';

import 'package:flutter/material.dart';

class LineChartAnim extends StatefulWidget {
  final double width;
  final double height;
  final Color activeColor;
  final Color unActiveColor;
  final List<double> values;

  const LineChartAnim({
    Key? key,
    this.values = const [],
    this.width = double.infinity,
    this.height = 292.0,
    this.activeColor = Colors.blue,
    this.unActiveColor = Colors.grey,
  }) : super(key: key);

  @override
  _LineChartAnimState createState() => _LineChartAnimState();
}

class _LineChartAnimState extends State<LineChartAnim> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LineChartAnim oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size(widget.width, widget.height),
          painter: _LineChartPainter(values: widget.values),
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  static const double _heightFactor = 0.7;
  static const double _unitWidthFactor = 1.0;
  static const double _shortWidthFactor = 0.178;

  final int sliderIndex;
  final List<double> values;
  final double circleWidth;
  final Color activeColor;
  final Color unActiveColor;

  double chartMaxHeight = 0.0;
  double unitWidth = 0.0; // 左右点的宽
  double shortWidth = 0.0; // 左右短边宽
  double maxValue = -1;
  List<Offset> offsets = []; // 各点坐标
  late Paint _activeLinePint;
  late Paint _unActiveLinePint;

  late Paint _chartPaint;
  late Paint _circlePint;
  late Path _linePath;

  _LineChartPainter({
    this.sliderIndex = 0,
    this.values = const [],
    this.circleWidth = 4,
    this.activeColor = Colors.blue,
    this.unActiveColor = Colors.grey,
  }) {
    _activeLinePint = Paint();
    _activeLinePint.color = activeColor;
    _activeLinePint.strokeWidth = .5;
    _activeLinePint.style = PaintingStyle.stroke;

    _unActiveLinePint = Paint();
    _unActiveLinePint.color = unActiveColor;
    _unActiveLinePint.strokeWidth = .5;
    _unActiveLinePint.style = PaintingStyle.stroke;

    _chartPaint = Paint();
    _chartPaint.color = Colors.black;
    _chartPaint.style = PaintingStyle.fill;

    _circlePint = Paint();
    _circlePint.style = PaintingStyle.fill;

    _linePath = Path();
    maxValue = values.reduce((v1, v2) => v1 > v2 ? v1 : v2);
  }

  bool isActive(int index) => index <= sliderIndex;

  Color _color(int index) => isActive(index) ? activeColor : unActiveColor;

  void initData(Canvas canvas, Size size) {
    // 计算宽度
    chartMaxHeight = size.height * _heightFactor;
    unitWidth = size.width / ((values.length - 1) * _unitWidthFactor + 2 * _shortWidthFactor);
    shortWidth = unitWidth * _shortWidthFactor;

    for (int i = 0; i < values.length; i++) {
      final x = shortWidth + i * unitWidth;
      final y = values[i] / maxValue * chartMaxHeight;
      offsets.add(Offset(x, y));
    }
  }

  void drawDots(Canvas canvas, Size size) {
    for (int i = 0; i < offsets.length; i++) {
      canvas.drawCircle(offsets[i], circleWidth / 2, _circlePint..color = _color(i));
    }
  }

  void drawActiveLine(Canvas canvas, Size size) {
    // 绘制左边的短线
    _linePath.moveTo(0, offsets[0].dy);
    _linePath.lineTo(shortWidth, offsets[0].dy);
    canvas.drawCircle(offsets[0], circleWidth / 2, _circlePint..color = _color(0));

    for (int i = 1; i < offsets.length; i++) {
      final pre = offsets[i - 1];
      final cur = offsets[i];
      final midPoint = Offset(pre.dx, cur.dy);
      _linePath.lineTo(midPoint.dx, midPoint.dy);
      _linePath.lineTo(cur.dx, cur.dy);
    }
    if (sliderIndex == offsets.length - 1) {
      _linePath.lineTo(offsets.last.dx + shortWidth, offsets.last.dy);
    }

    canvas.drawPath(_linePath, _activeLinePint);
    // canvas.drawCircle(offsets[sliderIndex], circleWidth / 2, _circlePint..color = activeColor);
  }

  void drawUnActiveLine(Canvas canvas, Size size) {
    if (sliderIndex + 1 >= offsets.length) return;

    _linePath.reset();
    _linePath.moveTo(offsets[sliderIndex].dx, offsets[sliderIndex + 1].dy);
    for (int i = sliderIndex + 1; i < offsets.length; i++) {
      final pre = offsets[i - 1];
      final cur = offsets[i];
      final midPoint = Offset(pre.dx, cur.dy);
      _linePath.lineTo(midPoint.dx, midPoint.dy);
      _linePath.lineTo(offsets[i].dx, offsets[i].dy);
    }

    _linePath.lineTo(offsets.last.dx + shortWidth, offsets.last.dy);
    canvas.drawPath(_linePath, _unActiveLinePint);
    _linePath.reset();
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    /// 原点坐标移动到左下角
    canvas.scale(1, -1);
    canvas.translate(0, -size.height);

    initData(canvas, size);
    drawActiveLine(canvas, size);
    drawUnActiveLine(canvas, size);
    drawDots(canvas, size);
    canvas.drawLine(Offset.zero, Offset(size.width, 0), _activeLinePint..color = unActiveColor);
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return true;
  }
}
