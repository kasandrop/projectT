import 'package:flutter/material.dart';
import 'package:tangram/business/PuzzleToSolve.dart';
import 'package:tangram/business/coordinateSystem.dart';
import 'package:tangram/presentation/drawPoint.dart';
import 'package:tangram/settings.dart';

class PuzzleToSolveWidget extends StatelessWidget {
  final PuzzleToSolve puzzleToSolve;

  final Settings settings;
  final Color color;

  const PuzzleToSolveWidget({
    required this.puzzleToSolve,
    required this.settings,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    List<Positioned> visiblePoints = [];

    puzzleToSolve.points.forEach((PointSystem point) {
      // print('visible points x:${point.dx} y:${point.dy}');
      visiblePoints.add(Positioned(
        top: point.dy * settings.pointSize.toDouble(),
        left: point.dx * settings.pointSize.toDouble(),
        child: DrawPoint(
          settings: settings,
          pointSystem: point,
          color: color,
        ),
      ));
    });
    //print('visible points size:${visiblePoints.length}');
    return IgnorePointer(
      child: Stack(children: visiblePoints),
    );
  }
}
