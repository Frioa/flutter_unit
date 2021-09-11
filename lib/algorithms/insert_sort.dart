import 'package:flutter_unit/algorithms/sort.dart';
import 'package:flutter_unit/utils/utils.dart';
import 'package:collection/collection.dart';

enum InsetSortType {
  swap,
  normal,
  normalReverse,
}

///
/// 时间复杂度 O（n^2）
///
/// 由于存在 [compare(t, list[j - 1])] 循环会提前终止。
/// 对于近乎【有序数组】，时间复杂度将优化到 O（n）级别
///
class InsetSort<T> extends Sort<T> {
  final InsetSortType type;

  InsetSort({
    this.type = InsetSortType.normal,
    int Function(T, T) compare = defaultCompare,
  }) : super(compare);

  @override
  String get name => 'Inset Sort';

  @override
  void sort(List<T> list, [int? left, int? right]) {
    final int _left = left ?? 0;
    final int _right = right ?? list.length;
    if (type == InsetSortType.normal) return _normal(list, _left, _right);
    if (type == InsetSortType.normalReverse) return _normalReverse(list);
    if (type == InsetSortType.swap) return _swap(list);
  }

  /// list[0, i) 排好序，list[i, n) 未排序
  ///
  /// 相较于 [InsetSortType.swap] 进行了常数级别的优化
  /// 优化原因：寻址次数减少，赋值由三次变为一次
  ///
  void _normal(List<T> list, int left, int right) {
    for (int i = left; i <= right; i++) {
      int j = i;
      final t = list[i];
      for (; j > left && compare(t, list[j - 1]) < 0; j--) {
        list[j] = list[j - 1];
      }
      list[j] = t;
    }
  }

  void _normalReverse(List<T> list) {
    for (int i = list.length - 1; i >= 0; i--) {
      int j = i;
      final t = list[i];

      for (; j + 1 < list.length && compare(t, list[j + 1]) > 0; j++) {
        list[j] = list[j + 1];
      }
      list[j] = t;
    }
  }

  ///
  /// [NOTE]: 通过 swap 进行交换
  ///
  void _swap(List<T> list) {
    for (int i = 1; i < list.length; i++) {
      for (int j = i; j > 0; j--) {
        if (compare(list[j - 1], list[j]) < 0) break;

        list.swap(j, j - 1);
      }
    }
  }
}
