import 'package:flutter_unit/algorithms/algorithms.dart';
import 'package:flutter_unit/utils/utils.dart';

///
/// 时间复杂度 o(NlogN)
///
/// Inset Sort: n=10000, time=0.510275s
/// Inset Sort: n=100000, time=52.284906s
///
/// [InsetSortType.normal]: n=30000, time=3.17494s
/// [InsetSortType.normal](有序数组): n=30000, time=0.000963s
/// [InsetSortType.swap]: n=30000, time=4.206846s
///

void main() {
  final dataSize = [100000];
  final sort = MergeSort();

  for (final n in dataSize) {
    final List<int> list1 = ArrayGenerator.generateRandomArray(n, 2 * n);
    sort.test(list1);
  }
}
