import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tangram/blocs/solver/solver.dart';
import 'package:tangram/util/top_level_functions.dart';
import 'package:tangram/widgets/shapes/shapeWidget.dart';

class AllShapesWidget extends StatelessWidget {
  const AllShapesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SolverBloc, SolverState>(
      builder: (context, SolverState state) {
        return Container(
          width: screenWidth(context),
          height: screenHeight(context),
          child: Stack(
            children: <Widget>[
              for ( var  shape   in state.shapeOrder.order)
                //Compile-time constant  shall not be something the developers have to worry. It is compiler's job solely for optimization.
                 ShapeWidget(shape: shape),
            ],
          ),
        );
      },
    );
  }
}
