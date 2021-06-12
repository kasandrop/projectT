import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tangram/data/models/PuzzleToSolve.dart';
import 'package:tangram/data/models/point_system.dart';
import 'package:tangram/util/settings.dart';
import 'package:tangram/widgets/draw_point_widget.dart';

class PuzzleToSolveWidget extends StatelessWidget {
  final PuzzleToSolve puzzleToSolve;

  final Color color = Colors.red;

  const PuzzleToSolveWidget({
    Key? key,
    required this.puzzleToSolve,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pointSize = Provider.of<Settings>(context).pointSize.toDouble();
    return IgnorePointer(
      child: Stack(
        children: puzzleToSolve.points
            .map((PointSystem point) => Positioned(
                  top: point.dy * pointSize,
                  left: point.dx * pointSize,
                  child: DrawPointWidget(
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
