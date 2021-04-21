import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_unit/utils/utils.dart';

class CircleLoadingAnim extends StatefulWidget {
  final double size;
  final double strokeWidth;
  final Axis axis;
  final Color color;
  final Duration delay;

  const CircleLoadingAnim({
    Key? key,
    this.size = 100,
    this.strokeWidth = 5,
    this.axis = Axis.vertical,
    this.color = Colors.blue,
    this.delay = Duration.zero,
  }) : super(key: key);

  @override
  _CircleLoadingAnimState createState() => _CircleLoadingAnimState();
}

class _CircleLoadingAnimState extends State<CircleLoadingAnim> with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  static const _cubic = Cubic(0.65, 0.01, 0.25, 1);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: _cubic);
    _animation = Tween(begin: 1.0, end: -1.0).animate(_animation);

    onPostFrame(
      () {
        if (!mounted) return;
        _controller.repeat(reverse: true);
      },
      delay: widget.delay,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: _CirclePainter(
          axis: widget.axis,
          radius: (widget.size - widget.strokeWidth) / 2,
          animation: _animation,
          color: widget.color,
          strokeWidth: widget.strokeWidth,
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final Animation<double> animation;
  final double radius;
  final double strokeWidth;
  final Color color;
  final Axis axis;
  late Path _path;
  late Paint _paint;
  late List<_Offset> _anchors; // 顺时针记录绘制圆形的四个数据点 [上，左，下，右]
  late List<_Offset> _ctrlAnchors; // 顺时针记录绘制圆形的八个控制点
  late double _difference; // 圆形的控制点与数据点的差值

  // 用来计算绘制圆形贝塞尔曲线控制点的位置的常数
  static const double _circleBessel = 0.552284749831;

  _CirclePainter({
    required this.animation,
    this.strokeWidth = 5,
    this.radius = 100,
    this.color = Colors.blue,
    this.axis = Axis.vertical,
  }) : super(repaint: animation) {
    _path = Path();
    _paint = Paint();
    _paint
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;
    _difference = radius * _circleBessel;
    _anchors = initCircleAnchors();
    _ctrlAnchors = initCircleCtrlAnchors();
  }

  List<_Offset> initCircleAnchors() {
    if (axis == Axis.vertical) {
      return [
        _Offset(0, radius * animation.value),
        _Offset(radius, 0),
        _Offset(0, -radius * animation.value),
        _Offset(-radius, 0),
      ];
    }

    // Axis.horizontal
    return [
      _Offset(0, radius),
      _Offset(radius * animation.value, 0),
      _Offset(0, -radius),
      _Offset(-radius * animation.value, 0),
    ];
  }

  List<_Offset> initCircleCtrlAnchors() {
    if (axis == Axis.vertical) {
      return [
        _Offset(_anchors[0].dx + _difference, _anchors[0].dy),
        _Offset(_anchors[1].dx, (_anchors[1].dy + _difference) * animation.value),
        _Offset(_anchors[1].dx, (_anchors[1].dy - _difference) * animation.value),
        _Offset(_anchors[2].dx + _difference, _anchors[2].dy),
        _Offset(_anchors[2].dx - _difference, _anchors[2].dy),
        _Offset(_anchors[3].dx, (_anchors[3].dy - _difference) * animation.value),
        _Offset(_anchors[3].dx, (_anchors[3].dy + _difference) * animation.value),
        _Offset(_anchors[0].dx - _difference, _anchors[0].dy),
      ];
    }

    return [
      _Offset((_anchors[0].dx + _difference) * animation.value, _anchors[0].dy),
      _Offset(_anchors[1].dx, _anchors[1].dy + _difference),
      _Offset(_anchors[1].dx, _anchors[1].dy - _difference),
      _Offset((_anchors[2].dx + _difference) * animation.value, _anchors[2].dy),
      _Offset((_anchors[2].dx - _difference) * animation.value, _anchors[2].dy),
      _Offset(_anchors[3].dx, _anchors[3].dy - _difference),
      _Offset(_anchors[3].dx, _anchors[3].dy + _difference),
      _Offset((_anchors[0].dx - _difference) * animation.value, _anchors[0].dy),
    ];
  }

  void updateCircleAnchors() {
    if (axis == Axis.vertical) {
      _anchors[0].update(0, radius * animation.value);
      _anchors[1].update(radius, 0);
      _anchors[2].update(0, -radius * animation.value);
      _anchors[3].update(-radius, 0);
      return;
    }

    // Axis.horizontal
    _anchors[0].update(0, radius);
    _anchors[1].update(radius * animation.value, 0);
    _anchors[2].update(0, -radius);
    _anchors[3].update(-radius * animation.value, 0);
  }

  void updateCircleCtrlAnchors(List<_Offset> anchors) {
    if (axis == Axis.vertical) {
      _ctrlAnchors[0].update(anchors[0].dx + _difference, anchors[0].dy);
      _ctrlAnchors[1].update(anchors[1].dx, (anchors[1].dy + _difference) * animation.value);
      _ctrlAnchors[2].update(anchors[1].dx, (anchors[1].dy - _difference) * animation.value);
      _ctrlAnchors[3].update(anchors[2].dx + _difference, anchors[2].dy);
      _ctrlAnchors[4].update(anchors[2].dx - _difference, anchors[2].dy);
      _ctrlAnchors[5].update(anchors[3].dx, (anchors[3].dy - _difference) * animation.value);
      _ctrlAnchors[6].update(anchors[3].dx, (anchors[3].dy + _difference) * animation.value);
      _ctrlAnchors[7].update(anchors[0].dx - _difference, anchors[0].dy);

      return;
    }

    _ctrlAnchors[0].update((anchors[0].dx + _difference) * animation.value, anchors[0].dy);
    _ctrlAnchors[1].update(anchors[1].dx, anchors[1].dy + _difference);
    _ctrlAnchors[2].update(anchors[1].dx, anchors[1].dy - _difference);
    _ctrlAnchors[3].update((anchors[2].dx + _difference) * animation.value, anchors[2].dy);
    _ctrlAnchors[4].update((anchors[2].dx - _difference) * animation.value, anchors[2].dy);
    _ctrlAnchors[5].update(anchors[3].dx, anchors[3].dy - _difference);
    _ctrlAnchors[6].update(anchors[3].dx, anchors[3].dy + _difference);
    _ctrlAnchors[7].update((anchors[0].dx - _difference) * animation.value, anchors[0].dy);
  }

  void drawCircle(Canvas canvas, List<_Offset> _anchors, List<_Offset> ctrl) {
    updateCircleAnchors();
    updateCircleCtrlAnchors(_anchors);
    _path.reset();

    _path.moveTo(_anchors[0].dx, _anchors[0].dy);
    _path.cubicTo(ctrl[0].dx, ctrl[0].dy, ctrl[1].dx, ctrl[1].dy, _anchors[1].dx, _anchors[1].dy);
    _path.cubicTo(ctrl[2].dx, ctrl[2].dy, ctrl[3].dx, ctrl[3].dy, _anchors[2].dx, _anchors[2].dy);
    _path.cubicTo(ctrl[4].dx, ctrl[4].dy, ctrl[5].dx, ctrl[5].dy, _anchors[3].dx, _anchors[3].dy);
    _path.cubicTo(ctrl[6].dx, ctrl[6].dy, ctrl[7].dx, ctrl[7].dy, _anchors[0].dx, _anchors[0].dy);

    canvas.drawPath(_path, _paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2); // 移动坐标到中心
    canvas.scale(-1, -1); // 翻转X, Y轴

    drawCircle(canvas, _anchors, _ctrlAnchors);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class _Offset extends OffsetBase {
  double dx;
  double dy;

  _Offset(this.dx, this.dy) : super(dx, dy);

  void update(double x, double y) {
    dx = x;
    dy = y;
  }
}
