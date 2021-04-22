extension ListExpand<E> on List<E> {
  List<E> compute(List<E>? other, E combine(E v1, E v2)) {
    List<E> list = [];
    for (int i = 0; i < this.length; i++) {
      list.add(combine(this[i], other == null ? this[i] : other[i]));
    }
    return list;
  }
}
