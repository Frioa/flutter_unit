import 'package:equatable/equatable.dart';

class BST<T extends Comparable> {
  late Node<T>? root;
  late int _size;

  int get size => _size;

  BST({this.root, int size = 0}) {
    _size = size;
  }

  void add(T e) => root = _add(root, e);

  Node<T> _add(Node<T>? node, T e) {
    if (node == null) {
      _size++;
      return Node(e);
    }

    if (e.compareTo(node.e) < 0) {
      node.left = _add(node.left, e);
    } else if (e.compareTo(node.e) > 0) {
      node.right = _add(node.right, e);
    }

    return node;
  }
}

class Node<T extends Comparable> with EquatableMixin {
  final T e;
  Node<T>? left, right;

  Node(
    this.e, {
    this.left,
    this.right,
  });

  @override
  List<Object?> get props => [e, left, right];

  int compareTo(Node<T> other) => e.compareTo(other.e);
}
