import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:triangram/util/shape_enum.dart';

//manages the appearance of the shape widgets on stack
@immutable
class ShapeOrder extends Equatable {
  final List<Shapes> order;

  const ShapeOrder({
    required this.order,
  });

  Shapes? get focusShape => (order.isNotEmpty) ? order.last : null;
  bool get isShapeOrderFull => order.length == 6;

  ShapeOrder copyWith({
    List<Shapes>? shapes,
    Shapes? newFocusShape,
    Shapes? removeShape,
    Shapes? addShape,
  }) {
    assert(shapes != null || newFocusShape != null || removeShape != null || addShape != null,
        'both shapes and newFocusShape must not be null at the same time');
    if (removeShape != null) {
      var newOrder = List<Shapes>.of(order);
      newOrder.removeAt(newOrder.indexOf(removeShape));
      return ShapeOrder(order: newOrder);
    }
    if (addShape != null) {
      var newOrder = List<Shapes>.of(order);
      assert(!newOrder.contains(addShape));
      newOrder.add(addShape);
      return ShapeOrder(order: newOrder);
    }
    if (shapes != null) {
      return ShapeOrder(order: shapes);
    }
    if (newFocusShape != null) {
      var newOrder = List<Shapes>.of(order);
      var shapeToRemove = newOrder.removeAt(newOrder.indexOf(newFocusShape));
      newOrder.add(shapeToRemove);
      return ShapeOrder(order: newOrder);
    }
    assert(0 == 1, 'Error');
    return this;
  }

  @override
  bool get stringify => false;

  @override
  List<Object> get props => [order];

  @override
  String toString() {
    return 'ShapeOrder{order: $order}';
  }
}
