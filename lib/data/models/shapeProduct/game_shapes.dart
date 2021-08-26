import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:triangram/data/models/shapeProduct/shape_product.dart';
import 'package:triangram/util/logger.dart';
import 'package:triangram/util/shape_enum.dart';
import 'dart:developer';

@immutable
class GameShapes extends Equatable {
  final Map<Shapes, ShapeProduct> shapes;

  const GameShapes({
    required this.shapes,
  });

  @override
  List<Object> get props => [shapes];

  Map<Shapes, MyPath> getMyPathMap({double pointSize = 1}) =>
      {for (Shapes e in Shapes.values) e: getShape(e).getMyPath(pointSize: pointSize)};

  ShapeProduct getShape(Shapes shape) => shapes[shape]!;

  bool get isPositionInAllShapesEven =>
      shapes.values.toList().every((element) => element.isPositionInListEven == true);

  GameShapes copyWith(
      {required Shapes shape,
      Offset? positionOfBoundingRectangle,
      bool? rotationLeft,
      bool? rotationRight}) {
    var map = Map<Shapes, ShapeProduct>.of(shapes);
    var shapeToUpdate = map.remove(shape)!;
    var shapeUpdated = shapeToUpdate.copyWith(
      rotationRight: rotationRight,
      positionOfBoundingRectangle: positionOfBoundingRectangle,
      rotationLeft: rotationLeft,
    );
    map[shape] = shapeUpdated;
    var gm = GameShapes(shapes: map);
    //  log.d('gameShape:  ${gm.shapes}');

    return gm;
  }
}
