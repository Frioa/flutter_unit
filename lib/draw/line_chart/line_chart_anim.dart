import 'dart:ui';

import 'package:flutter/material.dart';

class LineChartAnim extends StatefulWidget {
  final List<double> values;
  final List<String> labels;
  final TextStyle labelStyle;
  final double width;
  final double height;
  final double strokeWidth;
  final double circleWidth;
  final double dottedLineWidth;
  final double sliderValue;
  final Color activeColor;
  final Color inactiveColor;
  final List<Color> gradientColors;

  const LineChartAnim({
    Key? key,
    required this.values,
    this.height = 292.0,
    this.width = double.infinity,
    this.labels = const [],
    this.labelStyle = const TextStyle(fontSize: 10),
    this.sliderValue = 0,
    this.strokeWidth = 1.5,
    this.circleWidth = 4,
    this.dottedLineWidth = 1.0,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.gradientColors = const [
      Color.fromRGBO(0, 149, 255, 0.000001),
      Color.fromRGBO(0, 149, 255, 0.302393),
    ],
  }) : super(key: key);

  int get sliderIndex => sliderValue.toInt();

  double get maxValue => values.reduce((v1, v2) => v1 > v2 ? v1 : v2);

  @override
  _LineChartAnimState createState() => _LineChartAnimState();
}

class _LineChartAnimState extends State<LineChartAnim> with TickerProviderStateMixin {
  static const double testScale = 2.5;
  static const double _heightFactor = 0.7;
  static const double _unitWidthFactor = 1.0;
  static const double _shortWidthFactor = 0.178;

  double chartMaxHeight = 0.0; // 最高柱状图的高
  double unitWidth = 0.0; // 左右点的宽
  double shortWidth = 0.0; // 左右短边宽
  List<Offset> offsets = []; // 各点坐标

  late AnimationController textController;
  late AnimationController chartController;
  late List<Animation<double>> testAnimations;
  late List<Animation<Offset>> chartAnimation;
  late Listenable repaint;

  @override
  void initState() {
    super.initState();
    initData();
    testAnimations = [];
    chartAnimation = [];
    textController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    chartController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    repaint = Listenable.merge(<Listenable>[textController, chartController]);
    offsets.forEach((e) {
      testAnimations.add(Tween<double>(begin: 1.0, end: 1.0).animate(textController));
      chartAnimation.add(Tween<Offset>(begin: Offset(e.dx, 0), end: e).animate(chartController));
    });
    chartController.forward();
  }

