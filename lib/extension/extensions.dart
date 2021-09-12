import 'dart:math';

export 'time_extension.dart';

extension RandomExtension on Random {
  // 随机生成 [mix, max) 之间的数
  int next(int min, int max) => min + nextInt(max - min);
}
