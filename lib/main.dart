import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/business/useCases/get_initial_points.dart';
import 'package:tangram/presentation/drawPoint.dart';
import 'package:tangram/presentation/movements/movements_bloc.dart';
import 'package:tangram/presentation/widgets/puzzleToSolveWidget.dart';
import 'package:tangram/presentation/widgets/screenWidget.dart';
import 'package:tangram/presentation/widgets/shapes/allShapesWidget.dart';
import 'package:tangram/presentation/widgets/widgetGridLines.dart';
import 'package:tangram/util/coordinateSystem.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/settings.dart';
import 'package:flutter/rendering.dart';
import 'business/PuzzleToSolve.dart';
import 'business/shapes/rectWithTriangle.dart';
import 'business/shapes/rectWithoutTriangle.dart';
import 'business/shapes/trapezoid.dart';
import 'business/shapes/triangle.dart';
import 'business/useCases/GetInitialPositionsOfTheShapes.dart';
import 'business/useCases/MovingMechanismUseCase.dart';

void main() {
  // debugPaintSizeEnabled = true;
  //debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MovingMechanismUseCase movingMechanismUseCase = MovingMechanismUseCase();
  final GetPointsUseCase getPointsUseCase = GetPointsUseCase(
    rectangleWithoutTriangle: RectWithoutTriangle(),
    rectangleWithTriangle: RectWithTriangle(),
    trapezoid: Trapezoid(),
    triangleBlue: Triangle(),
    triangleGreen: Triangle(),
    triangleRed: Triangle(),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugPaintPointersEnabled = true,
      debugShowCheckedModeBanner: false,
      title: 'Flutter ',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: BlocProvider(
        create: (context) => MovementsBloc(
            getInitialPositionsOfTheShapesUseCase:
                const GetInitialPositionsOfTheShapesUseCase(),
            //global pure function in a file,
            getPointsUseCase: getPointsUseCase,
            movingMechanismUseCase: movingMechanismUseCase),
        child: const ScreenWidget(   ),
      ),
    );
  }
}
//
//
// class DraggingWidget extends StatefulWidget {
//   final MovementsState myState;
//   final double pointSize;
//
//
//   DraggingWidget({required this.myState, required this.pointSize});
//
//   @override
//   _DraggingWidgetState createState() => _DraggingWidgetState();
// }
//
//
//
//
// class _DraggingWidgetState extends State<DraggingWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Draggable(
//
//       hitTestBehavior: HitTestBehavior.deferToChild,
//       onDragStarted: () {
//         log.d('drag Started');
//         BlocProvider.of<MovementsBloc>(context).add(
//             DragStarted(pointSizeInt: widget.pointSize.toInt()));
//         //return dragStarted(context, pointSize);
//       },
//       onDragUpdate: (DragUpdateDetails dud) {
//         log.d('ondrag  update');
//         BlocProvider.of<MovementsBloc>(context).add(
//           ShapeDragged(
//             delta: dud.delta,
//           ),
//         );
//       },
//
//       child: Container(
//
//         //color: Colors.yellow,
//         height: widget.pointSize * getBoardSize(shape: shape),
//         //global pure function in a file
//         width: widget.pointSize * getBoardSize(shape: shape),
//         child: Stack(
//           children: state.pointsMap[shape]!
//               .map(
//                 (PointSystem point) =>
//                 Positioned(
//                   top: point.dy * pointSize,
//                   left: point.dx * pointSize,
//                   child: DrawPoint(
//                     onTap: tapping,
//                     pointSize: pointSize,
//                     pointSystem: point,
//                     color: color,
//                   ),
//                 ),
//           )
//               .toList(),
//         ),
//       ),
//       feedback: Container(
//         key: globalKey3,
//         height: pointSize * getBoardSize(shape: shape),
//         width: pointSize * getBoardSize(shape: shape),
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             fit: BoxFit.fill,
//             image: AssetImage(getAssetPath(shape: shape)),
//           ),
//         ),
//       ),
//     )
//     ,
//   }
// }
