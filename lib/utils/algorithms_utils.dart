import 'package:flutter_unit/utils/utils.dart';
import 'package:flutter_unit/extension/extensions.dart';


int defaultCompare(Object? value1, Object? value2) =>
    (value1 as Comparable<Object?>).compareTo(value2);

class ArrayGenerator {
  ArrayGenerator._();

  /// TODO: @AspectD
  static List<int> generateOrderedArray(int n, [bool reversed = false]) {
    final start = DateTime.now();
    final list = List.filled(n, 0, growable: true);

    for (int i = 0; i < n; i++) {
      list[i] = i;
    }
    if (reversed) list.reversed;
    final end = DateTime.now();
    final diff = end.difference(start);

    log.i(diff.toSpendTimeInSec());

    return list;
  }


}

class AlgorithmsUtils {
  static const int intMax = 9223372036854775807;
  static const int intMin = -9223372036854775807;

}
