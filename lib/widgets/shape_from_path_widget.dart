import 'package:flutter/cupertino.dart';
import 'package:tangram/util/shape_enum.dart';
import 'package:tangram/util/top_level_functions.dart';
import 'package:tangram/widgets/shape_painter.dart';

class ShapeFromPathWidget extends StatelessWidget {
  final Size size;
  final Color color;
  final Path path;
  final Offset offset;
  final bool visibility;

  const ShapeFromPathWidget({
    Key? key,
    required this.size,
    required this.color,
    required this.path,
    required this.offset,
    this.visibility=true,
  }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Visibility(
      visible: visibility,
      child: CustomPaint(
        size: size,
        painter: ShapePainter(
          path: path,
          color: color,
          offset: offset,
        ),
      ),
    );
  }
}