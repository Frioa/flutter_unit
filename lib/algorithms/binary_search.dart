import 'package:flutter_unit/algorithms/search.dart';
import 'package:flutter_unit/utils/algorithms_utils.dart';

enum BinarySearchType {
  searchR,
  normal,
  //
  upper, // 查找 大于 target 的最小索引
  lower, // 查找 小于 target 的最大索引
  upperFloor,
  lowerCeil, // 返回 >= target 的最小索引
  //
  lowerFloor,
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
    if (type == BinarySearchType.upper) {
      return _upper(data, target);
    }
    if (type == BinarySearchType.lowerCeil) {
      return _lowerCeil(data, target);
    }
    if (type == BinarySearchType.lower) {
      return _lower(data, target);
    }
    if (type == BinarySearchType.lowerFloor) {
      return _lowerFloor(data, target);
    }
    if (type == BinarySearchType.upperFloor) {
      return _upperFloor(data, target);
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

  int _upper(List<E> data, E target) {
    int left = 0;
    int right = data.length;

    while (left < right) {
      final int mid = (left + right) >> 1;
      if (compare(data[mid], target) <= 0) {
        left = mid + 1;
      } else {
        right = mid;
      }
    }

    return left;
  }

  int _lowerCeil(List<E> data, E target) {
    int left = 0;
    int right = data.length;

    while (left < right) {
      final int mid = (left + right) >> 1;
      if (compare(data[mid], target) < 0) {
        left = mid + 1;
      } else {
        right = mid;
      }
    }

    return left;
  }

  int _lower(List<E> data, E target) {
    int left = -1;
    int right = data.length - 1;

    while (left < right) {
      /// 上取整，防止死循环。
      /// 当 left 与 right 相邻并且 data[mid]<target ,left right 范围不会变化，进入死循环。
      final mid = (left + right + 1) >> 1;
      if (compare(data[mid], target) < 0) {
        left = mid;
      } else {
        right = mid - 1;
      }
    }

    return left;
  }

  int _lowerFloor(List<E> data, E target) {
    final res = _lower(data, target);
    if (res + 1 < data.length && data[res + 1] == target) {
      return res + 1;
    }
    return res;
  }

  //  查找 大于 target 的最小值
  int _upperFloor(List<E> data, E target) {
    int left = 0;
    int right = data.length;

    while(left < right) {
      final mid = (left + right) >> 1;

      if (compare(data[mid], target) <= 0) {
        left = mid + 1;
      } else {
        right = mid;
      }
    }

    if (left - 1 > 0  && data[left - 1] == target) {
      right = left - 1;
      left = 0;
      while (left < right) {
        final mid = (left + right) >> 1;
        if (compare(data[mid], target) < 0) {
          left = mid + 1;
        } else {
          right = mid;
        }
      }
    }

    return left;
  }
}
