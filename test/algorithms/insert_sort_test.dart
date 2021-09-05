import 'package:flutter_unit/algorithms/insert_sort.dart';
import 'package:flutter_unit/utils/utils.dart';

///
/// 时间复杂度 （1+n）* n * 0.5 = O（n2）
///
/// Inset Sort: n=10000, time=0.510275s
/// Inset Sort: n=100000, time=52.284906s
///
/// [InsetSortType.normal]: n=30000, time=3.17494s
/// [InsetSortType.normal](有序数组): n=30000, time=0.000963s
/// [InsetSortType.swap]: n=30000, time=4.206846s
///
///
///
void main() {
  final dataSize = [30000];
  // final dataSize = [10000, 30000 ];
  final sort1 = InsetSort();
  final sort2 = InsetSort(type: InsetSortType.swap);

  for (final n in dataSize) {
    final List<int> list1 = ArrayGenerator.generateRandomArray(n, 2 * n);
    final list2 = List.from(list1);
    final orderList = ArrayGenerator.generateOrderedArray(n);
    sort1.test(list1);
    sort2.test(list2);
    sort1.test(orderList);
  }
}
