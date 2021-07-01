import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:tangram/data/models/shapeProduct/shape_product.dart';
import 'package:tangram/util/shape_enum.dart';

class RectWithTriangle  extends Equatable  implements ShapeProduct {
  @override
  final Offset positionOfBoundingRectangle;
  @override
  final Shapes shape;
  @override
  final int positionInList;
  @override
  final Color color;

  @override
  const RectWithTriangle({
    required this.color,
    required this.shape,
    required this.positionOfBoundingRectangle,
    required this.positionInList,
  }) : super();

  @override
  List<Object> get props => [shape,positionOfBoundingRectangle,positionInList,color];

  @override
  bool get stringify =>true;

  @override

  @override
  Path getPath(double pointSize) => Path()
    ..addPolygon(
        [...getOffsetList((positionInList/2).floor()).map((e) => e * pointSize)], true);

  @override
  Path getPathForUi(double pointSize) => Path()
    ..addPolygon(   [...getOffsetList(0).map((e) => e * pointSize)], true);

  static List<Offset> getOffsetList(int i) => offsets[i];

  @override
  Size get size => cellSize;

  @override
  List<Offset> get pointsOfPolygonInPixel => [];

  @override
  RectWithTriangle copyWith({
    Offset? positionOfBoundingRectangle,
    bool? rotationLeft, bool? rotationRight,
  }) =>
      RectWithTriangle(
        shape: shape,
        color: color,
        positionInList:(rotationLeft!=null)?(positionInList-1)%8:(rotationRight!=null)?(positionInList+1)%8:positionInList,
        positionOfBoundingRectangle:
            positionOfBoundingRectangle ?? this.positionOfBoundingRectangle,
      );

  static const Size cellSize = Size(4, 4);
  static const Offset origin = Offset(2, 2);

  static const List<List<Offset>> offsets = <List<Offset>>[
    [Offset(0, 0), Offset(2, 2), Offset(2, 4), Offset(0, 4)],
    [Offset(4, 0), Offset(2, 2), Offset(2, 0), Offset(0, 0)],
    [Offset(2, 4), Offset(0, 2), Offset(0, 0), Offset(2, 0)],
    [Offset(0, 2), Offset(2, 0), Offset(4, 0), Offset(4, 2)],
  ];



  @override
  bool get isPositionInListEven =>positionInList%2==0;
}
