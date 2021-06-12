import 'dart:ui';

import 'package:tangram/util/shape_enum.dart';

abstract class ShapeProduct {
  Offset get cellSize;

  List<List<Offset>> get offsets;

  int get initialExtraRotation;

  Path get currentPath;

  Path get previousPath;

  Offset get position;

  Offset get origin;

  Shapes get name;

  static late final int cellSizePixel;
}
