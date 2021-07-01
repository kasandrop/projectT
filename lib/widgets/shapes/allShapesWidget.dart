import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    //  buildWhen: (previous, current) =>previous.currentFocus!=current.currentFocus,
    return  BlocConsumer<SolverBloc, SolverState>(
    listener: (context, state) {

    },
    buildWhen: (previous, current) {
    // log.d('current.currentfocus: ${current.currentFocus}== shape:$shape result of ==:$result');
    return     current.shapeOrder!=previous.shapeOrder;
    },
    builder: (context, state) {
      var shapeOrder = state.shapeOrder;
      log.d('all shapes');
      return Container(
        width: screenWidth(context),
        height: screenHeight(context),
        child: Stack(
          children: <Widget>[
            for (var shape in shapeOrder.order)
              //Compile-time constant  shall not be something the developers have to worry. It is compiler's job solely for optimization.
              ShapeWidget(shape: shape,key:ObjectKey(shape)),
          ],
        ),
      );
    });
  }
}
