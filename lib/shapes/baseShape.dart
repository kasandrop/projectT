import 'package:flutter/material.dart';

import '../coordinateSystem.dart';

abstract class BaseShape {
  // final int width;
  final Color color;
  final Offset origin;
  final List<PointSystem> points = [];

  BaseShape();
}
