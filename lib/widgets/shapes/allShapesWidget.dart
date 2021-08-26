import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:triangram/blocs/data/data.dart';
import 'package:triangram/blocs/solver/solver.dart';
import 'package:triangram/util/logger.dart';
import 'package:triangram/util/top_level_functions.dart';
import 'package:triangram/widgets/shapes/shapeWidget.dart';

class AllShapesWidget extends StatelessWidget {
  const AllShapesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log.d('build-allShapes');
    //  buildWhen: (previous, current) =>previous.currentFocus!=current.currentFocus,
    return BlocConsumer<DataBloc, DataState>(
        listener: (context, state) {},
        buildWhen: (previous, current) {
          if (previous.shapeOrder.order.isEmpty) return true;
          if (current.shapeOrder.order.isEmpty) return true;
          return current.shapeOrder.order.last != previous.shapeOrder.order.last;
        },
        builder: (context, state) {
          var shapeOrder = state.shapeOrder;
          log.d('all shapes-builder');
          return Container(
            width: screenWidth(context),
            height: screenHeight(context),
            child: Stack(
              children: <Widget>[
                for (var shape in shapeOrder.order)
                  //Compile-time constant  shall not be something the developers have to worry. It is compiler's job solely for optimization.
                  ShapeWidget(
                      isFocus: shapeOrder.order.last == shape, shape: shape, key: ObjectKey(shape)),
                Builder(
                  builder: (BuildContext context) {
                    var solverState = context.watch<SolverBloc>().state;
                    var playerWins = solverState.isPuzzleCovered;
                    // log.d('info from solverState isSolved?: ${solverState.isPuzzleCovered}');
                    return Positioned(
                      top: 500,
                      left: 50,
                      child: Text('attempt:${solverState.attempt} solved:$playerWins'),
                    );
                  },
                ),
                // SolutionWidget(key: ObjectKey('SolutionWidget')),
              ],
            ),
          );
        });
  }
}

class SolutionWidget extends StatelessWidget {
  const SolutionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log.d('SolutionWidget');
    return BlocBuilder<SolverBloc, SolverState>(builder: (context, state) {
      var result = state.isPuzzleCovered;
      log.d('result: $result');
      return Container();
    });
  }
}
