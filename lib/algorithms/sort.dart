import 'package:flutter_unit/utils/utils.dart';

abstract class Sort<T extends Comparable> {
  String get name;

  void sort(List<T> list);

  void test(List<T> list) {
    final diff = timing(
      () {
        sort(list);
      },
    );

    if (!isSorted(list)) {
      throw Exception('$name sort failed');
    } else {
      log.d('$name: n=${list.length}, time=${diff.toSpendTimeInSec()}');
    }
  }

  bool isSorted(List<T> list) {
    for (int i = 1; i < list.length; i++) {
      if (list[i - 1].compareTo(list[i]) > 0) return false;
    }

    return true;
  }
}
