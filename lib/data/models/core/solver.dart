import 'dart:ui';

import 'package:tangram/data/models/shapeProduct/game_shapes.dart';
import 'package:tangram/util/logger.dart';

import '../puzzle.dart';

class Solver{

  static bool isWorkOut({required GameShapes gameShapes,required Puzzle puzzle}){
    if (gameShapes.isPositionInAllShapesEven==false)  return false;
    var puzzlePath=puzzle.getPath(1);
  var path= gameShapes.shapes.values.fold(puzzlePath, (Path previousValue, element) =>
       Path.combine(PathOperation.difference ,previousValue, element.getPath(1)) );

 var width= path.getBounds().width;
 var height=path.getBounds().height;

    log.d('height:$height \n width: $width \n ${path.toString()}');
  return   (width<1)?(height<1)?true:false:false;


  }
}

