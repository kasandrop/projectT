import 'dart:developer';
import 'dart:ui';

import 'package:tangram/data/models/shapeProduct/game_shapes.dart';
import 'package:tangram/util/logger.dart';

import '../puzzle.dart';

class Solver {
  static bool isWorkOut({
    required GameShapes gameShapes,
    required Puzzle puzzle,
    required bool areAllShapesVisible,
  }) {
    log.d('solver called');
    log.d('are all visisble: ${areAllShapesVisible == false}');
    log.d('is position even everywhere:  ${gameShapes.isPositionInAllShapesEven == false}');
    if (areAllShapesVisible == false) return false;
    if (gameShapes.isPositionInAllShapesEven == false) return false;

    var puzzlePath = puzzle.getPath(1);
    outputDebug(puzzlePath);
    var path = gameShapes.shapes.values.fold(
        puzzlePath,
        (Path previousValue, element) => Path.combine(
            PathOperation.difference, previousValue, element.getPath(1)));

    var width = path.getBounds().width;
    var height = path.getBounds().height;

    // log.d('height:$height \n width: $width \n ${path.toString()}');
    return (width < 1)
        ? (height < 1)
            ? true
            : false
        : false;
  }
}

outputDebug(Path path) {
  log.d('puzzle data');
  var pathMetrics = path.computeMetrics().toList();
  log.d('number of contours in path:${pathMetrics.length}\n');
  pathMetrics.forEach((PathMetric element) {
    log.d('metric length:${element.length}\n');
  });
  log.d(
      'calculations using path.getBounds path: width:${path.getBounds().width} \n height:${path.getBounds().height}');
}
