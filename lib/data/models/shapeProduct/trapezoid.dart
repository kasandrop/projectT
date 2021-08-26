import 'dart:math' as math;
import 'dart:ui';

import 'package:triangram/data/models/shapeProduct/shape_product.dart';

class Trapezoid extends ShapeProduct {
  const Trapezoid({
    required shape,
    required color,
    required colorFrom,
    required colorTo,
    required isAnchored,
    required positionOfBoundingRectangle,
    required positionInList,
    required origin,
    required size,
  }) : super(
          shape: shape,
          color: color,
          colorFrom: colorFrom,
          colorTo: colorTo,
          isAnchored: isAnchored,
          positionOfBoundingRectangle: positionOfBoundingRectangle,
          positionInList: positionInList,
          origin: origin,
          size: size,
        );

  @override
  Trapezoid copyWith({
    Offset? positionOfBoundingRectangle,
    bool? rotationLeft,
    bool? rotationRight,
    bool? isAnchored,
  }) =>
      Trapezoid(
        shape: shape,
        color: color,
        colorFrom: colorFrom,
        colorTo: colorTo,
        origin: origin,
        size: size,
        positionInList: (rotationLeft != null)
            ? (positionInList - 1) % 8
            : (rotationRight != null)
                ? (positionInList + 1) % 8
                : positionInList,
        positionOfBoundingRectangle:
            positionOfBoundingRectangle ?? this.positionOfBoundingRectangle,
        isAnchored: isAnchored ?? this.isAnchored,
      );

  @override
  bool get isPositionInListEven => positionInList % 2 == 0;

  @override
  List<Offset> get getInitialPointsBeforeRotation =>
      [Offset(4.0, 0), Offset(4.0, 2.0), Offset(2.0, 4.0), Offset(0.0, 4.0)];

  @override
  List<Offset> get getInitialExtraPointsBeforeRotation =>
      [Offset(1, 3), Offset(2, 2), Offset(3, 1), Offset(3, 3)];

  @override
  List<Offset> getListOfOffsetsTest(int i) => Trapezoid.offsetsTest[i];

  @override
  String toString() {
    return '''
         Trapezoid{ ${super.toString()}
         ''';
  }

  static const Size shapeSize = Size(4, 4);
  static const Offset shapeOrigin = Offset(2, 2);
  static final List<List<Offset>> offsetsTest = <List<Offset>>[
    [Offset(4, 0), Offset(4, 2), Offset(2, 4), Offset(0, 4)], //0
    [
      Offset(2 + math.sqrt(8), 2),
      Offset(2 + math.sqrt(8) / 2, 2 + math.sqrt(8) / 2),
      Offset(2 - math.sqrt(8) / 2, 2 + math.sqrt(8) / 2),
      Offset(2 - math.sqrt(8), 2)
    ], //1
    [Offset(4, 4), Offset(2, 4), Offset(0, 2), Offset(0, 0)],
    [
      Offset(2, 2 + math.sqrt(8)),
      Offset(2 - math.sqrt(8) / 2, 2 + math.sqrt(8) / 2),
      Offset(2 - math.sqrt(8) / 2, 2 - math.sqrt(8) / 2),
      Offset(2, 2 - math.sqrt(8))
    ], //3
    [Offset(0, 4), Offset(0, 2), Offset(2, 0), Offset(4, 0)],
    [
      Offset(2 - math.sqrt(8), 2),
      Offset(2 - math.sqrt(8) / 2, 2 - math.sqrt(8) / 2),
      Offset(2 + math.sqrt(8) / 2, 2 - math.sqrt(8) / 2),
      Offset(2 + math.sqrt(8), 2)
    ], //5
    [Offset(0, 0), Offset(2, 0), Offset(4, 2), Offset(4, 4)],
    [
      Offset(2, 2 - math.sqrt(8)),
      Offset(2 + math.sqrt(8) / 2, 2 - math.sqrt(8) / 2),
      Offset(2 + math.sqrt(8) / 2, 2 + math.sqrt(8) / 2),
      Offset(2, 2 + math.sqrt(8))
    ],
  ];
}
