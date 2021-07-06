import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:tangram/util/shape_enum.dart';

abstract class ShapeProduct  extends Equatable {
  //0-means 0 degree rotated  ->0 position from  List pointsOfPolygonInPixel
  //1-means 45 degrees rotated->still 0 position from List
  //2-mean 90 degrees rotated and ->1st position from List pointsOfPolygonInPixel
  int get positionInList;


  List<Offset> get pointsOfPolygonInPixel;

  Offset get positionOfBoundingRectangle;

  //unit data
  Path getPath({double pointSize=1});

  Path getPathForUi(double pointSize);

  Color get color;

  Shapes get shape;

  Size get size;

  bool get isPositionInListEven;




  ShapeProduct copyWith({bool? rotationLeft,bool? rotationRight, Offset? positionOfBoundingRectangle,});
}
