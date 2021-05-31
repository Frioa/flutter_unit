import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_unit/provider/provider.dart';

class CanvasWidget extends StatefulWidget {
  const CanvasWidget({Key? key}) : super(key: key);

  @override
  _CanvasWidgetState createState() => _CanvasWidgetState();
}

class _CanvasWidgetState extends State<CanvasWidget> {
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
            MarkDownBodyWidget('### 【Canvas 篇】画布 \n'
                '**一、画布变换和状态**<br>'
                '画布变换主要通过一个 `4*4` 的变换矩阵。 其中 `transform` 方法是最核心的，也是最难用的。'
                '不过另外四个方法是为了简便使用，对 `transform` 的封装。\n'
                '\n'
                '- 1.`skew(double sx, double sy)` 斜切\n'
                '- 2.`rotate(double radians)` 旋转\n'
                '- 3.`scale(double sx, [double dy])` 缩放\n'
                '- 4.`transform([Float64List matrix4])` 移动\n'
                '- 5.`transform([Float64List matrix4])` 矩阵变换\n'
                '\n'
                '> 注意: 画布的变换是持久性的，变换之后所有的绘制会在变换后的画布上进行。'
                '变换不是永久性的变换，需要使用状态的存储【save】和恢复【restore】回到之前的画布状态。'),
          ],
        ),
      ),
    );
  }
}
