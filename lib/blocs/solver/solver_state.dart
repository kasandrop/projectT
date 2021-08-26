import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:triangram/data/models/puzzle.dart';
import 'package:triangram/data/models/shapeProduct/shape_product.dart';
import 'package:triangram/util/constants.dart';
import 'package:triangram/util/logger.dart';
import 'package:triangram/util/shape_enum.dart';

class SolverState extends Equatable {
  final PathsForShapes pathsForShapes;
  final Puzzle puzzle;
  final int attempt;

  const SolverState({
    required this.pathsForShapes,
    required this.puzzle,
    required this.attempt,
  });

  SolverState copyWith({
    PathsForShapes? pathsForShapes,
  }) {
    return SolverState(
      pathsForShapes: pathsForShapes ?? this.pathsForShapes,
      puzzle: puzzle,
      attempt: attempt + 1,
    );
  }

  Path puzzlePathAfterAlignment() => puzzle.getPathAfterAlignment();

  @override
  String toString() {
    return '''SolverState{
      puzzlePath: $puzzle, 
      pathsForShapes: $pathsForShapes,  
      attempt:$attempt,
      
      }
      
      ''';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [pathsForShapes, puzzle, attempt];

  // SolverState copyWith(
  //     {Shapes? shape,
  //     Path? puzzlePath,
  //     Path? path,
  //     bool? isPositionInAllShapesEven}) {
  //   assert((shape != null && path != null) || (shape == null && path == null),
  //       'if shape is not null then path must not be nul and vice versa');
  //   var temp;
  //   if (shape != null && path != null) {
  //     temp = Map<Shapes, Path>.of(map);
  //     temp[shape] = path;
  //   }
  //   return SolverState(
  //       map: temp ?? map,
  //       puzzlePath: puzzlePath ?? this.puzzlePath,);
  // }

  bool get isPuzzleCovered {
    log.d('isPuzzlecovered');

    var result = 0;

    var path = pathsForShapes.map.values.fold<Path>(
        puzzlePathAfterAlignment(),
        (Path previousValue, MyPath element) =>
            Path.combine(PathOperation.difference, previousValue, element.path));

    var pathMetricsList = path.computeMetrics().toList();
    var length = pathMetricsList.length;
    log.d('\n @@@@@@@@@@@@@@@@@@@@@@@@@@@@ length:$length');
    pathMetricsList.forEach((PathMetric element) {
      var extractedPath = element.extractPath(
        0,
        element.length,
      );
      var width = extractedPath.getBounds().width;
      var height = extractedPath.getBounds().height;
      log.d('  extracted Path length::{$element.length}  width:$width \n height::$height \n ');
      if (width > lackOfPrecision && height > lackOfPrecision) {
        result++;
      }
    });
    if (result == 0) {
      return true;
    }
    return false;
  }
}

class PathsForShapes extends Equatable {
  final Map<Shapes, MyPath> map;

  MyPath getMyPath(Shapes shape) => map[shape]!;

  PathsForShapes({required this.map});

  @override
  List<Object> get props => [map];
}

/*

  bool get isPuzzleCovered {
    var result = 0;
    log.d('isPuzzleCovered');
    var path = pathsForShapes.map.values.fold<Path>(
      puzzlePath,
      (Path previousValue, Path element) =>
          Path.combine(PathOperation.difference, previousValue, element),
    );
    var pathMetricsList = path.computeMetrics().toList();
    log.d('number of contours: $pathMetricsList');
    pathMetricsList.forEach((PathMetric element) {
      var length = element.length;
      var extractedPath = element.extractPath(
        0,
        element.length,
      );
      var width = extractedPath.getBounds().width;
      var height = extractedPath.getBounds().height;
      log.d('CONTOUR index:${element.contourIndex} Path width:$width , '
          'height:$height and length:$length');
      if (width > lackOfPrecision && height > lackOfPrecision) {
        result++;
      }
      var pathMetricsList2 = extractedPath.computeMetrics().toList();
      if (pathMetricsList2.isNotEmpty) {
        log.d('---->Mamy cie--details of SubPath:');

        pathMetricsList2.forEach((element2) {
          var length2 = element2.length;
          var extractedPath2 = element2.extractPath(0, length2);
          var width2 = extractedPath2.getBounds().width;
          var height2 = extractedPath2.getBounds().height;
          log.d('------->CONTOUR index:${element2.contourIndex} Path width:$width2 , '
              'height2:$height2 and length:$length2');
        });
      }
    });
    if (result == 0) {
      return true;
    }
    return false;
  }
}
 */
