import 'package:flutter/material.dart';
import 'package:tangram/data/models/puzzle.dart';
import 'package:tangram/util/constants.dart';
import 'package:tangram/util/top_level_functions.dart';
import 'package:tangram/widgets/shape_from_path_widget.dart';

class PuzzleToSolveWidget extends StatelessWidget {
  final Color color;
  final Puzzle puzzle;
  final Offset offset;
  final double pointSize;

  const PuzzleToSolveWidget({
    Key? key,
    this.color = kColorOfPuzzle,
    required this.puzzle,
    required this.offset,
    required this.pointSize,
  }) : super(key: key);

  Path get path => puzzle.getPath(pointSize);

  Size get size => Size(puzzle.widthSpread.dx, puzzle.widthSpread.dy) * pointSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IgnorePointer(
        child: ShapeFromPathWidget(
            offset: offset,
            color: color,
            path: path,
            size: size * pointSizeFromContext(context)),
      ),
    );
  }
}
