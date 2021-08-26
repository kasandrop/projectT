import 'dart:ui';

import 'package:triangram/blocs/data/data_state.dart';
import 'package:triangram/data/models/shapeProduct/game_shapes.dart';
import 'package:triangram/data/models/shapeProduct/rect_with_triangle.dart';
import 'package:triangram/data/models/shapeProduct/rect_without_triangle.dart';
import 'package:triangram/data/models/shapeProduct/shape_product.dart';
import 'package:triangram/data/models/shapeProduct/trapezoid.dart';
import 'package:triangram/data/models/shapeProduct/triangle.dart';
import 'package:triangram/data/models/shape_order.dart';
import 'package:triangram/util/constants.dart';
import 'package:triangram/util/shape_enum.dart';
import 'package:test/test.dart';

const shapeOrderWithAll = ShapeOrder(order: <Shapes>[
  Shapes.TriangleGreen,
  Shapes.TriangleRed,
  Shapes.TriangleBlue,
  Shapes.Trapezoid,
  Shapes.RectWithTriangle,
  Shapes.RectWithoutTriangle,
]);

const gameShapesAfterModification = GameShapes(
  shapes: <Shapes, ShapeProduct>{
    Shapes.TriangleRed: Triangle(
        isAnchored: false,
        color: kColorOrange,
        shape: Shapes.TriangleRed,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(0, 0)),
    Shapes.TriangleBlue: Triangle(
        isAnchored: false,
        color: kColorBlue,
        shape: Shapes.TriangleBlue,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(1, 0)),
    Shapes.TriangleGreen: Triangle(
        isAnchored: false,
        color: kColorGreen,
        shape: Shapes.TriangleGreen,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(1, 1)),
    Shapes.RectWithoutTriangle: RectWithoutTriangle(
        isAnchored: false,
        color: kColorOrange,
        shape: Shapes.RectWithoutTriangle,
        positionInList: 7,
        positionOfBoundingRectangle: Offset(0, 0)),
    Shapes.RectWithTriangle: RectWithTriangle(
        isAnchored: false,
        color: kColorOrange,
        shape: Shapes.RectWithTriangle,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(3, 3)),
    Shapes.Trapezoid: Trapezoid(
        isAnchored: false,
        color: kColorOrange,
        shape: Shapes.Trapezoid,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(10, 10)),
  },
);

