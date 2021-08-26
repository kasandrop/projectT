import 'dart:ui';

import 'package:bloc_test/bloc_test.dart';
import 'package:triangram/blocs/data/data.dart';
import 'package:triangram/data/models/shapeProduct/rect_with_triangle.dart';
import 'package:triangram/data/models/shapeProduct/rect_without_triangle.dart';
import 'package:triangram/data/models/shapeProduct/trapezoid.dart';
import 'package:triangram/data/models/shapeProduct/triangle.dart';
import 'package:triangram/data/models/shape_order.dart';
import 'package:triangram/util/constants.dart';
import 'package:test/test.dart';
import 'package:triangram/blocs/solver/solver.dart';
import 'package:triangram/data/models/puzzle.dart';
import 'package:triangram/data/models/shapeProduct/game_shapes.dart';
import 'package:triangram/data/models/shapeProduct/shape_product.dart';
import 'package:triangram/util/shape_enum.dart';

const gameShape = GameShapes(
  shapes: <Shapes, ShapeProduct>{
    Shapes.TriangleRed: Triangle(
      color: kColorOrange,
      shape: Shapes.TriangleRed,
      positionInList: 0,
      positionOfBoundingRectangle: Offset(0, 2),
      isAnchored: false,
    ),
    Shapes.TriangleBlue: Triangle(
      color: kColorBlue,
      shape: Shapes.TriangleBlue,
      positionInList: 2,
      positionOfBoundingRectangle: Offset(2, 0),
      isAnchored: false,
    ),
    Shapes.TriangleGreen: Triangle(
      color: kColorGreen,
      shape: Shapes.TriangleGreen,
      positionInList: 6,
      positionOfBoundingRectangle: Offset(4, 2),
      isAnchored: false,
    ),
    Shapes.RectWithoutTriangle: RectWithoutTriangle(
      color: kColorOrange,
      shape: Shapes.RectWithoutTriangle,
      positionInList: 0,
      positionOfBoundingRectangle: Offset(2, 0),
      isAnchored: false,
    ),
    Shapes.RectWithTriangle: RectWithTriangle(
      color: kColorOrange,
      shape: Shapes.RectWithTriangle,
      positionInList: 0,
      positionOfBoundingRectangle: Offset(2, 4),
      isAnchored: false,
    ),
    Shapes.Trapezoid: Trapezoid(
      color: kColorOrange,
      shape: Shapes.Trapezoid,
      positionInList: 6,
      positionOfBoundingRectangle: Offset(0, 2),
      isAnchored: false,
    ),
  },
);

