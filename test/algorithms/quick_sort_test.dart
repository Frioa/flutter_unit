import 'package:flutter_unit/algorithms/algorithms.dart';
import 'package:flutter_unit/utils/utils.dart';

///
/// 时间复杂度 O(NlogN)
///
/// Quick Sort: n=100000, time=0.041194s
/// Quick Sort: n=1000000, time=0.444719s
///
///

void main() {
  final dataSize = [100000];
  final sort = QuickSort();

  for (final n in dataSize) {
    // final List<int> list1 = ArrayGenerator.generateRandomArray(n, 2 * n);
    final List<int> list1 = ArrayGenerator.generateOrderedArray(n );

    sort.test(list1);
  }
}
