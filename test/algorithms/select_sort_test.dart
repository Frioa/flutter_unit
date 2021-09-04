import 'package:flutter_unit/algorithms/algorithms.dart';
import 'package:flutter_unit/utils/utils.dart';

void main() {
  final dataSize = [10];

  for (final n in dataSize) {
    final list = ArrayGenerator.generateOrderedArray(n);

    final start = DateTime.now();
    for (int i = 0; i < 1; i++) {
      SelectSort.sort(list);
    }

    final end = DateTime.now();
    final diff = end.difference(start);

    log.d('n = $n, runs: ${diff.toSpendTimeInSec()}');
  }
}