const shapeOrder = ShapeOrder(order: <Shapes>[
  Shapes.TriangleGreen,
  Shapes.TriangleRed,
  Shapes.TriangleBlue,
  Shapes.RectWithoutTriangle,
  Shapes.Trapezoid,
  Shapes.RectWithTriangle,
]);
const dataState = DataState(gameShapes: gameShape, shapeOrder: shapeOrder, solve: true);

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
  group('solver state', () {
    late SolverBloc solverBloc;
    late Puzzle puzzle;
    late Map<Shapes, MyPath> map;
    late SolverState solverState;

    setUp(() {
      puzzle = Puzzle(points: cross);
      map = <Shapes, MyPath>{
        Shapes.RectWithoutTriangle: dataState.getMyPath(shape: Shapes.RectWithoutTriangle),
        Shapes.Trapezoid: dataState.getMyPath(shape: Shapes.Trapezoid),
        Shapes.RectWithTriangle: dataState.getMyPath(shape: Shapes.RectWithTriangle),
        Shapes.TriangleGreen: dataState.getMyPath(shape: Shapes.TriangleGreen),
        Shapes.TriangleRed: dataState.getMyPath(shape: Shapes.TriangleRed),
        Shapes.TriangleBlue: dataState.getMyPath(shape: Shapes.TriangleBlue),
      };
      solverBloc = SolverBloc(pathsForShape: PathsForShapes(map: map), puzzle: puzzle);

      solverState =
          SolverState(pathsForShapes: PathsForShapes(map: map), puzzle: puzzle, attempt: 0);
    });
    test('checking value equality', () {
      expect(solverBloc.state, solverState);
    });

    test('checking isPuzzleCovered getter', () {
      var solverStateTest =
          SolverState(pathsForShapes: PathsForShapes(map: map), puzzle: puzzle, attempt: 0);
      expect(solverStateTest.isPuzzleCovered, true);
    });
  });
}
//
// void main() {
//   group('SolverBloc', () {
//     SolverBloc? solverBloc;
//
//     setUp(() {
//       solverBloc = SolverBloc(
//         solverHelper: SolverHelper(
//             puzzleToSolvePoints: PuzzleToSolve(
//           x: 3,
//           y: 4,
//           settings: Settings(pixelHeight: 1200, pixelWidth: 600),
//         ).points),
//       );
//     });
//     tearDown(() {
//       solverBloc?.close();
//     });
//
//     test('initial value of the state should be exactly the same  as stated', () {
//       var puzzle = PuzzleToSolveMock(x: 3, y: 4);
//       var initialState = SolverState(
//           puzzleToSolvePoints: puzzle.points,
//           pointsToPack: puzzle.points.length,
//           solved: false,
//           pointsCovered: 0,
//           currentlyCoveredPuzzle: puzzle.myMap);
//       expect(solverBloc?.state, initialState);
//     });
//
//     group('SolverEvent()', () {
//       var puzzle = PuzzleToSolveMock(x: 3, y: 4);
//
//       blocTest(
//         'Event of type  <ShapeStartedDragDataEvent> is raised  '
//         'checking  if  we get a <SolverState>',
//         build: () => SolverBloc(
//           solverHelper: SolverHelper(
//               puzzleToSolvePoints: PuzzleToSolve(
//             x: 3,
//             y: 4,
//             settings: Settings(pixelHeight: 1200, pixelWidth: 600),
//           ).points),
//         ),
//         act: (solverBloc) => (solverBloc as SolverBloc).add(ShapeStartedDragDataEvent(
//           offset: Offset.zero,
//           points: [],
//         )),
//         expect: () => [isA<SolverState>()],
//       );
//
//       blocTest(
//         '2 Events <ShapeStartedDragDataEvent>  <ShapeFinishedDragDataEvent> is raised  '
//         'checking  if 2  <SolverState>s were emitted.Also last state\'s '
//         'instance variable pointsCovered should be now 3. Triangle lands on puzzle',
//         build: () => SolverBloc(
//           solverHelper: SolverHelper(
//               puzzleToSolvePoints: PuzzleToSolve(
//             x: 3,
//             y: 4,
//             settings: Settings(pixelHeight: 1200, pixelWidth: 600),
//           ).points),
//         ),
//         act: (solverBloc) {
//           (solverBloc as SolverBloc)
//             ..add(ShapeStartedDragDataEvent(offset: Offset.zero, points: []))
//             ..add(ShapeFinishedDragDataEvent(offset: Offset(3, 6), points: [
//               const PointSystem(dx: 0, dy: 1, west: false, north: false),
//               const PointSystem(dx: 1, dy: 1),
//               const PointSystem(dx: 1, dy: 0, west: false, north: false),
//             ]));
//         },
//         expect: () => [
//           SolverState(
//               puzzleToSolvePoints: puzzle.points,
//               pointsToPack: puzzle.points.length,
//               solved: false,
//               pointsCovered: 3,
//               currentlyCoveredPuzzle: puzzle.myMap)
//         ],
//       );
//     });
//   });
// }
//
// var ListOfPoints = <PointSystem>[];
//
// class PuzzleToSolveMock {
//   final int x;
//   final int y;
//   final points = <PointSystem>[];
//
//   Map<PointSystem, int> get myMap => {for (var e in points) e: 0};
//
//   // Map<PointSystem,int> get updateWith(List<Offset> list){
//   //   List.from(list,)
//   // }
//
//   PuzzleToSolveMock({required this.x, required this.y}) {
//     points.add(PointSystem(dx: x + 2, dy: y));
//     points.add(PointSystem(dx: x + 3, dy: y));
//
//     points.add(PointSystem(dx: x + 2, dy: y + 1));
//     points.add(PointSystem(dx: x + 3, dy: y + 1));
//
//     points.add(PointSystem(dx: x + 2, dy: y + 2));
//     points.add(PointSystem(dx: x + 3, dy: y + 2));
//
//     points.add(PointSystem(dx: x + 2, dy: y + 3));
//     points.add(PointSystem(dx: x + 3, dy: y + 3));
//
//     points.add(PointSystem(dx: x + 2, dy: y + 4));
//     points.add(PointSystem(dx: x + 3, dy: y + 4));
//
//     points.add(PointSystem(dx: x + 2, dy: y + 5));
//     points.add(PointSystem(dx: x + 3, dy: y + 5));
//
//     points.add(PointSystem(dx: x + 2, dy: y + 6));
//     points.add(PointSystem(dx: x + 3, dy: y + 6));
//
//     points.add(PointSystem(dx: x + 2, dy: y + 7));
//     points.add(PointSystem(dx: x + 3, dy: y + 7));
//
//     points.add(PointSystem(dx: x, dy: y + 2));
//     points.add(PointSystem(dx: x + 1, dy: y + 2));
//
//     points.add(PointSystem(dx: x + 4, dy: y + 2));
//     points.add(PointSystem(dx: x + 5, dy: y + 2));
//
//     points.add(PointSystem(dx: x, dy: y + 3));
//     points.add(PointSystem(dx: x + 1, dy: y + 3));
//
//     points.add(PointSystem(dx: x + 4, dy: y + 3));
//     points.add(PointSystem(dx: x + 5, dy: y + 3));
//   }
// }
// /*
//  expect: () => [
//           SolverState(
//               puzzleToSolvePoints: puzzle.points,
//               pointsToPack: puzzle.points.length,
//               solved: false,
//               pointsCovered: 0,
//               currentlyCoveredPuzzle: puzzle.myMap)
//         ],
//  */
