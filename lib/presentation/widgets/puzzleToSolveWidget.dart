import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tangram/business/PuzzleToSolve.dart';
import 'package:tangram/presentation/drawPoint.dart';
import 'package:tangram/util/coordinateSystem.dart';
import 'package:tangram/util/settings.dart';

class PuzzleToSolveWidget extends StatelessWidget {
  final PuzzleToSolve puzzleToSolve;

  final Color color = Colors.red;

  const PuzzleToSolveWidget({
    Key? key,
    required this.puzzleToSolve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double pointSize = Provider.of<Settings>(context).pointSize.toDouble();
    return IgnorePointer(
      child: Stack(
        children: puzzleToSolve.points
            .map((PointSystem point) => Positioned(
                  top: point.dy * pointSize,
                  left: point.dx * pointSize,
                  child: DrawPoint(
                    pointSize: pointSize,
                    pointSystem: point,
                    color: color,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
