import 'dart:ui';

import 'package:triangram/data/models/puzzle.dart';
import 'package:test/test.dart';

List<Offset> cross = [
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
  test('Puzzle.zero() returns Puzzle object with empty points List', () {
    var puzzle1 = Puzzle.zero();
    expect(puzzle1, Puzzle(points: <Offset>[]));
  });

  group('Getting Path object from Puzzle', () {
    Puzzle? puzzle;
    setUp(() {
      puzzle = Puzzle(points: cross);
    });

    test('if pointSize ==1 then path we  are getting is of Size(6,8)', () {
      expect(puzzle?.getPath().getBounds().bottomRight, Offset(6, 8));
    });

    test('if pointSize ==5.75 then path we  are getting is of Size(34.5,46)', () {
      expect(puzzle?.getPath(pointSize: 5.75).getBounds().bottomRight, Offset(34.5, 46));
    });

    test('pointSize ==35.75 checking path with contain', () {
      expect(puzzle?.getPath(pointSize: 35.75).contains(Offset(2 * 35.75, 0)), true);
      expect(puzzle?.getPath(pointSize: 35.75).contains(Offset(6 * 35.75, 2 * 35.75)), true);

      expect(puzzle?.getPath(pointSize: 35.75).contains(Offset(6 * 35.75, 1 * 35.75)), false);
      expect(puzzle?.getPath(pointSize: 35.75).contains(Offset(1 * 35.75, 5 * 35.75)), false);
    });
  });
}
