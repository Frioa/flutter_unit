import 'dart:math';

export 'time_extension.dart';

extension RandomExtension on Random {
  int next(int min, int max) => min + nextInt(max - min);
}
