import 'package:flutter_unit/algorithms/algorithms.dart';
import 'package:flutter_unit/utils/utils.dart';
import 'package:collection/collection.dart';

enum SelectSortType {
  normal,
  normalReverse,
  situ,
}

class SelectSort<T> extends Sort<T> {
  final SelectSortType type;

  SelectSort({
    this.type = SelectSortType.normal,
    int Function(T, T) compare = defaultCompare,
  }) : super(compare);

  @override
  void sort(List<T> list) {
    if (type == SelectSortType.normal) return _normal(list);
    if (type == SelectSortType.normalReverse) return _normalReverse(list);

    return _situ(list);
  }

  void _normal(List<T> list) {
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

  void _normalReverse(List<T> list) {
    for (int i = list.length - 1; i >= 0; i--) {
      var maxIndex = i;
      for (int j = i; j >= 0; j--) {
        if (compare(list[j], list[maxIndex]) > 0) {
          maxIndex = j;
        }
      }
      list.swap(i, maxIndex);
    }
  }

  void _situ(List<T> list) {
    final newList = List<T>.filled(list.length, list[0]);
    final visit = List<bool>.filled(list.length, false);

    for (int i = 0; i < list.length; i++) {
      var minIndex = 0;
      for (int j = 0; j < list.length; j++) {
        if (!visit[j] && compare(list[j], list[minIndex]) < 0) {
          minIndex = j;
        }
      }
      newList[i] = list[minIndex];
      visit[minIndex] = true;
    }

    for (int i = 0; i < list.length; i++) {
      list[i] = newList[i];
    }
  }

  @override
  String get sortName => 'Select Sort';
}
