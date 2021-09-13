import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter_unit/algorithms/algorithms.dart';
import 'package:flutter_unit/utils/utils.dart';

enum QuickSortType {
  normal,
  threeWay,
}

class QuickSort<T> extends Sort<T> {
  final QuickSortType type;
  Random random = Random();

  QuickSort({
    this.type = QuickSortType.normal,
    int Function(T, T) compare = defaultCompare,
  }) : super(compare);

  @override
  String get name => 'Quick Sort(type: $type)';

  @override
  void sort(List<T> list) {
    if (type == QuickSortType.normal) quickSort(list, 0, list.length - 1);
    if (type == QuickSortType.threeWay) threeWaySort(list, 0, list.length - 1);
  }

  void quickSort(List<T> list, int left, int right) {
    if (left >= right) return;

    final p = partition(list, left, right);
    quickSort(list, left, p - 1);
    quickSort(list, p + 1, right);
  }

  int partition(List<T> list, int left, int right) {
    /// [NOTE]: 使用随机数优化，因对于完全有序数组会退化为 O(n^2) 级别
    list.swap(random.next(left, right + 1), left);

    final int kIndex = left;
    int i = left + 1;
    int j = right;

    while (true) {
      while (i <= j && compare(list[i], list[kIndex]) < 0) {
        i++;
      }

      while (j >= i && compare(list[j], list[kIndex]) > 0) {
        j--;
      }

      if (i >= j) break;
      list.swap(i, j);
      i++;
      j--;
    }
    list.swap(kIndex, j);

    return j;
  }

  void threeWaySort(List<T> list, int left, int right) {
    if (left >= right) return;

    final _ThreeWayNode node = threeWayPartition(list, left, right);

    threeWaySort(list, left, node.lt);
    threeWaySort(list, node.gt, right);
  }

  /// 将数组分成三部分，
  /// arr[left + 1,lt] < v, arr[lt + 1, i - 1] == v, arr[gt, r] > v
  _ThreeWayNode threeWayPartition(List<T> list, int left, int right) {
    list.swap(random.next(left, right + 1), left);

    final k = left;
    final kValue = list[k];
    // arr[left + 1,lt] < v, arr[lt + 1, i - 1] == v, arr[gt, r] > v
    int lt = left;
    int gt = right + 1;
    int i = left + 1;

    while (i < gt) {
      // 移动 i 的位置
      if (compare(list[i], kValue) == 0) {
        i++;
        // 扩充前面的区间，lt + 1，并且交互位置
      } else if (compare(list[i], kValue) < 0) {
        list.swap(++lt, i++);
      } else {
        // 扩充 > v 的区域 gt - 1，并且交互位置。注：不用 i ++
        list.swap(--gt, i);
      }
    }

    // 与 k 位置交换，因为 kValue 等于 v ，所以 lt - 1
    list.swap(k, lt--);

    return _ThreeWayNode(lt, gt);
  }
}

class _ThreeWayNode {
  // lt 代表小于 v 的最后一个 index
  final int lt;

  // gt 代表大于 v 的第一个 index
  final int gt;

  _ThreeWayNode(this.lt, this.gt);
}
