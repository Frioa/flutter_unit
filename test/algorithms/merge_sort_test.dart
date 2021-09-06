import 'package:flutter_unit/algorithms/algorithms.dart';
import 'package:flutter_unit/utils/utils.dart';

///
/// 时间复杂度 o(NlogN)
///
/// Merge Sort: n=100000, time=0.045847s
/// Merge Sort（优化有序数组）: n=100000, time=0.003985s
///
///

void main() {
  final dataSize = [5000000];
  final sort = MergeSort();

  for (final n in dataSize) {
    final List<int> list1 = ArrayGenerator.generateRandomArray(n, 2 * n);
    final List<int> orderList = ArrayGenerator.generateOrderedArray(n);


    sort.test(list1);
    sort.test(orderList);
  }
}
