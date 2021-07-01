import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tangram/data/models/point_system.dart';
import 'package:tangram/data/models/puzzle.dart';
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
