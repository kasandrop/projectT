import 'dart:ui';

import 'package:tangram/data/models/shapeProduct/shape_product.dart';
import 'package:tangram/util/shape_enum.dart';

class RectWithTriangle implements ShapeProduct {
  @override
  final Offset cellSize = const Offset(2, 4);
  @override
  final Offset origin = const Offset(1, 2);

  @override
  final int initialExtraRotation;
  @override
  final Path currentPath;
  @override
  final Path previousPath;
  @override
  final Shapes name;
  @override
  final Offset position;

  @override
  final List<List<Offset>> offsets = const [
    [Offset(0, 0), Offset(2, 2), Offset(2, 4), Offset(0, 4)],
    [Offset(4, 0), Offset(2, 2), Offset(2, 0), Offset(0, 0)],
    [Offset(2, 4), Offset(0, 2), Offset(0, 0), Offset(2, 0)],
    [Offset(0, 2), Offset(2, 0), Offset(4, 0), Offset(4, 2)],
  ];

  const RectWithTriangle({
    required this.initialExtraRotation,
    required this.currentPath,
    required this.previousPath,
    required this.name,
    required this.position,
  }) : super();
}
