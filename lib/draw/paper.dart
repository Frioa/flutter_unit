import 'package:flutter/material.dart';

class Paper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        // 使用CustomPaint
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 创建画笔
    final Paint paint = Paint();
    final Paint linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    // 绘制圆
    canvas.drawCircle(Offset(100, 100), 10, paint);
    canvas.drawLine(Offset.zero, Offset(100,100), linePaint);

    Path path = Path();
    path.moveTo(100, 100);
    path.lineTo(200, 0);

    canvas.drawPath(path, linePaint..color = Colors.red);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
