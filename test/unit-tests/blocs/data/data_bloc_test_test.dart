import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tangram/data/models/shapeProduct/game_shapes.dart';
import 'package:tangram/data/models/shape_order.dart';

class MockGameShapes extends Mock implements GameShapes {}

class MockShapeOrder extends Mock implements ShapeOrder {}

void main() {
  group('Data Bloc', () {
    GameShapes gameShapes;
    ShapeOrder shapeOrder;

    setUp(() {
      gameShapes = MockGameShapes();
      shapeOrder = MockShapeOrder();
    });



  });
}
