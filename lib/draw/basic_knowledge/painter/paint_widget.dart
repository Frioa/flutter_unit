import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_unit/draw/basic_knowledge/painter/painter.dart';
import 'package:flutter_unit/provider/provider.dart';

class PaintWidget extends StatefulWidget {
  @override
  _PaintWidgetState createState() => _PaintWidgetState();
}

class _PaintWidgetState extends State<PaintWidget> with PaintMixin {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        width: L.screenWidth,
        padding: EdgeInsets.only(top: 48.sp, left: 16.sp, right: 16.sp),
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MarkDownBodyWidget('### 【Paint 篇】认识画笔 <br>'
                '**一、详细认识画笔**<br>'
                '1. 颜色 `color` 和是否抗锯齿 `isAntiAlias` <br>'
                '> **蓝色是抗锯齿**的，边缘比较圆润,右侧**红色是非抗锯齿**的，边缘比较粗糙'),
            buildCustomPaint(size: Size(L.screenWidth, 130)),
            const MarkDownBodyWidget('2. 画笔类型 `style` 和线宽 `strokeWidth` <br>'
                '> 画笔类型有填充 `PaintingStyle.fill` 和线条 `PaintingStyle.stroke`。'),
            buildCustomPaint(
              type: PaintWidgetType.stroke,
              size: Size(L.screenWidth, 120),
              padding: EdgeInsets.symmetric(vertical: 8.sp),
            ),
            const MarkDownBodyWidget('> **注意:** 只有画笔是 `stroke` 类型线宽才会起作用。 而且线条的宽度有一半在外侧，必要时需要进行校正'),
            const MarkDownBodyWidget('**二、详细认识画笔**<br>'
                '* `strokeCap:` 线帽类型\n'
                '* `strokeJoin:` 线接类型\n'
                '* `strokeMiterLimit:` 斜接限制\n\n'
                '**1. 线帽类型strokeCap**\n\n<br>'
                '> - StrokeCap.butt - 不出头\n'
                '> - StrokeCap.round - 圆头\n'
                '> - StrokeCap.square - 方头\n'
                ''),
            buildCustomPaint(
              type: PaintWidgetType.strokeCap,
              size: Size(L.screenWidth, 120),
              padding: EdgeInsets.symmetric(vertical: 8.sp),
            ),

            const MarkDownBodyWidget(
                '**2. 线接类型 strokeJoin**\n\n<br>'
                '`线接类型只适用于Path的线段绘制。它不适用于用【Canvas.drawPoints】绘制的线。`\n'
                '> - StrokeJoin.bevel - 斜角\n'
                '> - StrokeJoin.miter - 锐角\n'
                '> - StrokeJoin.round - 圆角\n'
                ''),
            buildCustomPaint(
              type: PaintWidgetType.strokeJoin,
              size: Size(L.screenWidth, 120),
              padding: EdgeInsets.symmetric(vertical: 8.sp),
            ),

            const MarkDownBodyWidget(
                '**3. 线接类型 strokeMiterLimit**\n\n<br>'
                    '>`strokeMiterLimit只适用于【StrokeJoin.miter】。`\n'
                    '>它是一个对斜接的限定，如果超过阈值，会变成【StrokeJoin.bevel】。 \n'
                    '>因为考虑到锐角太尖，会影响视觉。\n'
                    ''),

            buildCustomPaint(
              type: PaintWidgetType.strokeMiterLimit,
              size: Size(L.screenWidth, 350),
              padding: EdgeInsets.symmetric(vertical: 8.sp),
            ),

          ],
        ),
      ),
    );
  }
}
