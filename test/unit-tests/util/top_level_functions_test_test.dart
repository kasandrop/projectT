import 'dart:ui';

import 'package:triangram/data/models/shapeProduct/shape_data.dart';
import 'package:triangram/util/shape_enum.dart';
import 'package:triangram/util/top_level_functions.dart';
import 'package:test/test.dart';

var cross = <Offset>[
  Offset(2.0, 0.0),
  Offset(4.0, 0.0),
  Offset(4.0, 2.0),
  Offset(6.0, 2.0),
  Offset(6.0, 4.0),
  Offset(4.0, 4.0),
  Offset(4.0, 8.0),
  Offset(2.0, 8.0),
  Offset(2.0, 4.0),
  Offset(0.0, 4.0),
  Offset(0.0, 2.0),
  Offset(2.0, 2.0),
];

RectWithoutTriangle rectWithoutTriangle1 = RectWithoutTriangle(
  isAnchored: false,
  positionOfBoundingRectangle: Offset(1.9, 2.8),
  color: Color(0xffff9800),
  positionInList: 6,
  shape: Shapes.RectWithoutTriangle,
);

void main() {
  group('top_level_functions', () {
    group('Points of trapezoid', () {
      test('Trapezoid,which bounding Rectangle=Offset(0,0) is not inside cross Polygon', () {
        var path = Path();
        path.addPolygon(cross, true);
        var every = Trapezoid.offsetsTest[6].every((Offset element) => path.contains(element));
        expect(every, false);
      });
      test('Trapezoid inside puzzle path', () {
        var offsetFromFunction = normalizeOffset(
            boundingRect: Offset(0.1, 2.1),
            pointsOfShape: Trapezoid.offsetsTest[6],
            pointsPath: cross);
        expect(offsetFromFunction, Offset(0.0, 2.0));
      });
      test('Trapezoid inside puzzle path', () {
        var offsetFromFunction = normalizeOffset(
            boundingRect: Offset(0, 2.1),
            pointsOfShape: Trapezoid.offsetsTest[6],
            pointsPath: cross);
        expect(offsetFromFunction, Offset(0.0, 2.0));
      });
    });
    group('Points of RectangleWithoutTriangle', () {
      test(
          ', which boundingRectangle=Offset(2,3) inside polygon-cross '
          'Shape of Puzzle', () {
        var path = Path();
        path.addPolygon(cross, true);
        var every = RectWithoutTriangle.offsetsTest[6]
            .every((Offset element) => path.contains(element + Offset(2, 3)));
        expect(every, false);
      });
      test('RectWithoutTriangle outside puzzle path', () {
        var offsetFromFunction = normalizeOffset(
            boundingRect: Offset(1.9, 2.8),
            pointsOfShape: RectWithoutTriangle.offsetsTest[6],
            pointsPath: cross);
        expect(offsetFromFunction, Offset(1.9, 2.8));
      });
      test('normalizeOffset function', () {
        var offsetFromFunction = normalizeOffset(
            boundingRect: Offset(1.9, -0.17),
            pointsOfShape: RectWithoutTriangle.offsetsTest[0],
            pointsPath: cross);
        expect(offsetFromFunction, Offset(2.0, 0.0));
      });
      test('normalizeOffset function', () {
        var offsetFromFunction = normalizeOffset(
            boundingRect: Offset(1.9, 0.17),
            pointsOfShape: RectWithoutTriangle.offsetsTest[0],
            pointsPath: cross);
        expect(offsetFromFunction, Offset(2.0, 0.0));
      });
      test('normalizeOffset function', () {
        var offsetFromFunction = normalizeOffset(
            boundingRect: Offset(2.13, -0.17),
            pointsOfShape: RectWithoutTriangle.offsetsTest[0],
            pointsPath: cross);
        expect(offsetFromFunction, Offset(2.0, 0.0));
      });
      test('normalizeOffset function', () {
        var offsetFromFunction = normalizeOffset(
            boundingRect: Offset(2.13, 0.17),
            pointsOfShape: RectWithoutTriangle.offsetsTest[0],
            pointsPath: cross);
        expect(offsetFromFunction, Offset(2.0, 0.0));
      });
      test('normalizeOffset function', () {
        var offsetFromFunction = normalizeOffset(
            boundingRect: Offset(2.1, 0.24),
            pointsOfShape: RectWithoutTriangle.offsetsTest[0],
            pointsPath: cross);
        expect(offsetFromFunction, Offset(2.0, 0.0));
      });
      test('offsetAbs function', () {
        var offsetFromFunction = offsetAbs(Offset(-0.44, -0.24));
        expect(offsetFromFunction, Offset(0.44, 0.24));
      });
    });
  });
}
