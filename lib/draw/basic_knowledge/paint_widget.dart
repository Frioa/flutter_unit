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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MarkDownBodyWidget('### 【Paint 篇】认识画笔 <br>'
                '**一、详细认识画笔**<br>'
                '1. 颜色 `color` 和是否抗锯齿 `isAntiAlias` <br>'
                '> **蓝色是抗锯齿**的，边缘比较圆润,右侧**红色是非抗锯齿**的，边缘比较粗糙'),
            buildCustomPaint(type: PaintWidgetType.antiAlias, size: Size(L.screenWidth, 130)),
            MarkDownBodyWidget('2. 画笔类型 `style` 和线宽 `strokeWidth` <br>'
                '> 画笔类型有填充 `PaintingStyle.fill` 和线条 `PaintingStyle.stroke`。'),
            buildCustomPaint(
              type: PaintWidgetType.stroke,
              size: Size(L.screenWidth, 120),
              padding: EdgeInsets.symmetric(vertical: 8.sp),
            ),
            MarkDownBodyWidget('> **注意:** 只有画笔是 `stroke` 类型线宽才会起作用。 而且线条的宽度有一半在外侧，必要时需要进行校正'),
          ],
        ),
      ),
    );
  }
}
