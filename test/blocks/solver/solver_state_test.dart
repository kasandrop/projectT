import 'package:equatable/equatable.dart';
import 'package:tangram/config/injection_container.dart';
import 'package:tangram/data/models/shapeProduct/game_shapes.dart';
import 'package:tangram/data/models/shape_order.dart';
import 'package:tangram/util/shape_enum.dart';
import 'package:test/test.dart';

class MyState extends Equatable {
  final ShapeOrder shapeOrder;

  Shapes get currentFocus => shapeOrder.focusShape;



  @override
  bool get stringify =>true;
  const MyState({
    required this.shapeOrder,
  });

  @override
  List<Object> get props => [shapeOrder];
}

void main() async {
  // var getIt=GetIt.instance;




  await init();
  group('state testing Equatable package', ()  {
    GameShapes? gameShapes;
    ShapeOrder? shapeOrder;
    MyState ?myState;
    MyState ? stateExpected;


    setUpAll(() {
      shapeOrder = sl<ShapeOrder>();
      gameShapes = sl<GameShapes>();
      myState = MyState(shapeOrder: shapeOrder!);
      stateExpected = MyState(
          shapeOrder: ShapeOrder(
            order: <Shapes>[
              Shapes.Trapezoid,
              Shapes.TriangleBlue,
              Shapes.TriangleRed,
              Shapes.TriangleGreen,
              Shapes.RectWithoutTriangle,
              Shapes.RectWithTriangle,
            ],
          ));
    });



      // solverBloc = sl<SolverBloc>();
// print('state expected: $stateExpected');
//  print('state expected: $myState');


    test('value should be equal', () {
       expect(  myState,stateExpected);
    });

    // test('changing  order of list and not equal', () {
    //   myState?.currentFocus=Shapes.TriangleRed;
    //   expect(myState!=stateExpected,true);
    // });
    //
    // test('changing order of the list in both the same order should be equal', () {
    //   myState?.currentFocus=Shapes.TriangleRed;
    //   stateExpected?.currentFocus=Shapes.TriangleRed;
    //   expect(myState==stateExpected,true);
    //
    // });
  });
}