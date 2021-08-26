import 'dart:math' as math;
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:triangram/util/shape_enum.dart';
import 'package:vector_math/vector_math.dart';

abstract class ShapeProduct extends Equatable {
  //0-means 0 degree rotated  ->0 position from  List pointsOfPolygonInPixel
  //1-means 45 degrees rotated->still 0 position from List
  //2-mean 90 degrees rotated and ->1st position from List pointsOfPolygonInPixel

  final Color colorFrom;
  final Color colorTo;
  final Offset positionOfBoundingRectangle;
  final Shapes shape;
  final int positionInList;
  final Color color;
  final bool isAnchored;
  final Offset origin;
  final Size size;

  const ShapeProduct({
    required this.shape,
    required this.isAnchored,
    required this.positionOfBoundingRectangle,
    required this.positionInList,
    required this.color,
    required this.colorFrom,
    required this.colorTo,
    required this.origin,
    required this.size,
  });

  //------------ abstract methods to override
  //it is the starting point /Offset/ where Shape starts to draw

  //other shapes may anchor to anchor shape. Default is false.

  bool get isPositionInListEven;

  List<Offset> get getInitialExtraPointsBeforeRotation;

  List<Offset> get getInitialPointsBeforeRotation;

  List<Offset> getListOfOffsetsTest(int i);

  ShapeProduct copyWith({
    bool? rotationLeft,
    bool? rotationRight,
    Offset? positionOfBoundingRectangle,
    bool? isAnchored,
  });
  List<Offset> get pointsOfPolygon => getOffsetList(positionInList, true);

  @override
  List<Object> get props => [
        shape,
        isAnchored,
        positionOfBoundingRectangle,
        positionInList,
        color,
        colorFrom,
        colorTo,
        origin,
        size,
      ];

  List<Offset> getOffsetList(int i, [bool extraPoints = false]) => rotateOffsets(i, extraPoints);

  Path getPath({double pointSize = 1}) {
    var p = Path();
    p.addPolygon(
        [...getOffsetList(positionInList).map((e) => e * pointSize + positionOfBoundingRectangle)],
        true);
    // var p1 = p.shift(positionOfBoundingRectangle);
    return p;
  }

  MyPath getMyPath({double pointSize = 1}) => MyPath(
      pointsOfPolygon: getOffsetList(positionInList),
      positionOfBoundingRectangle: positionOfBoundingRectangle);

  Path getPathForUi(double pointSize) => Path()
    ..fillType = PathFillType.evenOdd
    ..addPolygon([...getOffsetList(0).map((e) => e * pointSize)], true);

  @override
  bool get stringify => false;
  @override
  String toString() {
    return '''ShapeProduct {  shape: $shape, 
                          colorFrom: $colorFrom, 
                            colorTo: $colorTo,
        positionOfBoundingRectangle: $positionOfBoundingRectangle,
                     positionInList: $positionInList,
                              color: $color,
                         isAnchored: $isAnchored,
                             origin: $origin, 
                               size: $size }''';
  }

  List<Offset> rotateOffsets(int i, bool extraPoints) {
    List<Offset> initialPoints;
    var T = Matrix4.rotationZ(math.pi / 4 * i);
    if (extraPoints == true) {
      initialPoints = getInitialPointsBeforeRotation + getInitialExtraPointsBeforeRotation;
    } else {
      initialPoints = [...getInitialPointsBeforeRotation];
    }

    return initialPoints.map((Offset offset) {
      var translatedOffset = offset - origin;
      var position = Vector3(translatedOffset.dx, translatedOffset.dy, 0);
      var newV3 = T.transform3(position);
      var newOffset = Offset(newV3.storage.elementAt(0), newV3.storage.elementAt(1));
      return (newOffset + origin);
    }).toList();
  }
}

class MyPath {
  final List<Offset> pointsOfPolygon;
  final Offset positionOfBoundingRectangle;

  MyPath({required this.pointsOfPolygon, required this.positionOfBoundingRectangle});

  bool contains(Offset offset) => path.contains(offset);

  List<Offset> get pointsOfPolygonActual =>
      pointsOfPolygon.map((e) => e + positionOfBoundingRectangle).toList();

  Path get path => Path()..addPolygon(pointsOfPolygonActual, true);
}
