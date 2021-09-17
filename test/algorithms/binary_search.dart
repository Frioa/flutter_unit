import 'package:flutter_unit/algorithms/binary_search.dart';

void main() {
  // final search = BinarySearch(type: BinarySearchType.lowerCeil);
  final search = BinarySearch(type: BinarySearchType.lower);

  final list = [1, 1, 3, 3, 5, 5, 5];

  for (int i = 0; i <= 7; i++) {
    final res = search.search(list, i);

    print('res[${i}] ${res}');
  }
}
