import 'dart:math';

import 'package:flutter_unit/utils/utils.dart';
import 'package:flutter_unit/extension/extensions.dart';

int defaultCompare(Object? value1, Object? value2) =>
    (value1 as Comparable<Object?>).compareTo(value2);

Duration timing(Function function) {
  final start = DateTime.now();
  function.call();
  final end = DateTime.now();
  return end.difference(start);
}

class ArrayGenerator {
  ArrayGenerator._();

  /// TODO: @AspectD
  static List<int> generateOrderedArray(int n, [bool reversed = false]) {
    final start = DateTime.now();
    final list = List.filled(n, 0, growable: true);

    for (int i = 0; i < n; i++) {
      list[i] = i;
    }
    if (reversed) list.reversed;
    final end = DateTime.now();
    final diff = end.difference(start);

    log.i(diff.toSpendTimeInSec());

    return list;
  }

  ///
  /// TODO: @AspectD
  /// 生成一个长度位 n 的数组
  static List<int> generateRandomArray(int n, int max) {
    final list = List.filled(n, 0, growable: true);

    final rnd = Random();

    final diff = timing(() {
      for (int i = 0; i < n; i++) {
        list[i] = rnd.nextInt(max);
      }
    });
    log.i(diff.toSpendTimeInSec());

    return list;
  }
}

class AlgorithmsUtils {
  static const int intMax = 9223372036854775807;
  static const int intMin = -9223372036854775807;

  static bool isSorted<E>(List<E> list, [int Function(E, E)? compare]) {
    final _compare = compare ?? defaultCompare;
    for (int i = 1; i < list.length; i++) {
      if (_compare(list[i - 1], list[i]) > 0) return false;
    }

    return true;
  }

  static void sortTest<E>(String sortName, List<E> list) {

  }
}
