import 'package:equatable/equatable.dart';
import 'package:tangram/util/shape_enum.dart';
import 'package:meta/meta.dart';


//manages the appearance of the shape widgets on stack
@immutable
class ShapeOrder extends Equatable {
  final List<Shapes> order;

  const ShapeOrder({
    required this.order,
  });

  Shapes get focusShape=>order.last;

  ShapeOrder copyWith({
    List<Shapes>? shapes,
    Shapes? newFocusShape,
  }) {
    assert(shapes != null || newFocusShape != null,
        'both shapes and newFocusShape must not be null at the same time');
    if (shapes != null) {
      return ShapeOrder(order: shapes);
    }
    if (newFocusShape != null) {
      var newOrder=List<Shapes>.of(order);
      var shapeToRemove = newOrder.removeAt(newOrder.indexOf(newFocusShape));
      newOrder.add(shapeToRemove);
      return ShapeOrder(order: newOrder);
    }
    assert(0 == 1, 'Error');
    return this;
  }

  @override
  bool get stringify => true;

  @override
  // TODO: implement props
  List<Object> get props => [order];
}