const gameShapesToCheckGetPathForUi = GameShapes(
  shapes: <Shapes, ShapeProduct>{
    Shapes.TriangleRed: Triangle(
        isAnchored: false,
        color: kColorOrange,
        shape: Shapes.TriangleRed,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(0, 0)),
    Shapes.TriangleBlue: Triangle(
        isAnchored: false,
        color: kColorBlue,
        shape: Shapes.TriangleBlue,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(1, 0)),
    Shapes.TriangleGreen: Triangle(
        isAnchored: false,
        color: kColorGreen,
        shape: Shapes.TriangleGreen,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(1, 1)),
    Shapes.RectWithoutTriangle: RectWithoutTriangle(
        isAnchored: false,
        color: kColorOrange,
        shape: Shapes.RectWithoutTriangle,
        positionInList: 7,
        positionOfBoundingRectangle: Offset(0, 0)),
    Shapes.RectWithTriangle: RectWithTriangle(
        isAnchored: false,
        color: kColorOrange,
        shape: Shapes.RectWithTriangle,
        positionInList: 0,
        positionOfBoundingRectangle: Offset(3, 3)),
    Shapes.Trapezoid: Trapezoid(
        isAnchored: false,
        color: kColorOrange,
        shape: Shapes.Trapezoid,
        positionInList: 6,
        positionOfBoundingRectangle: Offset(10, 10)),
  },
);
void main() {
  group('data_state', () {
    late DataState dataState;

    setUp(() {
      dataState = DataState(
        shapeOrder: shapeOrderWithAll,
        solve: true,
        gameShapes: GameShapes(shapes: <Shapes, ShapeProduct>{
          Shapes.TriangleRed: Triangle(
              isAnchored: false,
              color: kColorOrange,
              shape: Shapes.TriangleRed,
              positionInList: 0,
              positionOfBoundingRectangle: Offset(0, 0)),
          Shapes.TriangleBlue: Triangle(
              isAnchored: false,
              color: kColorBlue,
              shape: Shapes.TriangleBlue,
              positionInList: 0,
              positionOfBoundingRectangle: Offset(1, 0)),
          Shapes.TriangleGreen: Triangle(
              isAnchored: false,
              color: kColorGreen,
              shape: Shapes.TriangleGreen,
              positionInList: 0,
              positionOfBoundingRectangle: Offset(1, 1)),
          Shapes.RectWithoutTriangle: const RectWithoutTriangle(
              isAnchored: false,
              color: kColorOrange,
              shape: Shapes.RectWithoutTriangle,
              positionInList: 0,
              positionOfBoundingRectangle: Offset(0, 0)),
          Shapes.RectWithTriangle: const RectWithTriangle(
              isAnchored: false,
              color: kColorOrange,
              shape: Shapes.RectWithTriangle,
              positionInList: 0,
              positionOfBoundingRectangle: Offset(3, 3)),
          Shapes.Trapezoid: Trapezoid(
              isAnchored: false,
              color: kColorOrange,
              shape: Shapes.Trapezoid,
              positionInList: 0,
              positionOfBoundingRectangle: Offset(1, 1)),
        }),
      );
    });

    test('getShape(Shapes.TriangleBlue)', () {
      expect(
          dataState.getShape(Shapes.TriangleBlue),
          Triangle(
              isAnchored: false,
              color: kColorBlue,
              shape: Shapes.TriangleBlue,
              positionInList: 0,
              positionOfBoundingRectangle: Offset(1, 0)));
    });

    test('get currentFocus', () {
      expect(dataState.currentFocus, Shapes.RectWithoutTriangle);
    });

    test(
        'Shapes.trapezoid moved to Offset(10,10) and '
        'Shapes.RectWithoutTriangle rotated left'
        'checking value comparison of the state and isSolved method  ', () {
      var dataStateTrapezoidFocus = dataState.copyWith(focusShape: Shapes.Trapezoid);
      var dataStateTrapezoidMoved =
          dataStateTrapezoidFocus.copyWith(positionOfBoundingRectangle: Offset(10, 10));

      var dataStateRectWithoutTriangleFocus =
          dataStateTrapezoidMoved.copyWith(focusShape: Shapes.RectWithoutTriangle);
      var dataStateRectWithoutTriangleRotatedLeft =
          dataStateRectWithoutTriangleFocus.copyWith(rotationLeft: true);

      expect(
        dataStateRectWithoutTriangleRotatedLeft,
        DataState(
            solve: true,
            shapeOrder: ShapeOrder(order: <Shapes>[
              Shapes.TriangleGreen,
              Shapes.TriangleRed,
              Shapes.TriangleBlue,
              Shapes.RectWithTriangle,
              Shapes.Trapezoid,
              Shapes.RectWithoutTriangle,
            ]),
            gameShapes: gameShapesAfterModification),
      );

      expect(
          dataStateRectWithoutTriangleRotatedLeft.isSolved(),
          DataState(
              gameShapes: gameShapesAfterModification,
              solve: true,
              shapeOrder: ShapeOrder(order: <Shapes>[
                Shapes.TriangleGreen,
                Shapes.TriangleRed,
                Shapes.TriangleBlue,
                Shapes.RectWithTriangle,
                Shapes.Trapezoid,
                Shapes.RectWithoutTriangle,
              ])).isSolved());
    });

    test(
        'Shapes.trapezoid moved to Offset(10,10) and  rotated left  2 times'
        'Shapes.RectWithoutTriangle rotated left '
        'checking getPathForUi()  ', () {
      var dataStateTrapezoidFocus = dataState.copyWith(focusShape: Shapes.Trapezoid);
      var dataStateTrapezoidMoved =
          dataStateTrapezoidFocus.copyWith(positionOfBoundingRectangle: Offset(10, 10));

      var dataStateTrapezoidRotated = dataStateTrapezoidMoved.copyWith(rotationLeft: true);
      var dataStateTrapezoidRotated2Times = dataStateTrapezoidRotated.copyWith(rotationLeft: true);

      var dataStateRectWithoutTriangleFocus =
          dataStateTrapezoidRotated2Times.copyWith(focusShape: Shapes.RectWithoutTriangle);
      var dataStateRectWithoutTriangleRotatedLeft =
          dataStateRectWithoutTriangleFocus.copyWith(rotationLeft: true);

      //check getPathForUi(Shapes.Trapezoid,pointSize:20)

      var realPath = dataStateRectWithoutTriangleRotatedLeft.getPathForUi(
          shape: Shapes.Trapezoid, pointSize: 20);
      var expectedPath = DataState(
              solve: true,
              shapeOrder: ShapeOrder(order: <Shapes>[
                Shapes.TriangleGreen,
                Shapes.TriangleRed,
                Shapes.TriangleBlue,
                Shapes.RectWithTriangle,
                Shapes.Trapezoid,
                Shapes.RectWithoutTriangle,
              ]),
              gameShapes: gameShapesToCheckGetPathForUi)
          .getPathForUi(shape: Shapes.Trapezoid, pointSize: 20);

      var pathDifference = Path.combine(PathOperation.difference, realPath, expectedPath);

      var realLength = pathDifference.computeMetrics().length;
      expect(realLength, 0);

      //check getPathForUi(Shapes.RectWithoutTriangle,pointSize:20)
      var realPath2 = dataStateRectWithoutTriangleRotatedLeft.getPathForUi(
          shape: Shapes.RectWithoutTriangle, pointSize: 20);
      var expectedPath2 = DataState(
              solve: true,
              shapeOrder: ShapeOrder(order: <Shapes>[
                Shapes.TriangleGreen,
                Shapes.TriangleRed,
                Shapes.TriangleBlue,
                Shapes.RectWithTriangle,
                Shapes.Trapezoid,
                Shapes.RectWithoutTriangle,
              ]),
              gameShapes: gameShapesToCheckGetPathForUi)
          .getPathForUi(shape: Shapes.RectWithoutTriangle, pointSize: 20);

      var pathDifference2 = Path.combine(PathOperation.difference, realPath2, expectedPath2);

      var realLength2 = pathDifference2.computeMetrics().length;
      expect(realLength2, 0);
    });
  });
}
