import 'dart:ui';
import 'dart:math' as math;
import 'package:triangram/data/models/shapeProduct/shape_product.dart';
import 'package:triangram/data/models/shapeProduct/trapezoid.dart';
import 'package:triangram/data/models/shapeProduct/triangle.dart';
import 'package:triangram/util/constants.dart';
import 'package:triangram/util/logger.dart';
import 'package:triangram/util/shape_enum.dart';
import 'package:test/test.dart';

double checkDifferenceDx({required ShapeProduct shapeProduct, required int iPositionInList}) {
  var points = shapeProduct.rotateOffsets(iPositionInList, false);
  var realPoints = shapeProduct.getOffsetList(iPositionInList);
  var diff = 0.0;

  for (var i = 0; i < points.length; i++) {
    diff = diff + points[i].dx - realPoints[i].dx;
  }

  return diff.abs();
}

double checkDifferenceDy({required ShapeProduct shapeProduct, required int iPositionInList}) {
  var points = shapeProduct.rotateOffsets(iPositionInList, false);
  log.d('points:$points');
  var realPoints = shapeProduct.getOffsetList(iPositionInList);
  log.d('realPoints:$realPoints');
  var diff = 0.0;
  ;
  for (var i = 0; i < points.length; i++) {
    diff = diff + points[i].dy - realPoints[i].dy;
  }
  return diff.abs();
}

double checkDifference({required ShapeProduct shapeProduct, required int iPositionInList}) {
  var points = shapeProduct.rotateOffsets(iPositionInList, false);
  var realPoints = shapeProduct.getOffsetList(iPositionInList);
  var diff = Offset.zero;

  for (var i = 0; i < points.length; i++) {
    diff = diff + points[i] - realPoints[i];
  }
  return (diff.dy + diff.dx).abs();
}

const marginOfError = 0.000001;

void main() {
  group('triangle getting Path ', () {
    ShapeProduct? triangle;
    setUp(() {
      triangle = Triangle(
        shape: Shapes.TriangleRed,
        positionOfBoundingRectangle: Offset(0, 0),
        positionInList: 0,
        color: kColorOrange,
        isAnchored: false,
      );
    });

    test('copyWith method 1 left rotation and moved by Offset(7,8)', () {
      var t1 = triangle?.copyWith(rotationLeft: true, positionOfBoundingRectangle: Offset(7, 8));
      expect(
          t1,
          Triangle(
              positionOfBoundingRectangle: Offset(7, 8),
              shape: Shapes.TriangleRed,
              color: kColorOrange,
              isAnchored: false,
              positionInList: 7));
    });

    test('moving triangle to Offset(3,8)', () {
      var t1 = triangle?.copyWith(positionOfBoundingRectangle: Offset(3, 8));
      expect(t1?.positionOfBoundingRectangle, Offset(3, 8));
    });

    test(
        'after 3 rotations right and after moving a triangle '
        'to point (7,3) checking path', () {
      var t1 = triangle?.copyWith(rotationRight: true);
      var t2 = t1?.copyWith(rotationRight: true);
      var t3 = t2?.copyWith(rotationRight: true);
      var t4 = t3?.copyWith(positionOfBoundingRectangle: Offset(7, 3));
      var offset = t4?.getPath().getBounds().topLeft;

      var difference = offset! -
          (Offset(1, 1) +
              Offset(
                  7 - math.sqrt(2), 3 - math.sqrt(2))); //Offset(1,1) is an origin of the triangle
      expect(difference.dx.abs() + difference.dy.abs(), lessThan(0.00001));
    });

    test(
        'after 3 rotations right and after moving a triangle '
        'to point (7,3) checking path with contain', () {
      var t1 = triangle?.copyWith(rotationRight: true);
      var t2 = t1?.copyWith(rotationRight: true);
      var t3 = t2?.copyWith(rotationRight: true);
      var t4 = t3?.copyWith(positionOfBoundingRectangle: Offset(7, 3));
      var path = t4?.getPath();
      expect(path?.contains(Offset(8, 4)), true);
      expect(path?.contains(Offset(9, 5)), false);
      expect(path?.contains(Offset(9, 3)), true);
    });

    test('getPath(pointSize=3.0) with contains after 3 rotations left and shifted by  Offset(7,3)',
        () {
      var t1 = triangle?.copyWith(rotationLeft: true);
      var t2 = t1?.copyWith(rotationLeft: true);
      var t3 = t2?.copyWith(rotationLeft: true);
      var t4 = t3?.copyWith(positionOfBoundingRectangle: Offset(7 * 3, 3 * 3));
      var path = t4?.getPath(pointSize: 3);
      expect(path?.contains(Offset(24, 12)), true);
      expect(path?.contains(Offset(24, 12)), true);
      expect(path?.contains(Offset(27, 15)), true);
      expect(path?.contains(Offset(24, 15)), false);
    });

    test('after 9 rotations right ', () {
      var t1 = triangle?.copyWith(rotationRight: true);
      var t2 = t1?.copyWith(rotationRight: true);
      var t3 = t2?.copyWith(rotationRight: true);
      var t4 = t3?.copyWith(rotationRight: true);
      var t5 = t4?.copyWith(rotationRight: true);
      var t6 = t5?.copyWith(rotationRight: true);
      var t7 = t6?.copyWith(rotationRight: true);
      var t8 = t7?.copyWith(rotationRight: true);
      var t9 = t8?.copyWith(rotationRight: true);

      expect(t9?.positionInList, 1);
    });

    test('after 9 rotations left ', () {
      var t1 = triangle?.copyWith(rotationLeft: true);
      var t2 = t1?.copyWith(rotationLeft: true);
      var t3 = t2?.copyWith(rotationLeft: true);
      var t4 = t3?.copyWith(rotationLeft: true);
      var t5 = t4?.copyWith(rotationLeft: true);
      var t6 = t5?.copyWith(rotationLeft: true);
      var t7 = t6?.copyWith(rotationLeft: true);
      var t8 = t7?.copyWith(rotationLeft: true);
      var t9 = t8?.copyWith(rotationLeft: true);

      expect(t9?.positionInList, 7);
    });

    test('after4 rotations left ', () {
      var t1 = triangle?.copyWith(rotationLeft: true);
      var t2 = t1?.copyWith(rotationLeft: true);
      var t3 = t2?.copyWith(rotationLeft: true);
      var t4 = t3?.copyWith(rotationLeft: true);

      expect(t4?.positionInList, 4);
    });

//  var offset = t4?.getPath().getBounds().topLeft;
    test(
        'getPathForUi(pointSize) when pointSize=7.65'
        'because there are like 0.002 differences', () {
      var offset = triangle?.getPathForUi(7.65).getBounds().bottomRight;
      var diff = offset! - Offset(15.3, 15.3);
      expect(diff.dx + diff.dy, lessThanOrEqualTo(0.004));
    });
  });
}
