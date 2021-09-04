import 'package:flutter_unit/algorithms/algorithms.dart';
import 'package:flutter_unit/utils/utils.dart';
import 'package:collection/collection.dart';

class SelectSort<T> extends Sort<T> {
  SelectSort({
    int Function(T, T) compare = defaultCompare,
  }) : super(compare);

  @override
  void sort(List<T> list) {
    for (int i = 0; i < list.length; i++) {
      var minIndex = i;
      for (int j = i; j < list.length; j++) {
        if (compare(list[j], list[minIndex]) < 0) {
          minIndex = j;
        }
      }
      list.swap(i, minIndex);
    }
  }

  static List<int> situ(List<int> list) {
    final newList = List.filled(list.length, 0);

    for (int i = 0; i < list.length; i++) {
      var minValue = AlgorithmsUtils.intMax;
      var minIndex = -1;
      for (int j = 0; j < list.length; j++) {
        if (list[j] < minValue) {
          minValue = list[j];
          minIndex = j;
        }
      }
      list[minIndex] = AlgorithmsUtils.intMax;
      newList[i] = minValue;
    }

    return newList;
  }

  @override
  String get sortName => 'Select Sort';
}
