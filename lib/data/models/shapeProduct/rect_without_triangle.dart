/*
List<int> list = [1, 2, 3];
var map = Map<String, int>.fromIterable(list,
    key: (item) => item.toString(),
    value: (item) => item * item);
 */

import 'dart:ui';

import 'package:triangram/data/models/shapeProduct/shape_product.dart';

class RectWithoutTriangle extends ShapeProduct {
  const RectWithoutTriangle({
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
  RectWithoutTriangle copyWith({
    Offset? positionOfBoundingRectangle,
    bool? rotationLeft,
    bool? rotationRight,
    bool? isAnchored,
  }) =>
      RectWithoutTriangle(
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

  //overriding to make convex path
  @override
  Path getPathForUi(double pointSize) => Path()
    ..fillType = PathFillType.evenOdd
    ..addPolygon([
      ...[Offset(2, 0), Offset(2, 4), Offset(0, 2)].map((e) => e * pointSize)
    ], true)
    ..addPolygon([
      ...[Offset(2, 2), Offset(4, 2), Offset(2, 4)].map((e) => e * pointSize)
    ], true);

  @override
  bool get isPositionInListEven => positionInList % 2 == 0;

  @override
  List<Offset> get getInitialPointsBeforeRotation =>
      [Offset(2, 0), Offset(2, 2), Offset(4, 2), Offset(2, 4), Offset(0, 2)];

  @override
  List<Offset> get getInitialExtraPointsBeforeRotation =>
      [Offset(1, 1), Offset(2, 1), Offset(3, 2), Offset(3, 3), Offset(1, 3)];

  @override
  List<Offset> getListOfOffsetsTest(int i) => RectWithoutTriangle.offsetsTest[i];

  @override
  String toString() {
    return '''
         RectWithoutTriangle{ ${super.toString()}
         ''';
  }

  static const Size shapeSize = Size(4, 4);
  static const Offset shapeOrigin = Offset(2, 2);

  static const List<List<Offset>> offsetsTest = <List<Offset>>[
    [Offset(2, 0), Offset(2, 2), Offset(4, 2), Offset(2, 4), Offset(0, 2)],
    [Offset(2, 0), Offset(2, 2), Offset(4, 2), Offset(2, 4), Offset(0, 2)],
    [Offset(4, 2), Offset(2, 2), Offset(2, 4), Offset(0, 2), Offset(2, 0)],
    [Offset(4, 2), Offset(2, 2), Offset(2, 4), Offset(0, 2), Offset(2, 0)],
    [Offset(2, 4), Offset(2, 2), Offset(0, 2), Offset(2, 0), Offset(4, 2)],
    [Offset(2, 4), Offset(2, 2), Offset(0, 2), Offset(2, 0), Offset(4, 2)],
    [Offset(0, 2), Offset(2, 2), Offset(2, 0), Offset(4, 2), Offset(2, 4)],
    [Offset(0, 2), Offset(2, 2), Offset(2, 0), Offset(4, 2), Offset(2, 4)],
  ];
}
