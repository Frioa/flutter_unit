import 'package:flutter_unit/utils/utils.dart';
import 'package:flutter_unit/extension/extensions.dart';

class ArrayGenerator {
  ArrayGenerator._();

  /// TODO: @AspectD
  static List<int> generateOrderedArray(int n) {
    final start = DateTime.now();
    final list = List.filled(n, 0, growable: true);

    for (int i = 0; i < n; i++) {
      list[i] = i;
    }
    final end = DateTime.now();
    final diff = end.difference(start);

    log.i(diff.toSpendTimeInSec());

    return list;
  }
}
