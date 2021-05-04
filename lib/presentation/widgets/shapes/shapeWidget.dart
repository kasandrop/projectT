import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tangram/presentation/drawPoint.dart';
import 'package:tangram/presentation/movements/movements_bloc.dart';
import 'package:tangram/util/constants.dart';
import 'package:tangram/util/coordinateSystem.dart';
import 'package:tangram/util/logger.dart';
import 'package:tangram/util/settings.dart';
import 'package:tangram/util/shape_enum.dart';

class ShapeWidget extends StatelessWidget {
  final Color color;
  final Shapes shape;

  const ShapeWidget({
    Key? key,
    required this.color,
    required this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // log.d('$shape');

    return BlocBuilder<MovementsBloc, MovementsState>(builder: (context, state) {
      final double pointSize = Provider.of<Settings>(context).pointSize.toDouble();
      return Positioned(
        //  key: ValueKey(151),
        top: state.positionsMap[shape]!.dy * pointSize,
        left: state.positionsMap[shape]!.dx * pointSize,

        child: Draggable(
            // rootOverlay: true,
            onDragEnd: (details) {
              log.d('drag ended');
            },
            onDragStarted: () {
              log.d('onDragStarted');
              BlocProvider.of<MovementsBloc>(context)
                  .add(ShapeFocused(focusShape: shape));
              BlocProvider.of<MovementsBloc>(context).add(DragStarted(
                pointSizeInt: pointSize.toInt(),
              ));
            },
            onDragUpdate: (details) {
              Offset delta = Offset(details.delta.dx, details.delta.dy);
              log.d('so it was onDragUpdate');
              BlocProvider.of<MovementsBloc>(context).add(
                ShapeDragged(
                  delta: delta,
                ),
              );
            },
            childWhenDragging: Container(
                height: pointSize * getBoardSize(shape: shape),
                width: pointSize * getBoardSize(shape: shape),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(getAssetPath(shape: shape)),
                  ),
                )),
            child: Container(
              height: pointSize * getBoardSize(shape: shape),
              width: pointSize * getBoardSize(shape: shape),
              child: Stack(
                children: state.pointsMap[shape]!
                    .map((PointSystem point) => Positioned(
                          top: point.dy * pointSize,
                          left: point.dx * pointSize,
                          child: DrawPoint(
                            pointSize: pointSize,
                            pointSystem: point,
                            color: color,
                          ),
                        ))
                    .toList(),
              ),
            ),
            //),

            feedback: ModifyContainer(
              shape: shape,
              assetBuilder: (imageProvider) {
                return MyFeedback(
                  shape: shape,
                  imageProvider: imageProvider,
                  pointSize: pointSize,
                );
              },
            )),
      );
    });
    // }
    //);
  }
}

class MyFeedback extends StatelessWidget {
  final double pointSize;
  final Shapes shape;
  final ImageProvider<Object> imageProvider;

  const MyFeedback(
      {Key? key,
      required this.pointSize,
      required this.shape,
      required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: pointSize * getBoardSize(shape: shape),
      width: pointSize * getBoardSize(shape: shape),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: imageProvider,
        ),
      ),
    );
  }
}

class ModifyContainer extends StatelessWidget {
  final Shapes shape;
  final Widget Function(ImageProvider<Object>) assetBuilder;

  const ModifyContainer({
    Key? key,
    required this.assetBuilder,
    required this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImageProvider<Object> assetImage;

    if (Shapes.RectWithTriangle == shape)
      assetImage = const AssetImage(shapesRectWithTriangle);
    else if (Shapes.RectWithoutTriangle == shape)
      assetImage = const AssetImage(shapesRectWithoutTriangle);
    else if (Shapes.TriangleGreen == shape)
      assetImage = const AssetImage(shapesTriangleGreen);
    else if (Shapes.TriangleRed == shape)
      assetImage = const AssetImage(shapesTriangleRed);
    else if (Shapes.TriangleBlue == shape)
      assetImage = const AssetImage(shapesTriangleBlue);
    else
      // (Shapes.Trapezoid == shape)
      assetImage = const AssetImage(shapesTrapezoid);

    return assetBuilder(assetImage);
  }
}
