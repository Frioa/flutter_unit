import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/custom_draw/radar_char/radar_chars.dart';

class RadarChar implements Equatable {
  final List<double> values;
  final Color background;

  const RadarChar({
    this.values = const [.0, .0, .0],
    this.background = Colors.blue,
  });

  @override
  List<Object> get props => [values, background];

  @override
  bool get stringify => true;

  List<Offset> toOffsets(List<Offset> coordinate) {
    final list = <Offset>[];
    for (int i = 0; i < coordinate.length; i++) {
      list.add(Offset(coordinate[i].dx * values[i], coordinate[i].dy * values[i]));
    }

    return list;
  }

  RadarChar operator +(RadarChar other) {
    return RadarChar(
      values: values.compute(other.values, (v1, v2) => v1 + v2),
      background: this.background,
    );
  }

  RadarChar operator -(RadarChar other) {
    return RadarChar(
      values: values.compute(other.values, (v1, v2) => v1 - v2),
      background: this.background,
    );
  }

  RadarChar operator *(double t) {
    return RadarChar(
      values: values.compute(null, (v1, v2) => v1 * t),
      background: this.background,
    );
  }

  RadarChar operator /(RadarChar other) {
    return RadarChar(
      values: values.compute(other.values, (v1, v2) => v1 / v2),
      background: this.background,
    );
  }

  @override
  String toString() {
    return 'RadarChar{values: $values, background: $background}';
  }
}
