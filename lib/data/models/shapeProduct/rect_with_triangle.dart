import 'dart:ui';
import 'package:triangram/data/models/shapeProduct/shape_product.dart';

class RectWithTriangle extends ShapeProduct {
  const RectWithTriangle({
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
  RectWithTriangle copyWith({
    Offset? positionOfBoundingRectangle,
    bool? rotationLeft,
    bool? rotationRight,
    bool? isAnchored,
  }) =>
      RectWithTriangle(
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
      [Offset(0, 0), Offset(2, 2), Offset(2, 4), Offset(0, 4)];

  @override
  List<Offset> get getInitialExtraPointsBeforeRotation =>
      [Offset(1, 1), Offset(2, 3), Offset(1, 4), Offset(0, 1), Offset(0, 2), Offset(0, 3)];

  @override
  List<Offset> getListOfOffsetsTest(int i) => RectWithTriangle.offsetsTest[i];

  @override
  String toString() {
    return '''
         RectWithTriangle{ ${super.toString()}
         ''';
  }

  static const Size shapeSize = Size(4, 4);
  static const Offset shapeOrigin = Offset(2, 2);

  static const List<List<Offset>> offsetsTest = <List<Offset>>[
    [Offset(0, 0), Offset(2, 2), Offset(2, 4), Offset(0, 4)],
    [Offset(0, 0), Offset(2, 2), Offset(2, 4), Offset(0, 4)],
    [Offset(4, 0), Offset(2, 2), Offset(0, 2), Offset(0, 0)],
    [Offset(4, 0), Offset(2, 2), Offset(0, 2), Offset(0, 0)],
    [Offset(4, 4), Offset(2, 2), Offset(2, 0), Offset(4, 0)],
    [Offset(4, 4), Offset(2, 2), Offset(2, 0), Offset(4, 0)],
    [Offset(0, 4), Offset(2, 2), Offset(4, 2), Offset(4, 4)],
    [Offset(0, 4), Offset(2, 2), Offset(4, 2), Offset(4, 4)],
  ];
}
