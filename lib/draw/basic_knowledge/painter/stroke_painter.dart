import 'package:flutter/material.dart';
import 'package:flutter_unit/provider/provider.dart';

class StrokePainterWidget extends StatefulWidget {
  final Size size;

  const StrokePainterWidget({Key? key, required this.size}) : super(key: key);

  @override
  _StrokePainterWidgetState createState() => _StrokePainterWidgetState();
}

class _StrokePainterWidgetState extends State<StrokePainterWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: CustomPaint(
        size: widget.size,
        painter: StrokePainter(),
      ),
    );
  }
}

class StrokePainter extends CustomPainter {
  /// TODO : 更好的方式实现 hitTest
  static const double r = 60.0;
  final Offset center1 = Offset(r, r);
  final Offset center2 = Offset(r + 120.0 + 10, r);

  PaintingStyle style1 = PaintingStyle.stroke;

  PaintingStyle style2 = PaintingStyle.fill;

  bool hitTestStyle1 = false;

  bool hitTestStyle2 = false;

  PaintingStyle _updateStyle(PaintingStyle style) {
    if (style == PaintingStyle.stroke) {
      return PaintingStyle.fill;
    } else {
      return PaintingStyle.stroke;
    }
  }

  void drawStyleStrokeWidth(Canvas canvas) {
    Paint paint = Paint()..color = Colors.red;

    canvas.drawCircle(
        center1,
        r,
        paint
          ..style = style1
          ..strokeWidth = 10);
    canvas.drawCircle(
      center2,
      r,
      paint
        ..strokeWidth = 10
        ..style = style2,
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

    if ((position - center1).distance < r) {
      print('hitTest 1');

      hitTestStyle1 = true;
      return true;
    }

    // TODO:
    if ((position - center2).distance < r) {
      print('hitTest 2');

      hitTestStyle2 = true;
      return true;
    }

    return false;
  }

  @override
  bool shouldRepaint(StrokePainter oldDelegate) {
    if (oldDelegate.hitTestStyle1) {
      style1 = _updateStyle(oldDelegate.style1);
      return true;
    }

    if (oldDelegate.hitTestStyle2) {
      style2 = _updateStyle(oldDelegate.style2);
      return true;
    }

    return false;
  }
}
