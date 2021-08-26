import 'dart:math' as math;
import 'dart:ui';

import 'package:triangram/data/models/shapeProduct/shape_product.dart';

class Triangle extends ShapeProduct {
  const Triangle({
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
  Triangle copyWith({
    Offset? positionOfBoundingRectangle,
    bool? rotationLeft,
    bool? rotationRight,
    bool? isAnchored,
  }) =>
      Triangle(
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
  List<Offset> get getInitialExtraPointsBeforeRotation => [Offset(1, 1)];

  @override
  List<Offset> get getInitialPointsBeforeRotation =>
      [Offset(0.0, 0.0), Offset(2.0, 2.0), Offset(0.0, 2.0)];
  @override
  List<Offset> getListOfOffsetsTest(int i) => Triangle.offsetsTest[i];

  @override
  String toString() {
    return '''
         Triangle{ ${super.toString()}
         ''';
  }

  static const Offset shapeOrigin = Offset(1, 1);
  static const Size shapeSize = Size(2, 2);

  static List<List<Offset>> offsetsTest = <List<Offset>>[
    [Offset(0, 0), Offset(2, 2), Offset(0, 2)],
    [Offset(1, 1 - math.sqrt(2)), Offset(1, 1 + math.sqrt(2)), Offset(1 - math.sqrt(2), 1)],
    [Offset(2, 0), Offset(0, 2), Offset(0, 0)],
    [Offset(1 + math.sqrt(2), 1), Offset(1 - math.sqrt(2), 1), Offset(1, 1 - math.sqrt(2))],
    [Offset(2, 2), Offset(0, 0), Offset(2, 0)],
    [Offset(1, 1 + math.sqrt(2)), Offset(1, 1 - math.sqrt(2)), Offset(1 + math.sqrt(2), 1)],
    [Offset(0, 2), Offset(2, 0), Offset(2, 2)],
    [Offset(1 - math.sqrt(2), 1), Offset(1 + math.sqrt(2), 1), Offset(1, 1 + math.sqrt(2))],
  ];
}
