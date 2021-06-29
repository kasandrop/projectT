import 'dart:ui';

import 'package:tangram/data/models/shapeProduct/shape_product.dart';
import 'package:tangram/data/models/shape_order.dart';
import 'package:tangram/util/shape_enum.dart';

class GameShapes {
  final Map<Shapes, ShapeProduct> shapes;
  final ShapeOrder shapeOrder;

  const GameShapes({required this.shapes, required this.shapeOrder});

  Shapes get currentFocus => shapeOrder.currentFocus;

  ShapeProduct getShape(Shapes shape)=>shapes[shape]!;

  set currentFocus(Shapes shape) => shapeOrder.currentFocus = shape;

  set hideFocus(Shapes shape)=>throw UnimplementedError('Nie mam juz sil przerwa');

  bool get isPositionInAllShapesEven =>
      shapes.values.every((element) => element.isPositionInListEven == true);

  GameShapes copyWith(
      {Shapes? focusShape,
      bool? rotationLeft,
      Offset? positionOfBoundingRectangle,
      bool? rotationRight}) {
    if (focusShape != null) currentFocus = focusShape;
    var map = Map<Shapes, ShapeProduct>.of(shapes);
    var shapeToUpdate = map.remove(currentFocus)!;
    var shapeUpdated = shapeToUpdate.copyWith(
      rotationRight: rotationRight,
      positionOfBoundingRectangle: positionOfBoundingRectangle,
      rotationLeft: rotationLeft,
    );
    map[currentFocus] = shapeUpdated;
    return GameShapes(shapes: map, shapeOrder: shapeOrder);
  }
}
