import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RadarChar implements Equatable {
  final double x;
  final double y;
  final double z;
  final Color background;

  // late Animation<Offset> xAnimate;
  // late Animation<Offset> yAnimate;
  // late Animation<Offset> zAnimate;
  //

  double get sum => x + y + z;

  const RadarChar({
    this.x = .0,
    this.y = .0,
    this.z = .0,
    this.background = Colors.blue,
  });

  @override
  List<Object> get props => [x, y, z, background];

  @override
  bool get stringify => true;

  List<Offset> toOffsets(List<Offset> coordinate) {
    return [
      Offset(x * coordinate[0].dx, x * coordinate[0].dy),
      Offset(y * coordinate[1].dx, y * coordinate[1].dy),
      Offset(z * coordinate[2].dx, z * coordinate[2].dy),
    ];
  }

  RadarChar operator +(RadarChar? other) {
    if (other == null) return this;

    return RadarChar(x: this.x + other.x, y: this.y + other.y, z: this.z + other.z, background: this.background);
  }

  RadarChar operator -(RadarChar? other) {
    if (other == null) return this;

    return RadarChar(x: this.x - other.x, y: this.y - other.y, z: this.z - other.z, background: this.background);
  }

  RadarChar operator *(double t) {
    return RadarChar(x: this.x * t, y: this.y * t, z: this.z * t, background: this.background);
  }

  RadarChar operator /(RadarChar other) {
    return RadarChar(x: this.x / other.x, y: this.y / other.y, z: this.z / other.z, background: this.background);
  }

  RadarChar scale({double scaleX = 1, double scaleY = 1, double scaleZ = 1}) {
    return RadarChar(x: x * scaleX, y: y * scaleY, z: z * scaleZ, background: this.background);
  }

  @override
  String toString() {
    return 'RadarChar{x: $x, y: $y, z: $z, background: $background}';
  }
}
