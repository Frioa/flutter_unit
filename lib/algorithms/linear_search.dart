import 'package:equatable/equatable.dart';

class LinearSearch {
  static int search<T>(List<T> data, T target) {
    for (int i = 0; i < data.length; i++) {
      if (data[i] == target) return i;
    }

    return -1;
  }
}

class Student extends Equatable {
  final String name;

  const Student(this.name);

  @override
  List<Object?> get props => [name];
}
