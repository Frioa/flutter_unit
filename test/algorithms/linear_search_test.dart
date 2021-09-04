import 'package:flutter_unit/algorithms/linear_search.dart';
import 'package:flutter_unit/utils/logs/logs.dart';
import 'package:flutter_unit/utils/utils.dart';

///
/// 测试线程查找的性能
/// 结论：时间复杂度 O（N）
/// 1. main n = 1000000, 100 runs: Spend time 0.061863s
/// 2. main n = 10000000, 100 runs: Spend time 0.74305s
/// 3. main n = 100000000, 100 runs: Spend time 7.154954s
///
void main() {
  final dataSize = [1000000, 10000000, 100000000];

  for (final n in dataSize) {
    final list = ArrayGenerator.generateOrderedArray(n);

    final start = DateTime.now();
    for (int i = 0; i < 100; i++) {
      LinearSearch.search(list, n);
    }
    final end = DateTime.now();
    final diff = end.difference(start);

    log.d('n = $n, 100 runs: ${diff.toSpendTimeInSec()}');
  }
}
