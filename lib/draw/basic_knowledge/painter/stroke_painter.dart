import 'package:flutter/material.dart';
import 'package:flutter_unit/provider/provider.dart';

class StrokePainterWidget extends StatefulWidget {
  @override
  _StrokePainterWidgetState createState() => _StrokePainterWidgetState();
}

class _StrokePainterWidgetState extends State<StrokePainterWidget> {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (d) {
        print('onPointerDown ');
      },
      child: CustomPaint(painter: StrokePainter()),
    );
  }
}

class StrokePainter extends CustomPainter {
  void drawStyleStrokeWidth(Canvas canvas) {
    Paint paint = Paint()..color = Colors.red;
    final r = 60.0;
    canvas.drawCircle(
        Offset(r, r),
        r,
        paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10);
    canvas.drawCircle(
      Offset(r + 120.0 + 10, r),
      r,
      paint
        ..strokeWidth = 10
        ..style = PaintingStyle.fill,
    );
    canvas.drawLine(
      Offset(-L.screenWidth, 0),
      Offset(L.screenWidth, 0),
      Paint()
        ..color = Colors.blue
        ..strokeWidth = 1,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawStyleStrokeWidth(canvas);
  }

  @override
  bool? hitTest(Offset position) {
    print('object ${position}');
    return super.hitTest(position);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
