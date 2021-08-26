import 'dart:ui';

import 'package:triangram/data/models/shapeProduct/shape_product.dart';
import 'package:triangram/data/models/shapeProduct/trapezoid.dart';
import 'package:triangram/data/models/shapeProduct/triangle.dart';
import 'package:triangram/util/constants.dart';
import 'package:triangram/util/logger.dart';
import 'package:triangram/util/shape_enum.dart';
import 'package:test/test.dart';

double checkDifferenceDx({required ShapeProduct shapeProduct, required int iPositionInList}) {
  var points = shapeProduct.rotateOffsets(iPositionInList, false);
  var realPoints = shapeProduct.getListOfOffsetsTest(iPositionInList);
  var diff = 0.0;

  for (var i = 0; i < points.length; i++) {
    diff = diff + points[i].dx - realPoints[i].dx;
  }

  return diff.abs();
}

double checkDifferenceDy({required ShapeProduct shapeProduct, required int iPositionInList}) {
  var points = shapeProduct.rotateOffsets(iPositionInList, false);
  log.d('points:$points');
  var realPoints = shapeProduct.getListOfOffsetsTest(iPositionInList);
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
  var realPoints = shapeProduct.getListOfOffsetsTest(iPositionInList);
  var diff = Offset.zero;

  for (var i = 0; i < points.length; i++) {
    diff = diff + points[i] - realPoints[i];
  }
  return (diff.dy + diff.dx).abs();
}

const marginOfError = 0.000001;

