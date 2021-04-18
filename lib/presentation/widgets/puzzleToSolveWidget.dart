import 'package:tangram/business/PuzzleToSolve.dart';
import 'package:tangram/presentation/widgets/shapes/shapeWidget.dart';

class PuzzleToSolveWidget extends ShapeWidget {
  final PuzzleToSolve puzzleToSolve;

  const PuzzleToSolveWidget({
    required this.puzzleToSolve,
    required settings,
    required color,
  }) : super(
          baseShape: puzzleToSolve,
          settings: settings,
          color: color,
        );
}
