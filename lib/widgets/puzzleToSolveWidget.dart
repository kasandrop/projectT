import 'package:flutter/material.dart';
import 'package:tangram/util/top_level_functions.dart';
import 'package:tangram/widgets/shapes/shapeWidget.dart';

class PuzzleToSolveWidget extends StatelessWidget {
  final Color color;

  final Path path;
  final Offset offset;

  const PuzzleToSolveWidget({
    Key? key,
    this.color = Colors.red,
    required this.path,
    required this.offset,
  }) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return Container(

     child: IgnorePointer(
       child: ShapeFromPointsWidget(offset: offset, color: color, path: path),
     ),
   );


   // @override
   // Widget build(BuildContext context) {
   //   return Container(
   //     child: Transform.translate(offset:Offset(300,0),child:Transform(
   //       alignment: FractionalOffset.topRight,
   //       transform: Matrix4.identity()..rotateZ(45 * 3.1415 / 180),
   //       child: Container(
   //         child: IgnorePointer(
   //           child: ShapeFromPointsWidget(offset: offset, color: color, path: path),
   //         ),
   //       ),
   //     )),
   //   );
   // }
//}
 }}