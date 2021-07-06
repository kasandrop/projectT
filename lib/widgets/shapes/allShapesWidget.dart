import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangram/blocs/data/data.dart';
import 'package:tangram/blocs/solver/solver.dart';
import 'package:tangram/data/models/shape_order.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/shape_enum.dart';
import 'package:tangram/util/top_level_functions.dart';
import 'package:tangram/widgets/shapes/shapeWidget.dart';

class AllShapesWidget extends StatelessWidget {
  const AllShapesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log.d('build-allshapes');
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
                  ShapeWidget(shape: shape, key: ObjectKey(shape)),
                SolutionWidget(key: ObjectKey('SolutionWidget')),
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
    return BlocBuilder<SolverBloc, SolverState>(

        buildWhen: (previous, current) => previous.map != current.map,
        builder: (context, state) {
          log.d('nareszczie!!!!');
          var result = state.isPuzzleCovered;
          log.d('result: $result');
          return Container();
        });
  }
}
