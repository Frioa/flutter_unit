import 'package:flutter_unit/algorithms/linear_search.dart';
import 'package:flutter_unit/utils/logs/logs.dart';
import 'package:flutter_unit/utils/utils.dart';

void main() {
  final dataSize = [1000000, 10000000];

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