  @override
  void didUpdateWidget(covariant LineChartAnim oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sliderValue != widget.sliderValue) {
      playTextAnim(oldWidget);
    }
    if (oldWidget.values != widget.values) {
      playChartAnim();
    }
  }

  @override
  void dispose() {
    textController.dispose();
    chartController.dispose();
    super.dispose();
  }

  void initData() {
    // 计算宽度
    chartMaxHeight = widget.height * _heightFactor;
    unitWidth =
        widget.width / ((widget.values.length - 1) * _unitWidthFactor + 2 * _shortWidthFactor);
    shortWidth = unitWidth * _shortWidthFactor;

    offsets.clear();
    for (int i = 0; i < widget.values.length; i++) {
      final x = shortWidth + i * unitWidth;
      final y = widget.maxValue == 0 ? 0.0 : widget.values[i] / widget.maxValue * chartMaxHeight;
      offsets.add(Offset(x, y));
    }
  }

  void playTextAnim(LineChartAnim oldWidget) {
    final oldIndex = oldWidget.sliderIndex;
    final newIndex = widget.sliderIndex;
    for (int i = 0; i < widget.labels.length; i++) {
      if (i == oldIndex) {
        testAnimations[oldIndex] = Tween<double>(
          begin: testAnimations[oldIndex].value,
          end: 1.0,
        ).animate(textController);
        continue;
      }
      if (i == newIndex) {
        testAnimations[newIndex] = Tween<double>(
          begin: testAnimations[newIndex].value,
          end: testScale,
        ).animate(textController);
        continue;
      }

      testAnimations[i] = Tween<double>(begin: 1, end: 1).animate(textController);
    }
    textController.reset();
    textController.forward();
  }

  void playChartAnim() {
    initData();

    for (int i = 0; i < widget.values.length; i++) {
      chartAnimation[i] =
          Tween<Offset>(begin: chartAnimation[i].value, end: offsets[i]).animate(chartController);
      testAnimations[i] = Tween<double>(begin: 1, end: 1).animate(textController);
    }
    chartController.reset();
    chartController.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.values.length < 2) return const SizedBox();

    return RepaintBoundary(
      child: CustomPaint(
        size: Size(widget.width, widget.height),
        painter: _LineChartPainter(
          unitWidth: unitWidth,
          shortWidth: shortWidth,
          labels: widget.labels,
          testAnimations: testAnimations,
          offsetsAnim: chartAnimation,
          sliderValue: widget.sliderValue,
          strokeWidth: widget.strokeWidth,
          circleWidth: widget.circleWidth,
          dottedLineWidth: widget.dottedLineWidth,
          gradientColors: widget.gradientColors,
          activeColor: widget.activeColor,
          inactiveColor: widget.inactiveColor,
          activeStyle: widget.labelStyle.copyWith(color: widget.activeColor),
          inactiveStyle: widget.labelStyle.copyWith(color: widget.inactiveColor),
          repaint: repaint,
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final double sliderValue;
  final double unitWidth;
  final double shortWidth;
  final List<String> labels;
  final TextStyle activeStyle;
  final TextStyle inactiveStyle;
  final double strokeWidth;
  final double circleWidth;
  final double dottedLineWidth; // 默认虚线与实线宽度一样
  final Color activeColor;
  final Color inactiveColor;
  final List<Color> gradientColors;
  final List<Animation<double>> testAnimations;
  final List<Animation<Offset>> offsetsAnim;

  Offset leftOffset = Offset.zero;
  Offset rightOffset = Offset.zero;

  late Paint _activeLinePaint;
  late Paint _inactiveLinePaint;
  late Paint _dottedLinePaint;
  late Paint _chartPaint;
  late Paint _circlePaint;
  late Paint _backgroundPaint;
  late Path _path;

  int get sliderIndex => sliderValue.toInt();

  _LineChartPainter({
    this.unitWidth = 2,
    this.shortWidth = 100,
    this.sliderValue = 0,
    this.labels = const [],
    this.activeStyle = const TextStyle(fontSize: 12, color: Colors.blue),
    this.inactiveStyle = const TextStyle(fontSize: 12, color: Colors.grey),
    this.strokeWidth = 3,
    this.circleWidth = 4,
    this.dottedLineWidth = 1.0,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.gradientColors = const [],
    this.testAnimations = const [],
    this.offsetsAnim = const [],
    Listenable? repaint,
  }) : super(repaint: repaint) {
    _activeLinePaint = Paint();
    _activeLinePaint.color = activeColor;
    _activeLinePaint.strokeWidth = strokeWidth;
    _activeLinePaint.style = PaintingStyle.stroke;

    _inactiveLinePaint = Paint();
    _inactiveLinePaint.color = inactiveColor;
    _inactiveLinePaint.strokeWidth = strokeWidth;
    _inactiveLinePaint.style = PaintingStyle.stroke;

    _dottedLinePaint = Paint();
    _dottedLinePaint.color = inactiveColor;
    _dottedLinePaint.strokeWidth = dottedLineWidth;
    _dottedLinePaint.style = PaintingStyle.stroke;

    _chartPaint = Paint();
    _chartPaint.color = Colors.black;
    _chartPaint.style = PaintingStyle.fill;

    _circlePaint = Paint();
    _circlePaint.style = PaintingStyle.fill;

    _backgroundPaint = Paint();
    _path = Path();
  }

  bool _isActive(int index) => index <= sliderIndex;

  Color _color(int index) => _isActive(index) ? activeColor : inactiveColor;

  void drawDottedLine(Canvas canvas, Size size) {
    void _drawDottedLine(Offset start, Offset end, Paint paint) {
      final distance = (start - end).distance;

      final unitWidth = 2 * dottedLineWidth;
      final dottedNum = distance ~/ unitWidth;
      for (int i = 0; i < dottedNum; i++) {
        final curStart = start - Offset(0, unitWidth * i);
        final curEnd = curStart - Offset(0, dottedLineWidth);
        canvas.drawLine(curStart, curEnd, paint);
      }
    }

    for (int i = 0; i < offsetsAnim.length; i++) {
      _drawDottedLine(
        offsetsAnim[i].value,
        Offset(offsetsAnim[i].value.dx, 0),
        _dottedLinePaint..color = _color(i),
      );
    }
  }

  void drawDots(Canvas canvas, Size size) {
    for (int i = 0; i < offsetsAnim.length; i++) {
      canvas.drawCircle(offsetsAnim[i].value, circleWidth / 2, _circlePaint..color = _color(i));
    }
  }

  void drawActiveLine(Canvas canvas, Size size) {
    // 绘制左边的短线
    _path.reset();
    _path.moveTo(leftOffset.dx, leftOffset.dy);
    _path.lineTo(offsetsAnim[0].value.dx, offsetsAnim[0].value.dy);

    for (int i = 1; i < offsetsAnim.length; i++) {
      final pre = offsetsAnim[i - 1].value;
      final cur = offsetsAnim[i].value;
      final mid = Offset(pre.dx, cur.dy);

      _path.lineTo(mid.dx, mid.dy);
      _path.lineTo(cur.dx, cur.dy);
    }
    // 绘制右边的短线
    _path.lineTo(rightOffset.dx, rightOffset.dy);
    canvas.drawPath(_path, _activeLinePaint);
  }

  void drawInactiveLine(Canvas canvas, Size size) {
    if (sliderIndex + 1 >= offsetsAnim.length) return;

    _path.reset();
    _path.moveTo(offsetsAnim[sliderIndex].value.dx, offsetsAnim[sliderIndex + 1].value.dy);
    for (int i = sliderIndex + 1; i < offsetsAnim.length; i++) {
      final pre = offsetsAnim[i - 1].value;
      final cur = offsetsAnim[i].value;
      final mid = Offset(pre.dx, cur.dy);

      _path.lineTo(mid.dx, mid.dy);
      _path.lineTo(offsetsAnim[i].value.dx, offsetsAnim[i].value.dy);
    }

    // 绘制左边的短线
    _path.lineTo(offsetsAnim.last.value.dx + shortWidth, offsetsAnim.last.value.dy);
    canvas.drawPath(_path, _inactiveLinePaint);
  }

  void drawBackground(Canvas canvas, Size size) {
    _path.reset();
    _path.moveTo(0, 0);
    _path.lineTo(leftOffset.dx, leftOffset.dy);
    _path.lineTo(offsetsAnim[0].value.dx, offsetsAnim[0].value.dy);

    for (int i = 1; i <= sliderIndex; i++) {
      final pre = offsetsAnim[i - 1].value;
      final cur = offsetsAnim[i].value;
      final mid = Offset(pre.dx, cur.dy);
      _path.lineTo(mid.dx, mid.dy);
      _path.lineTo(offsetsAnim[i].value.dx, offsetsAnim[i].value.dy);
    }
    if (sliderIndex + 1 < offsetsAnim.length) {
      _path.lineTo(offsetsAnim[sliderIndex].value.dx, offsetsAnim[sliderIndex + 1].value.dy);
    }
    final sliderOffset = Offset(
      offsetsAnim[sliderIndex].value.dx + (sliderValue - sliderIndex) * unitWidth,
      offsetsAnim[(sliderIndex + 1) < offsetsAnim.length ? sliderIndex + 1 : sliderIndex].value.dy,
    );
    _path.lineTo(sliderOffset.dx, sliderOffset.dy);
    _path.lineTo(sliderOffset.dx, 0);
    _path.close();

    _backgroundPaint.shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: gradientColors,
    ).createShader(_path.getBounds());

    canvas.drawPath(_path, _backgroundPaint);
  }

  void drawTextLabels(Canvas canvas, Size size) {
    // 翻转画布防止文字反向绘制
    canvas.scale(1, -1);

    for (int i = 0; i < labels.length; i++) {
      final style = _isActive(i) ? activeStyle : inactiveStyle;
      final textSpan = TextSpan(
        text: labels[i],
        style: style.copyWith(fontSize: (style.fontSize ?? 12) * testAnimations[i].value),
      );
      final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.rtl);
      textPainter.layout();

      canvas.save();
      // 将原点坐标移动到每个点
      canvas.translate(
        offsetsAnim[i].value.dx,
        -offsetsAnim[i].value.dy - textPainter.height / 2 * 1.25,
      );
      // 在文字中心点绘制
      textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (offsetsAnim.isEmpty) return;
    leftOffset = Offset(0, offsetsAnim[0].value.dy);
    rightOffset = offsetsAnim.last.value + Offset(shortWidth, 0);

    /// 原点坐标移动到左下角
    canvas.scale(1, -1);
    canvas.translate(0, -size.height);
    canvas.drawLine(Offset.zero, Offset(size.width, 0), _inactiveLinePaint);

    drawBackground(canvas, size);
    drawDottedLine(canvas, size);
    drawActiveLine(canvas, size);
    drawInactiveLine(canvas, size);
    drawDots(canvas, size);
    drawTextLabels(canvas, size);
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return sliderValue != oldDelegate.sliderValue || !offsetsAnim[0].isDismissed;
  }
}
