extension ListExpand<E> on List<E> {
  List<E> compute(List<E>? other, E Function(E v1, E v2) combine) {
    final List<E> list = [];
    for (int i = 0; i < length; i++) {
      list.add(combine(this[i], other == null ? this[i] : other[i]));
    }
    return list;
  }
}
