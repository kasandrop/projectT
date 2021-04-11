import 'package:flutter/material.dart';

import '../coordinateSystem.dart';

abstract class BaseShape {
  final int width;
  final Color color;
  final List<PointSystem> points = [];

  BaseShape({
    required this.color,
    required this.width,
  });
}
