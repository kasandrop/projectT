import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:triangram/blocs/data/data.dart';
import 'package:triangram/data/models/puzzle.dart';

import 'package:triangram/data/models/shapeProduct/game_shapes.dart';
import 'package:triangram/data/models/shapeProduct/shape_data.dart';
import 'package:triangram/data/models/shape_order.dart';

import 'package:triangram/config/injection_container.dart';
import 'package:triangram/util/constants.dart';
import 'package:triangram/util/shape_enum.dart';

class MockGameShapes extends Mock implements GameShapes {}

class MockShapeOrder extends Mock implements ShapeOrder {}

const shapeOrderWithTrapezoid = ShapeOrder(order: <Shapes>[Shapes.Trapezoid]);

const shapeOrderWithAll = ShapeOrder(order: <Shapes>[
  Shapes.TriangleGreen,
  Shapes.TriangleRed,
  Shapes.TriangleBlue,
  Shapes.Trapezoid,
  Shapes.RectWithTriangle,
  Shapes.RectWithoutTriangle,
]);

const shapeOrderWithAllFocusedTrapezoid = ShapeOrder(order: <Shapes>[
  Shapes.TriangleGreen,
  Shapes.TriangleRed,
  Shapes.TriangleBlue,
  Shapes.RectWithTriangle,
  Shapes.RectWithoutTriangle,
  Shapes.Trapezoid,
]);

const shapeOrderWithAllButTrapezoid = ShapeOrder(order: <Shapes>[
  Shapes.TriangleGreen,
  Shapes.TriangleRed,
  Shapes.TriangleBlue,
  Shapes.RectWithTriangle,
  Shapes.RectWithoutTriangle,
]);

const cross = <Offset>[
  Offset(2, 0),
  Offset(4, 0),
  Offset(4, 2),
  Offset(6, 2),
  Offset(6, 4),
  Offset(4, 4),
  Offset(4, 8),
  Offset(2, 8),
  Offset(2, 4),
  Offset(0, 4),
  Offset(0, 2),
  Offset(2, 2),
];

