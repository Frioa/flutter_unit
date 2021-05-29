import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/basic_knowledge/painter/painter.dart';

enum PaintWidgetType {
  antiAlias,
  stroke,
  strokeCap,
  strokeJoin,
  strokeMiterLimit,
}

mixin PaintMixin {
  Widget _widget(PaintWidgetType type, Size size) {
    switch (type) {
      case PaintWidgetType.antiAlias:
        return CustomPaint(painter: AntiAliasPainter(), size: size);
      case PaintWidgetType.stroke:
        return StrokePainterWidget(size: size);
      case PaintWidgetType.strokeCap:
        return CustomPaint(painter: StrokeCapPainter(), size: size);
      case PaintWidgetType.strokeJoin:
        return CustomPaint(painter: StrokeJoinPainter(), size: size);
      case PaintWidgetType.strokeMiterLimit:
        return CustomPaint(painter: StrokeMiterLimit(), size: size);
    }
  }

  Widget buildCustomPaint({
    PaintWidgetType type = PaintWidgetType.antiAlias,
    Size size = const Size(128, 128),
    EdgeInsets padding = const EdgeInsets.all(8.0),
  }) {
    return Padding(
      padding: padding,
      child: _widget(type, size),
    );
  }
}
