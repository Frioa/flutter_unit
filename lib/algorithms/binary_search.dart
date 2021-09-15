import 'package:flutter_unit/algorithms/search.dart';
import 'package:flutter_unit/utils/algorithms_utils.dart';

enum BinarySearchType {
  searchR,
  normal,
}

class BinarySearch<E> extends Search<E> {
  final BinarySearchType type;

  BinarySearch({
    this.type = BinarySearchType.normal,
    int Function(E, E) compare = defaultCompare,
  }) : super(compare);

  @override
  int search(List<E> data, E target) {
    if (type == BinarySearchType.normal) {
      return _search(data, 0, data.length - 1, target);
    }
    if (type == BinarySearchType.searchR) {
      return _searchR(data, target);
    }

    return -1;
  }

  int _search(List<E> data, int left, int right, E target) {
    if (left > right) return -1;

    final int mid = (left + right) >> 1;
    if (data[mid] == target) return mid;

    if (compare(data[mid], target) < 0) {
      return _search(data, mid + 1, right, target);
    } else {
      return _search(data, left, mid - 1, target);
    }
  }

  int _searchR(List<E> data, E target) {
    int left = 0;
    int right = data.length;

    while (left <= right) {
      final int mid = (left + right) >> 1;
      if (data[mid] == target) {
        return mid;
      }
      if (compare(data[mid], target) < 0) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }

    return -1;
  }
}
