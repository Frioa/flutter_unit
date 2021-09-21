import 'package:equatable/equatable.dart';

class BST<T extends Comparable> {
  late Node<T>? root;
  late int _size;

  int get size => _size;

  BST({this.root, int size = 0}) {
    _size = size;
  }

  void add(T t) {
    if (root == null) {
      root = Node<T>(t);
    } else {
      _add(root!, t);
    }
  }

  void _add(Node<T> node, T e) {
    if (node.e == e) return;
    if (e.compareTo(node.e) < 0 && node.left == null) {
      node.left = Node(e);
      _size++;
      return;
    } else if (e.compareTo(node.e) > 0 && node.right == null) {
      node.right = Node(e);
      _size++;
      return;
    }

    if (e.compareTo(node.e) < 0) {
      _add(node.left!, e);
    } else {
      _add(node.right!, e);
    }
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
