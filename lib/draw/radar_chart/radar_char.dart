import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/draw/draws.dart';

part 'radar_char.g.dart';

@autoequal
class RadarChart extends Equatable {
  final List<double> values;
  final Color background;

  const RadarChart({
    this.values = const [.0, .0, .0],
    this.background = Colors.blue,
  });

  @override
  List<Object?> get props => _autoequalProps;

  List<Offset> toOffsets(List<Offset> coordinate) {
    final list = <Offset>[];
    for (int i = 0; i < coordinate.length; i++) {
      list.add(Offset(coordinate[i].dx * values[i], coordinate[i].dy * values[i]));
    }

    return list;
  }

  RadarChart operator +(RadarChart other) {
    return RadarChart(
      values: values.compute(other.values, (v1, v2) => v1 + v2),
      background: this.background,
    );
  }

  RadarChart operator -(RadarChart other) {
    return RadarChart(
      values: values.compute(other.values, (v1, v2) => v1 - v2),
      background: this.background,
    );
  }

  RadarChart operator *(double t) {
    return RadarChart(
      values: values.compute(null, (v1, v2) => v1 * t),
      background: this.background,
    );
  }

  RadarChart operator /(RadarChart other) {
    return RadarChart(
      values: values.compute(other.values, (v1, v2) => v1 / v2),
      background: this.background,
    );
  }

  @override
  String toString() {
    return 'RadarChart{values: $values, background: $background}';
  }
}
