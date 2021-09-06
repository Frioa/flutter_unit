import 'dart:math';

import 'package:flutter_unit/algorithms/algorithms.dart';
import 'package:flutter_unit/utils/algorithms_utils.dart';

enum MergeSortType {
  normal,
  bottomUp,
}

class MergeSort<T> extends Sort<T> {
  final MergeSortType type;
  late List<T> temp;

  MergeSort({
    this.type = MergeSortType.normal,
    int Function(T, T) compare = defaultCompare,
  }) : super(compare);

  @override
  String get name => 'Merge Sort';

  @override
  void sort(List<T> list) {
    temp = List.from(list);
    if (type == MergeSortType.normal) _mergeSort(list, 0, list.length - 1);
    if (type == MergeSortType.bottomUp) _bottomUp(list);
  }

  void _mergeSort(List<T> list, int left, int right) {
    if (left >= right) return;

    // final int mid = (left + right) >> 1;
    final int mid = (left + (right - left) / 2).toInt();

    /// 对 [left, mid] 进行排序
    _mergeSort(list, left, mid);

    /// 对 [mid + 1, right] 进行排序
    _mergeSort(list, mid + 1, right);

    /// [NOTE]: 优化对于两个顺序的数组
    if (compare(list[mid], list[mid + 1]) < 0) return;

    /// 对两个有序的数组进行排序
    _mergeList(list, left, mid, right);
  }

  void _bottomUp(List<T> list) {
    // 遍历合并的区间长度
    for (int sz = 1; sz < list.length; sz = sz << 1) {
      // 合并[i, i + sz -1] 和 [i  + sz, i + sz + sz -1]
      for (int left = 0; left < list.length; left += sz << 1) {
        final int right = min(left + sz + sz - 1, list.length - 1);
        final int mid = left + sz - 1;

        if (mid + 1 < t.length && compare(list[mid], list[mid + 1]) < 0) continue;

        _mergeList(list, left, mid, right);
      }
    }
  }

  void _mergeList(List<T> list, int left, int mid, int right) {
    List.copyRange(temp, left, list, left, right + 1);
    int i = left;
    int j = mid + 1;

    for (int index = left; index <= right; index++) {
      late T curValue;
      if (i > mid) {
        curValue = temp[j++];
      } else if (j > right) {
        curValue = temp[i++];
      } else if (compare(temp[i], temp[j]) < 0) {
        curValue = temp[i++];
      } else {
        curValue = temp[j++];
      }
      list[index] = curValue;
    }
  }
}

// 1 2
// 0 0 1