void main() {
  group('Data Bloc', () {
    late GameShapes mockGameShapes;
    late ShapeOrder mockShapeOrder;
    late DataBloc dataBloc;
    late GameShapes gameShapesForInitialState;
    late Puzzle puzzle;

    setUp(() {
      puzzle = Puzzle(points: cross);

      mockGameShapes = MockGameShapes();
      mockShapeOrder = MockShapeOrder();
      dataBloc = DataBloc(gameShapes: mockGameShapes, shapeOrder: mockShapeOrder)..puzzle = puzzle;
      gameShapesForInitialState = GameShapes(shapes: <Shapes, ShapeProduct>{
        Shapes.TriangleRed: Triangle(
            isAnchored: false,
            color: kColorOrange,
            shape: Shapes.TriangleRed,
            positionInList: 0,
            positionOfBoundingRectangle: Offset(0, 0)),
        Shapes.TriangleBlue: Triangle(
            color: kColorBlue,
            isAnchored: false,
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
            positionOfBoundingRectangle: Offset(0, 0)),
      });
    });

    test('initial state is DataState   and 2 states are equal', () {
      expect(
        dataBloc.state,
        DataState(gameShapes: mockGameShapes, shapeOrder: mockShapeOrder, solve: false),
      );
    });

    blocTest<DataBloc, DataState>(
      'emits [DataState] with solve true '
      'when panelButton is clicked to show a Shape',
      build: () {
        when(() => mockShapeOrder.copyWith(addShape: Shapes.Trapezoid))
            .thenReturn(shapeOrderWithTrapezoid);
        return dataBloc;
      },
      act: (bloc) => bloc.add(const ShowShapeEvent(showShape: Shapes.Trapezoid)),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        DataState(
          gameShapes: mockGameShapes,
          shapeOrder: shapeOrderWithTrapezoid,
          solve: true,
        )
      ],
      verify: (_) {
        verify(() => mockShapeOrder.copyWith(
              addShape: Shapes.Trapezoid,
              shapes: any(named: 'shapes'),
              removeShape: any(named: 'removeShape'),
              newFocusShape: any(named: 'newFocusShape'),
            )).called(1);
      },
    );

    blocTest<DataBloc, DataState>(
      'emits [DataState] with solve false  when a panelButton is clicked again to hide a Shape',
      build: () {
        when(() => mockShapeOrder.copyWith(
              addShape: any(named: 'addShape'),
              shapes: any(named: 'shapes'),
              removeShape: Shapes.Trapezoid,
              newFocusShape: any(named: 'newFocusShape'),
            )).thenReturn(shapeOrderWithAllButTrapezoid);
        return dataBloc;
      },
      act: (bloc) => bloc.add(const HideShapeEvent(hideShape: Shapes.Trapezoid)),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        DataState(
          gameShapes: mockGameShapes,
          shapeOrder: shapeOrderWithAllButTrapezoid,
          solve: false,
        )
      ],
      verify: (_) {
        verify(() => mockShapeOrder.copyWith(
              addShape: any(named: 'addShape'),
              shapes: any(named: 'shapes'),
              removeShape: Shapes.Trapezoid,
              newFocusShape: any(named: 'newFocusShape'),
            )).called(1);
      },
    );

    blocTest<DataBloc, DataState>(
      'emits [DataState] with solve False when a  shape/focus/ is clicked',
      build: () {
        when(() => mockShapeOrder.copyWith(addShape: Shapes.Trapezoid))
            .thenReturn(shapeOrderWithAllFocusedTrapezoid);
        return dataBloc;
      },
      act: (bloc) {
        bloc.add(const FocusEvent(focusShape: Shapes.Trapezoid));
      },
      seed: () => DataState(gameShapes: mockGameShapes, shapeOrder: shapeOrderWithAll, solve: true),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        //1
        DataState(
          gameShapes: mockGameShapes,
          shapeOrder: shapeOrderWithAllFocusedTrapezoid,
          solve: false,
        ),
      ],
    );

    blocTest<DataBloc, DataState>(
      'emits [DataState] with solve true when  shape is   released /stopped dragged/',
      build: () {
        when(() => mockGameShapes.copyWith(
                  shape: Shapes.Trapezoid,
                  rotationLeft: any(named: 'rotationLeft'),
                  rotationRight: any(named: 'rotationRight'),
                  positionOfBoundingRectangle: any(named: 'positionOfBoundingRectangle'),
                ))
            .thenReturn(gameShapesForInitialState.copyWith(
                shape: Shapes.Trapezoid, positionOfBoundingRectangle: Offset(1, 1)));
        return dataBloc;
      },
      act: (bloc) {
        bloc.add(PositionEvent(positionOfBoundingRectangle: Offset(1, 1)));
      },
      seed: () => DataState(
        gameShapes: gameShapesForInitialState,
        shapeOrder: shapeOrderWithAllFocusedTrapezoid,
        solve: false,
      ),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        //1
        DataState(
          gameShapes: GameShapes(shapes: <Shapes, ShapeProduct>{
            Shapes.TriangleRed: Triangle(
                color: kColorOrange,
                isAnchored: false,
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
                color: kColorOrange,
                shape: Shapes.RectWithoutTriangle,
                isAnchored: false,
                positionInList: 0,
                positionOfBoundingRectangle: Offset(0, 0)),
            Shapes.RectWithTriangle: const RectWithTriangle(
                color: kColorOrange,
                shape: Shapes.RectWithTriangle,
                positionInList: 0,
                isAnchored: false,
                positionOfBoundingRectangle: Offset(3, 3)),
            Shapes.Trapezoid: Trapezoid(
                isAnchored: false,
                color: kColorOrange,
                shape: Shapes.Trapezoid,
                positionInList: 0,
                positionOfBoundingRectangle: Offset(1, 1)),
          }),
          shapeOrder: shapeOrderWithAllFocusedTrapezoid,
          solve: true,
        ),
      ],
    );

    blocTest<DataBloc, DataState>(
      'emits [DataState] with solve true when  shape is   rotated right.Trapezoid is rotated',
      build: () {
        when(() => mockGameShapes.copyWith(
                  rotationLeft: any(named: 'rotationLeft'),
                  shape: Shapes.Trapezoid,
                  rotationRight: true,
                  positionOfBoundingRectangle: any(named: 'positionOfBoundingRectangle'),
                ))
            .thenReturn(
                gameShapesForInitialState.copyWith(shape: Shapes.Trapezoid, rotationRight: true));
        return dataBloc;
      },
      act: (bloc) {
        bloc.add(RightRotationEvent());
      },
      seed: () => DataState(
        gameShapes: gameShapesForInitialState,
        shapeOrder: shapeOrderWithAllFocusedTrapezoid,
        solve: false,
      ),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        //1
        DataState(
          shapeOrder: shapeOrderWithAllFocusedTrapezoid,
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
                positionInList: 1,
                positionOfBoundingRectangle: Offset(0, 0)),
          }),
        ),
      ],
    );

    blocTest<DataBloc, DataState>(
      'emits [DataState] with solve true when  shape is   rotated left.Trapezoid is rotated',
      build: () {
        when(() => mockGameShapes.copyWith(
                  rotationLeft: true,
                  shape: Shapes.Trapezoid,
                  rotationRight: any(named: 'rotationRight'),
                  positionOfBoundingRectangle: any(named: 'positionOfBoundingRectangle'),
                ))
            .thenReturn(
                gameShapesForInitialState.copyWith(shape: Shapes.Trapezoid, rotationLeft: true));
        return dataBloc;
      },
      act: (bloc) {
        bloc.add(LeftRotationEvent());
      },
      seed: () => DataState(
        gameShapes: gameShapesForInitialState,
        shapeOrder: shapeOrderWithAllFocusedTrapezoid,
        solve: false,
      ),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        //1
        DataState(
          shapeOrder: shapeOrderWithAllFocusedTrapezoid,
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
                positionInList: 7,
                positionOfBoundingRectangle: Offset(0, 0)),
          }),
        ),
      ],
    );
  });
}
// blocTest<DataBloc, DataState>(
//   'initial state\'s  currentFocus ==Null',
//   build: () =>dataBloc,
//   expect: () => [
//     DataState(
//       gameShapes: gameShapes,
//       shapeOrder: shapeOrderWithTrapezoid,
//       solve: true,
//     )
//   ],
//   verify: (_) {
//   //  verify(() => mockShapeOrder.copyWith(any(named: ))).called(1);
//   },
// );
