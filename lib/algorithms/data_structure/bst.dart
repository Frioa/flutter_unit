import 'package:equatable/equatable.dart';

class BST<T extends Comparable> {
  final Node<T>? root;
  int _size = 0;

  int get size => _size;

  BST({this.root, int size = 0}) {
    _size = size;
  }
}

class Node<T extends Comparable> with EquatableMixin {
  final T e;
  final Node<T>? left, right;

  Node(
    this.e, {
    this.left,
    this.right,
  });

  @override
  List<Object?> get props => [e, left, right];
}
