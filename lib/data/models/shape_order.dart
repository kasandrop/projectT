import 'package:tangram/util/shape_enum.dart';
//manages the appearance of the shape widgets on stack
class ShapeOrder {
  final List<Shapes> order;

  const ShapeOrder({required this.order});

  Shapes get currentFocus => order.last;

  set currentFocus(Shapes shape) {
    if (order.last != shape) order.add(order.removeAt(order.indexOf(shape)));
  }
}
