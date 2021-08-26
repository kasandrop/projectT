import 'package:flutter/material.dart';
import 'package:triangram/data/models/puzzle.dart';
import 'package:triangram/util/constants.dart';
import 'package:triangram/util/top_level_functions.dart';
import 'package:triangram/widgets/shape_from_path_widget.dart';

class PuzzleToSolveWidget extends StatelessWidget {
  // final Color color;
  final Path puzzlePath;

  const PuzzleToSolveWidget({
    Key? key,
    //this.color = kColorOfPuzzle,
    required this.puzzlePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = Size(puzzlePath.getBounds().width, puzzlePath.getBounds().height);
    return Container(
      child: IgnorePointer(
        child: ShapeFromPathWidget(
          //  colorTo: kDarkerGrey,
          //  colorFrom: kDarkGrey,
          //elevation: 0,
          state: DraggableState.none,
          shadowColor: Theme.of(context).colorScheme.onPrimary,
          color: Theme.of(context).colorScheme.onPrimary,
          path: puzzlePath,
          size: size,
        ),
      ),
    );
  }
}
