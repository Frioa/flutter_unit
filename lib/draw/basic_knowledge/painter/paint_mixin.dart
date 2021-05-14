import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/basic_knowledge/painter/painter.dart';

enum PaintWidgetType {
  antiAlias,
  stroke,
}

mixin PaintMixin {
  Widget _widget(PaintWidgetType type, Size size) {
    switch (type) {
      case PaintWidgetType.antiAlias:
        return CustomPaint(painter: AntiAliasPainter(), size: size);
      case PaintWidgetType.stroke:
        return GestureDetector(
          child: CustomPaint(foregroundPainter: StrokePainter(), size: size),
          onTap: () {
            print('object');
          },

        );
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
