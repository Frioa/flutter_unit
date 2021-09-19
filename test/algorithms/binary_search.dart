import 'package:flutter_unit/algorithms/binary_search.dart';

void main() {
  // final search = BinarySearch(type: BinarySearchType.lowerCeil);
  final search = BinarySearch(type: BinarySearchType.upperFloor);

  final list = [1, 1, 3, 3, 5, 5, 7, 7];
  // final list = [1, 1, 1];


  for (int i = 0; i <= 7; i++) {
    final res = search.search(list, i);

    print('res[${i}] ${res}');
  }
}
