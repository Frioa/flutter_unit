import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/draws.dart';


class CircleLoadingWidget extends StatelessWidget {
  final Color color;
  final double size;

  const CircleLoadingWidget({
    Key? key,
    this.color = Colors.blue,
    this.size = 100,
  }) : super(key: key);

  static final _minSize = 48.0;

  static final _maxSize = 120.0;

  double get _size => size.clamp(_minSize, _maxSize);

  /// TODO: 使用 Tween 优化
  double _strokeWidth(double size) {
    if (size <= 54.0) return 4.0;

    if (size <= 72.0) return 5.0;

    if (size <= 84.0) return 6.0;

    if (size <= 108.0) return 7.0;

    return 8.0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _size,
      width: _size,
      child: Stack(
        children: <Widget>[
          CircleLoadingAnim(
            size: size,
            color: color,
            strokeWidth: _strokeWidth(size),
          ),
          CircleLoadingAnim(
            size: size,
            color: color,
            strokeWidth: _strokeWidth(size),
            axis: Axis.horizontal,
            delay: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
