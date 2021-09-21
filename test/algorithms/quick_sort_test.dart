import 'package:flutter_unit/algorithms/algorithms.dart';
import 'package:flutter_unit/algorithms/quick_sort.dart';
import 'package:flutter_unit/utils/utils.dart';

///
/// 时间复杂度 O(NlogN)
///
/// Quick Sort: n=100000, time=0.041194s
/// Quick Sort: n=1000000, time=0.444719s
///
/// Quick Sort（三路）: n=100000, time=0.049435s
/// Quick Sort（三路）: n=1000000, time=0.473842s
///
///

void main() {
  final dataSize = [1000000];
  final sort2 = QuickSort(type: QuickSortType.threeWay);


  for (final n in dataSize) {
    final List<int> list1 = ArrayGenerator.generateRandomArray(n, n);

    // sort.test(list1);
    sort2.test(list1);
  }
}

// 0
// [1, 3]
// 1
//
