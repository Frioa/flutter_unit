import 'package:flutter_unit/algorithms/algorithms.dart';
import 'package:flutter_unit/utils/algorithms_utils.dart';

enum MergeSortType { normal }

class MergeSort<T> extends Sort<T> {
  final MergeSortType type;

  MergeSort({
    this.type = MergeSortType.normal,
    int Function(T, T) compare = defaultCompare,
  }) : super(compare);

  @override
  String get name => 'Merge Sort';

  @override
  void sort(List<T> list) {
    if (type == MergeSortType.normal) _mergeSort(list, 0, list.length - 1);
  }

  void _mergeSort(List<T> list, int left, int right) {
    if (left >= right) return;

    // final int mid = (left + right) >> 1;
    final int mid = (left + (right - left) / 2).toInt();

    /// 对 [left, mid] 进行排序
    _mergeSort(list, left, mid);

    /// 对 [mid + 1, right] 进行排序
    _mergeSort(list, mid + 1, right);

    /// 对两个有序的数组进行排序
    mergeList(list, left, mid, right);
  }

  void mergeList(List<T> list, int left, int mid, int right) {
    final List copyList = List.filled(right - left + 1, 0);
    List.copyRange(list, left, copyList);

    int i = left;
    int j = mid + 1;

    for (int index = left; index <= right; index++) {
      late T curValue;
      if (i > mid) {
        curValue = copyList[j++ - left];
      } else if (j > right) {
        curValue = copyList[i++ - left];
      } else if (compare(copyList[i - left], copyList[j - left]) < 0) {
        curValue = copyList[i++ - left];
      } else {
        curValue = copyList[j++ - left];
      }
      list[index] = curValue;
    }
  }
}

// 1 2
// 0 0 1
