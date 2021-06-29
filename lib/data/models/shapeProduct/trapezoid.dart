import 'dart:ui';

import 'package:tangram/data/models/shapeProduct/shape_product.dart';
import 'package:tangram/util/shape_enum.dart';

class Trapezoid implements ShapeProduct {
  @override
  final Offset positionOfBoundingRectangle;
  @override
  final Shapes shape;
  @override
  final int positionInList;
  @override
  final Color color;


  const Trapezoid({
    required this.color,
    required this.shape,
    required this.positionOfBoundingRectangle,
    required this.positionInList,
  }) : super();

  @override
  Path getPath(double pointSize) => Path()
    ..addPolygon(
        [...getOffsetList((positionInList/2).floor()).map((e) => e * pointSize)], true);

  @override
  Path getPathForUi(double pointSize) => Path()
    ..addPolygon(
        [...getOffsetList(0).map((e) => e * pointSize)], true);

  static List<Offset> getOffsetList(int i) => offsets[i];

  @override
  List<Offset> get pointsOfPolygonInPixel => [];

  @override
  Size get size => cellSize;

  static const Size cellSize = Size(4, 4);
  static const Size origin = Size(2, 2);

  @override
  Trapezoid copyWith({
          Offset? positionOfBoundingRectangle,
          bool? rotationLeft,  bool? rotationRight,

  }) =>
      Trapezoid(
        shape: shape,
        color: color,
        positionInList:(rotationLeft!=null)?(positionInList-1)%8:(rotationRight!=null)?(positionInList+1)%8:positionInList,
        positionOfBoundingRectangle:
            positionOfBoundingRectangle ?? this.positionOfBoundingRectangle,
      );

  @override
  String toString() {
    return 'Trapezoid{positionOfBoundingRectangle: $positionOfBoundingRectangle,\t shape: $shape,\t positionInList $positionInList\n';
  }

  static const List<List<Offset>> offsets = <List<Offset>>[
    [Offset(4, 0), Offset(4, 2), Offset(2, 4), Offset(0, 4)],
    [Offset(4, 4), Offset(2, 4), Offset(0, 2), Offset(0, 0)],
    [Offset(0, 4), Offset(0, 2), Offset(2, 0), Offset(4, 0)],
    [Offset(0, 0), Offset(2, 0), Offset(4, 2), Offset(4, 4)],
  ];

  @override
  bool get isPositionInListEven =>positionInList%2==0;
}
