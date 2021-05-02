import 'package:flutter/material.dart';
import 'package:tangram/util/coordinateSystem.dart';
import 'package:tangram/util/settings.dart';

abstract class BaseShape {
  final Offset origin;
  final List<PointSystem> points = [];

  BaseShape({required this.origin});
}
//
// class DraggingMechanism {
//   Settings _settings;
//   Settings get settings => _settings ?? DraggingMechanism.check();
// }
