import 'package:collection/collection.dart';
import 'package:flutter_unit/algorithms/algorithms.dart';
import 'package:flutter_unit/utils/utils.dart';

enum SelectSortType {
  normal,
  normalReverse,
  situ,
}

class SelectSort<T extends Comparable> extends Sort<T> {
  final SelectSortType type;

  SelectSort({
    this.type = SelectSortType.normal,
  });

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
        if (list[j].compareTo(list[minIndex]) < 0) {
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
        if (list[j].compareTo(list[maxIndex]) > 0) {
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
        if (!visit[j] &&        list[j].compareTo(list[minIndex]) < 0
        ) {
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
  String get name => 'Select Sort .type=${type.toString()}';
}
