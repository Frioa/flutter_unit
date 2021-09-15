import 'package:flutter_unit/utils/algorithms_utils.dart';

abstract class Search<E> {
  final int Function(E, E) compare;

  Search([this.compare = defaultCompare]);

  int search(List<E> data, E target);
}