void main() {
  group('rotating points around   trapezoid origin', () {
    ShapeProduct? trapezoid;
    ShapeProduct? t1;
    ShapeProduct? t2;
    ShapeProduct? t3;
    ShapeProduct? t4;
    ShapeProduct? t5;
    ShapeProduct? t6;
    ShapeProduct? t7;

    setUp(() {
      trapezoid = Trapezoid(
        shape: Shapes.Trapezoid,
        positionOfBoundingRectangle: Offset(7, 4),
        positionInList: 0,
        color: kColorOrange,
        isAnchored: false,
      );
      t1 = trapezoid?.copyWith(rotationRight: true);
      t2 = t1?.copyWith(rotationRight: true);
      t3 = t2?.copyWith(rotationRight: true);
      t4 = t3?.copyWith(rotationRight: true);
      t5 = t4?.copyWith(rotationRight: true);
      t6 = t5?.copyWith(rotationRight: true);
      t7 = t6?.copyWith(rotationRight: true);
    });

    test('rotating points 0 degrees ', () {
      expect(
          checkDifference(shapeProduct: trapezoid!, iPositionInList: 0), lessThan(marginOfError));
      expect(
          checkDifferenceDx(shapeProduct: trapezoid!, iPositionInList: 0), lessThan(marginOfError));
      expect(
          checkDifferenceDy(shapeProduct: trapezoid!, iPositionInList: 0), lessThan(marginOfError));
    });
    test('rotating points 45 degrees ', () {
      expect(checkDifference(shapeProduct: t1!, iPositionInList: 1), lessThan(marginOfError));
      expect(checkDifferenceDx(shapeProduct: t1!, iPositionInList: 1), lessThan(marginOfError));
      expect(checkDifferenceDy(shapeProduct: t1!, iPositionInList: 1), lessThan(marginOfError));
    });
    test('rotating points 90 degrees ', () {
      expect(checkDifference(shapeProduct: t2!, iPositionInList: 2), lessThan(marginOfError));
      expect(checkDifferenceDx(shapeProduct: t2!, iPositionInList: 2), lessThan(marginOfError));
      expect(checkDifferenceDy(shapeProduct: t2!, iPositionInList: 2), lessThan(marginOfError));
    });
    test('rotating points 135 degrees ', () {
      expect(checkDifference(shapeProduct: t3!, iPositionInList: 3), lessThan(marginOfError));
      expect(checkDifferenceDx(shapeProduct: t3!, iPositionInList: 3), lessThan(marginOfError));
      expect(checkDifferenceDy(shapeProduct: t3!, iPositionInList: 3), lessThan(marginOfError));
    });
    test('rotating points 180 degrees ', () {
      expect(checkDifference(shapeProduct: t4!, iPositionInList: 4), lessThan(marginOfError));
      expect(checkDifferenceDx(shapeProduct: t4!, iPositionInList: 4), lessThan(marginOfError));
      expect(checkDifferenceDy(shapeProduct: t4!, iPositionInList: 4), lessThan(marginOfError));
    });
    test('rotating points 225 degrees ', () {
      expect(checkDifference(shapeProduct: t5!, iPositionInList: 5), lessThan(marginOfError));
      expect(checkDifferenceDx(shapeProduct: t5!, iPositionInList: 5), lessThan(marginOfError));
      expect(checkDifferenceDy(shapeProduct: t5!, iPositionInList: 5), lessThan(marginOfError));
    });
    test('rotating points 270 degrees ', () {
      expect(checkDifference(shapeProduct: t6!, iPositionInList: 6), lessThan(marginOfError));
      expect(checkDifferenceDx(shapeProduct: t6!, iPositionInList: 6), lessThan(marginOfError));
      expect(checkDifferenceDy(shapeProduct: t6!, iPositionInList: 6), lessThan(marginOfError));
    });
    test('rotating points 315 degrees ', () {
      expect(checkDifference(shapeProduct: t7!, iPositionInList: 7), lessThan(marginOfError));
      expect(checkDifferenceDx(shapeProduct: t7!, iPositionInList: 7), lessThan(marginOfError));
      expect(checkDifferenceDy(shapeProduct: t7!, iPositionInList: 7), lessThan(marginOfError));
    });
  });
  group('trapezoid getting Path ', () {
    ShapeProduct? trapezoid;
    setUp(() {
      trapezoid = Trapezoid(
        shape: Shapes.Trapezoid,
        positionOfBoundingRectangle: Offset(0, 0),
        positionInList: 0,
        color: kColorOrange,
        isAnchored: false,
      );
    });

    test('copyWith method 1 left rotation and moved by Offset(7,8)', () {
      var t1 = trapezoid?.copyWith(rotationLeft: true, positionOfBoundingRectangle: Offset(7, 8));
      expect(
          t1,
          Trapezoid(
              positionOfBoundingRectangle: Offset(7, 8),
              shape: Shapes.Trapezoid,
              color: kColorOrange,
              positionInList: 7,
              isAnchored: false));
    });

    test('moving trapezoid to Offset(3,8)', () {
      var t1 = trapezoid?.copyWith(positionOfBoundingRectangle: Offset(3, 8));
      expect(t1?.positionOfBoundingRectangle, Offset(3, 8));
    });

    test(
        'after 3 rotations right and after moving a trapezoid '
        'to point (6,8) checking path', () {
      var t1 = trapezoid?.copyWith(rotationRight: true);
      var t2 = t1?.copyWith(rotationRight: true);
      var t3 = t2?.copyWith(rotationRight: true);
      var t4 = t3?.copyWith(positionOfBoundingRectangle: Offset(7, 3));
      var offset = t4?.getPath().getBounds().topLeft;
      expect(offset, Offset(7, 3));
      //  expect(rect,Rect.fromLTWH(6, 8, 2, 2));
    });

    test(
        'after 3 rotations right and after moving a trapezoid '
        'to point (7,3) checking path with contain', () {
      var t1 = trapezoid?.copyWith(rotationRight: true);
      var t2 = t1?.copyWith(rotationRight: true);
      var t3 = t2?.copyWith(rotationRight: true);
      var t4 = t3?.copyWith(positionOfBoundingRectangle: Offset(7, 3));
      var path = t4?.getPath();
      expect(path?.contains(Offset(11, 7)), true);
      expect(path?.contains(Offset(11, 3)), false);
      expect(path?.contains(Offset(9, 7)), true);
      expect(path?.contains(Offset(8, 7)), false);
    });

    test('getPath(pointSize=3.0) with contains after 3 rotations left and shifted by  Offset(7,3)',
        () {
      var t1 = trapezoid?.copyWith(rotationLeft: true);
      var t2 = t1?.copyWith(rotationLeft: true);
      var t3 = t2?.copyWith(rotationLeft: true);
      var t4 = t3?.copyWith(positionOfBoundingRectangle: Offset(7 * 3, 3 * 3));
      var path = t4?.getPath(pointSize: 3);
      expect(path?.contains(Offset(27, 9)), true);
      expect(path?.contains(Offset(21, 15)), true);
      expect(path?.contains(Offset(21, 9)), false);
      expect(path?.contains(Offset(33, 21)), false);
    });

    test('after 9 rotations right ', () {
      var t1 = trapezoid?.copyWith(rotationRight: true);
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
      var t1 = trapezoid?.copyWith(rotationLeft: true);
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
      var t1 = trapezoid?.copyWith(rotationLeft: true);
      var t2 = t1?.copyWith(rotationLeft: true);
      var t3 = t2?.copyWith(rotationLeft: true);
      var t4 = t3?.copyWith(rotationLeft: true);

      expect(t4?.positionInList, 4);
    });

//  var offset = t4?.getPath().getBounds().topLeft;
    test(
        'getPathForUi(pointSize) when pointSize=7.65'
        'because there are like 0.002 differences', () {
      var offset = trapezoid?.getPathForUi(7.65).getBounds().bottomRight;
      var diff = offset! - Offset(30.6, 30.6);
      expect(diff.dx + diff.dy, lessThanOrEqualTo(0.004));
    });
  });
}
