import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/shape_enum.dart';

class SolverState extends Equatable {
  final Map<Shapes, Path> map;
  final Path puzzlePath;
  final bool freshData;

  SolverState({
    required this.map,
    required this.puzzlePath,
    this.freshData = false,
  });

  @override
  List<Object?> get props => [
        map,
        puzzlePath,
      ];

  SolverState copyWith({
    bool? freshData,
    Map<Shapes, Path>? map,
  }) {
    return SolverState(
      map: map ?? this.map,
      puzzlePath: puzzlePath,
      freshData: freshData ?? false,
    );
  }

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
    if (freshData == false) return false;
    log.d('isPuzzleCovered');
    _outputDebug(puzzlePath, 'puzzlePath');
    var path = map.values.fold(
      puzzlePath,
      (Path previousValue, Path element)
      {

        log.d('previous value:w:${previousValue.getBounds().width} h: ${previousValue.getBounds().height}');
        log.d('element value:w:${element.getBounds().width} h: ${element.getBounds().height}');
        var path= Path.combine(PathOperation.difference, previousValue, element);
       var w=path.getBounds().width;
       var h=path.getBounds().height;
       log.d('bounding rectangle height: $h and width:$w');
     var list=  path.computeMetrics().toList();
     list.forEach((PathMetric  pathMetric) {
          log.d('length of contour:   index: ${pathMetric.contourIndex} length:  ${pathMetric.length}');
     });
        return path;
      },
    );

    var width = path.getBounds().width;
    var height = path.getBounds().height;
    _outputDebug(path, 'whats left after all movements');
    if (width < 1 && height < 1) {
      return true;
    } else {
      return false;
    }
  }
}

void _outputDebug(Path path, String info) {
  log.d('$info');
  var pathMetrics = path.computeMetrics().toList();
  log.d('number of contours in path:${pathMetrics.length}\n');
  var i = 1;
  pathMetrics.forEach((PathMetric element) {
    log.d('${i++} metric length:${element.length}\n');
  });
  log.d(
      'calculations using path.getBounds path: width:${path.getBounds().width} \n height:${path.getBounds().height}');
}
