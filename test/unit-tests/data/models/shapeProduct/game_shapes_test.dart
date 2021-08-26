import 'dart:ui';

import 'package:triangram/data/models/shapeProduct/game_shapes.dart';
import 'package:triangram/data/models/shapeProduct/rect_with_triangle.dart';
import 'package:triangram/data/models/shapeProduct/rect_without_triangle.dart';
import 'package:triangram/data/models/shapeProduct/shape_product.dart';
import 'package:triangram/data/models/shapeProduct/trapezoid.dart';
import 'package:triangram/data/models/shapeProduct/triangle.dart';
import 'package:triangram/util/constants.dart';
import 'package:triangram/util/shape_enum.dart';
import 'package:test/test.dart';

void main() {
  group('Gameshapes', () {
    var triangleRed;
    var triangleBlue;
    var triangleGreen;
    var trapezoid;
    var rectWithTriangle;
    var rectWithoutTriangle;
    var gS;
    var gSCopy;
    var gSCopy2;

    GameShapes? gameShapes;
    setUp(() {
      triangleRed = const Triangle(
          isAnchored: false,
          color: kColorOrange,
          shape: Shapes.TriangleRed,
          positionInList: 0,
          positionOfBoundingRectangle: Offset(0, 0));

      triangleBlue = const Triangle(
          isAnchored: false,
          color: kColorBlue,
          shape: Shapes.TriangleBlue,
          positionInList: 0,
          positionOfBoundingRectangle: Offset(1, 0));

      triangleGreen = const Triangle(
          isAnchored: false,
          color: kColorGreen,
          shape: Shapes.TriangleGreen,
          positionInList: 0,
          positionOfBoundingRectangle: Offset(1, 1));

      trapezoid = const Trapezoid(
          isAnchored: false,
          color: kColorOrange,
          shape: Shapes.Trapezoid,
          positionInList: 0,
          positionOfBoundingRectangle: Offset(1, 1));

      rectWithTriangle = const RectWithTriangle(
          isAnchored: false,
          color: kColorOrange,
          shape: Shapes.RectWithTriangle,
          positionInList: 0,
          positionOfBoundingRectangle: Offset(3, 3));

      rectWithoutTriangle = const RectWithoutTriangle(
          isAnchored: false,
          color: kColorOrange,
          shape: Shapes.RectWithoutTriangle,
          positionInList: 0,
          positionOfBoundingRectangle: Offset(0, 0));

      gS = GameShapes(shapes: <Shapes, ShapeProduct>{
        Shapes.TriangleRed: triangleRed,
        Shapes.TriangleBlue: triangleBlue,
        Shapes.TriangleGreen: triangleGreen,
        Shapes.Trapezoid: trapezoid,
        Shapes.RectWithTriangle: rectWithTriangle,
        Shapes.RectWithoutTriangle: rectWithoutTriangle,
      });

      gSCopy = GameShapes(shapes: <Shapes, ShapeProduct>{
        Shapes.TriangleRed: triangleRed,
        Shapes.TriangleBlue: triangleBlue,
        Shapes.TriangleGreen: triangleGreen,
        Shapes.Trapezoid: trapezoid.copyWith(positionOfBoundingRectangle: Offset(7, 3)),
        Shapes.RectWithTriangle: rectWithTriangle,
        Shapes.RectWithoutTriangle: rectWithoutTriangle,
      });

      gSCopy2 = GameShapes(shapes: <Shapes, ShapeProduct>{
        Shapes.TriangleRed: triangleRed,
        Shapes.TriangleBlue: triangleBlue,
        Shapes.TriangleGreen: triangleGreen,
        Shapes.Trapezoid: trapezoid,
        Shapes.RectWithTriangle: rectWithTriangle.copyWith(rotationLeft: true),
        Shapes.RectWithoutTriangle: rectWithoutTriangle,
      });
      gameShapes = GameShapes(shapes: <Shapes, ShapeProduct>{
        Shapes.TriangleRed: triangleRed,
        Shapes.TriangleBlue: triangleBlue,
        Shapes.TriangleGreen: triangleGreen,
        Shapes.Trapezoid: trapezoid,
        Shapes.RectWithTriangle: rectWithTriangle,
        Shapes.RectWithoutTriangle: rectWithoutTriangle
      });
    });

    test('equity of two the same objects', () {
      expect(gameShapes, gS);
    });

    test('copyWith shape: Shapes.Trapezoid, and  positionOfBoundingRectangle', () {
      var copyOfGameShape =
          gameShapes?.copyWith(shape: Shapes.Trapezoid, positionOfBoundingRectangle: Offset(7, 3));
      expect(copyOfGameShape, gSCopy);
    });

    test('copyWith shape: Shapes.RectangleWithTriangle, and rotation left', () {
      var copyOfGameShape =
          gameShapes?.copyWith(shape: Shapes.RectWithTriangle, rotationLeft: true);
      expect(copyOfGameShape, gSCopy2);
    });

    test('isPositionInAllShapesEven ', () {
      expect(gSCopy2.isPositionInAllShapesEven, false);
    });

    test('isPositionInAllShapesEven ', () {
      expect(gameShapes?.isPositionInAllShapesEven, true);
    });

    test('getShape(Shapes.RectWithTriangle) ', () {
      expect(
          gSCopy2.getShape(Shapes.RectWithTriangle), rectWithTriangle.copyWith(rotationLeft: true));
    });

    test(
        'getPathMap(pointSize=3)  , and RectWithTriangle gets 3 rotation right and shift=Offset(2,2) ',
        () {
      //3 rotation right

      var gameShapesAfter1stRotation =
          gS.copyWith(shape: Shapes.RectWithTriangle, rotationRight: true);
      var gameShapesAfter2ndtRotation =
          gameShapesAfter1stRotation.copyWith(shape: Shapes.RectWithTriangle, rotationRight: true);
      var gameShapesAfter3rdtRotation =
          gameShapesAfter2ndtRotation.copyWith(shape: Shapes.RectWithTriangle, rotationRight: true);
      GameShapes gameShapesAfter3rdtRotationShifted = gameShapesAfter3rdtRotation.copyWith(
          shape: Shapes.RectWithTriangle, positionOfBoundingRectangle: Offset(2 * 3, 2 * 3));

      var map = gameShapesAfter3rdtRotationShifted.getMyPathMap(pointSize: 3.0);
      var rectWithTrianglePath = map[Shapes.RectWithTriangle];
      expect(rectWithTrianglePath?.contains(Offset(18, 6)), true);
      expect(rectWithTrianglePath?.contains(Offset(6.0, 6.0)), true);

      expect(rectWithTrianglePath?.contains(Offset(6.0, 15)), false);
      expect(rectWithTrianglePath?.contains(Offset(12, 15.0)), false);
    });
  });
}
