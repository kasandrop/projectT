import 'dart:ui';

import 'package:triangram/data/models/shapeProduct/rect_with_triangle.dart';
import 'package:triangram/data/models/shapeProduct/shape_product.dart';
import 'package:triangram/data/models/shapeProduct/triangle.dart';
import 'package:triangram/util/constants.dart';
import 'package:triangram/util/shape_enum.dart';
import 'package:test/test.dart';

void main() {
  group('rect_with_triangle getting Path ', () {
    ShapeProduct? rectWithTriangle;
    setUp(() {
      rectWithTriangle = RectWithTriangle(
        shape: Shapes.RectWithTriangle,
        positionOfBoundingRectangle: Offset(0, 0),
        positionInList: 0,
        color: kColorOrange,
        isAnchored: false,
      );
    });

    test('copyWith method 1 left rotation and moved by Offset(7,8)', () {
      var t1 =
          rectWithTriangle?.copyWith(rotationLeft: true, positionOfBoundingRectangle: Offset(7, 8));
      expect(
          t1,
          RectWithTriangle(
              positionOfBoundingRectangle: Offset(7, 8),
              isAnchored: false,
              shape: Shapes.RectWithTriangle,
              color: kColorOrange,
              positionInList: 7));
    });

    test('moving triangle to Offset(3,8)', () {
      var t1 = rectWithTriangle?.copyWith(positionOfBoundingRectangle: Offset(3, 8));
      expect(t1?.positionOfBoundingRectangle, Offset(3, 8));
    });

    test(
        'after 3 rotations right and after moving a RectWithTriangle '
        'to point (6,8) checking path', () {
      var t1 = rectWithTriangle?.copyWith(rotationRight: true);
      var t2 = t1?.copyWith(rotationRight: true);
      var t3 = t2?.copyWith(rotationRight: true);
      var t4 = t3?.copyWith(positionOfBoundingRectangle: Offset(6, 8));
      var offset = t4?.getPath().getBounds().topLeft;
      expect(offset, Offset(6, 8));
      //  expect(rect,Rect.fromLTWH(6, 8, 2, 2));
    });

    test(
        'after 3 rotations right and after moving a rectangleWithTriangle '
        'to point (7,3) checking path with contain', () {
      var t1 = rectWithTriangle?.copyWith(rotationRight: true);
      var t2 = t1?.copyWith(rotationRight: true);
      var t3 = t2?.copyWith(rotationRight: true);
      var t4 = t3?.copyWith(positionOfBoundingRectangle: Offset(7, 3));
      var path = t4?.getPath();
      expect(path?.contains(Offset(11, 3)), true);
      expect(path?.contains(Offset(11, 4)), false);
      expect(path?.contains(Offset(9, 3)), true);
      expect(path?.contains(Offset(10, 6)), false);
    });

    test('getPath(pointSize=3.0) with contains after 3 rotations left and shifted by  Offset(7,3)',
        () {
      var t1 = rectWithTriangle?.copyWith(rotationLeft: true);
      var t2 = t1?.copyWith(rotationLeft: true);
      var t3 = t2?.copyWith(rotationLeft: true);
      var t4 = t3?.copyWith(positionOfBoundingRectangle: Offset(7 * 3, 3 * 3));
      var path = t4?.getPath(pointSize: 3);
      expect(path?.contains(Offset(33, 9)), true);
      expect(path?.contains(Offset(30, 18)), true);
      expect(path?.contains(Offset(24, 12)), false);
      expect(path?.contains(Offset(21, 9)), false);
    });

    test('after 9 rotations right ', () {
      var t1 = rectWithTriangle?.copyWith(rotationRight: true);
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
      var t1 = rectWithTriangle?.copyWith(rotationLeft: true);
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
      var t1 = rectWithTriangle?.copyWith(rotationLeft: true);
      var t2 = t1?.copyWith(rotationLeft: true);
      var t3 = t2?.copyWith(rotationLeft: true);
      var t4 = t3?.copyWith(rotationLeft: true);

      expect(t4?.positionInList, 4);
    });

//  var offset = t4?.getPath().getBounds().topLeft;
    test(
        'getPathForUi(pointSize) when pointSize=7.65'
        'because there are like 0.002 differences', () {
      var offset = rectWithTriangle?.getPathForUi(7.65).getBounds().bottomRight;
      var diff = offset! - Offset(30.6, 30.6);
      expect(diff.dx + diff.dy, lessThanOrEqualTo(0.004));
    });
  });
}
