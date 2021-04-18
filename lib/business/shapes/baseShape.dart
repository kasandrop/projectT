import 'package:flutter/material.dart';
import 'package:tangram/business/coordinateSystem.dart';

abstract class BaseShape {
  final Offset origin;
  final List<PointSystem> points = [];

  BaseShape({
    required this.origin,
  });
}
