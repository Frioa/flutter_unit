import 'package:flutter_unit/algorithms/algorithms.dart';
import 'package:flutter_unit/utils/utils.dart';

///
/// 时间复杂度 （1+n）* n * 0.5 = O（n2）
///
/// Select Sort: n=10000, time=0.605413s
/// Select Sort: n=100000, time=60.237689s
///
void main() {
  final dataSize = [10000, 20000];
  final selectSort = SelectSort();

  for (final n in dataSize) {
    final List<int> list = ArrayGenerator.generateRandomArray(n, n);

    selectSort.test(list);
  }
}
