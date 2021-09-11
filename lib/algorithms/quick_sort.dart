import 'package:flutter_unit/algorithms/algorithms.dart';
import 'package:flutter_unit/utils/utils.dart';
import 'package:collection/collection.dart';

enum QuickSortType { normal }

class QuickSort<T> extends Sort<T> {
  final QuickSortType type;

  QuickSort({
    this.type = QuickSortType.normal,
    int Function(T, T) compare = defaultCompare,
  }) : super(compare);

  @override
  String get name => 'Quick Sort';

  @override
  void sort(List<T> list) {
    if (type == QuickSortType.normal) quickSort(list, 0, list.length - 1);
  }

  void quickSort(List<T> list, int left, int right) {
    if (left >= right) return;

    final p = partition(list, left, right);
    quickSort(list, left, p - 1);
    quickSort(list, p + 1, right);
  }

  int partition(List<T> list, int left, int right) {
    final int kIndex = left;
    int i = left + 1;
    int j = right;

    while (true) {
      while (i <= right && compare(list[i], list[kIndex]) < 0) {
        i++;
      }

      while (j >= left && compare(list[j], list[kIndex]) > 0) {
        j--;
      }

      if (i > j) break;

      list.swap(i++, j--);
    }
    list.swap(kIndex, j);

    return j;
  }
}
