import 'package:flutter/material.dart';
import 'package:tangram/data/models/shapeProduct/shape_product.dart';
import 'package:tangram/util/shape_enum.dart';

class Triangle implements ShapeProduct {
  @override
  final Offset positionOfBoundingRectangle;
  @override
  final Shapes shape;
  @override
  final int positionInList;
  @override
  final Color color;



  const Triangle({
    required this.shape,
    required this.positionOfBoundingRectangle,
    required this.positionInList,
    required this.color,
  }) : super();

  @override
  Triangle copyWith({
    Offset? positionOfBoundingRectangle,
    bool? rotationLeft,
    bool? rotationRight,
  }) =>
      Triangle(
        color: color,
        shape: shape,
        positionInList:(rotationLeft!=null)?(positionInList-1)%8:(rotationRight!=null)?(positionInList+1)%8:positionInList,
        positionOfBoundingRectangle:
            positionOfBoundingRectangle ?? this.positionOfBoundingRectangle,
      );

  @override
  List<Offset> get pointsOfPolygonInPixel => [];

  static const Size cellSize = Size(2, 2);
  static const Offset origin = Offset(1, 1);

  @override
  Path getPath(double pointSize) => Path()
    ..addPolygon(
        [...getOffsetList((positionInList/2).floor()).map((e) => e * pointSize)], true);

  @override
  Path getPathForUi(double pointSize) => Path()
    ..addPolygon(
        [...getOffsetList(0).map((e) => e * pointSize)], true);

  static pathForUi(double pointSize)=> Path()
    ..addPolygon(
        [...getOffsetList(0).map((e) => e * pointSize)], true);

  static List<Offset> getOffsetList(int i) => offsets[i];

  static const List<List<Offset>> offsets = <List<Offset>>[
    [Offset(0, 0), Offset(2, 2), Offset(0, 2)],
    [Offset(2, 0), Offset(0, 2), Offset(0, 0)],
    [Offset(2, 2), Offset(0, 0), Offset(2, 0)],
    [Offset(0, 2), Offset(2, 0), Offset(2, 2)],
  ];

  @override
  String toString() {
    return 'Triangle{positionOfBoundingRectangle: $positionOfBoundingRectangle, \tshape: $shape,\t positionInList $positionInList\n';
  }

  @override
  Size get size => cellSize;

  @override
  bool get isPositionInListEven =>positionInList%2==0;
}
