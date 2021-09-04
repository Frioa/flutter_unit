import 'package:flutter_unit/utils/utils.dart';

abstract class Sort<T> {
  final int Function(T, T) compare;

  Sort([this.compare = defaultCompare]);

  String get sortName;

  void sort(List<T> list);

  void test(List<T> list) {
    final diff = timing(
      () {
        sort(list);
      },
    );

    if (!isSorted(list)) {
      throw Exception('$sortName sort failed');
    } else {
      log.d('$sortName: n=${list.length}, time=${diff.toSpendTimeInSec()}');
    }
  }

  bool isSorted(List<T> list) {
    for (int i = 1; i < list.length; i++) {
      if (compare(list[i - 1], list[i]) > 0) return false;
    }

    return true;
  }
}
