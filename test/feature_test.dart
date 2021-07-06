import 'dart:ui';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
//import 'package:flutter_test/flutter_test.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   // await tester.pumpWidget(MyApp());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   // await tester.tap(find.byIcon(Icons.add));
  //   // await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  test('Path is not empty after adding a Polygon', () {
    var p1 = Path();

    //expect(p1.getBounds().isEmpty==true,p1.getBounds().isEmpty);
    p1.moveTo(0.0, 0.0);
    var offset1 = Offset(0.0, 0.0);
    var offset2 = Offset(10.0, 0.0);
    var offset3 = Offset(10.0, 10.0); //
    var offset4 = Offset(10.0, 0.0);
    var offset5 = Offset(0.0, 0.0);
    p1.moveTo(0.0, 10.0);
    p1.addPolygon(<Offset>[offset1, offset2, offset3, offset4, offset5], true);

    var myRect = p1.getBounds();
    expect(myRect.height + myRect.width, greaterThan(0));
  });

  test(
      'Path is    empty after adding 2 Polygons and then removing    them one which we remove is big',
      () {
    var p1 = Path();
    var p2 = Path();
    p1.moveTo(1.0, 1.0);
    p2.moveTo(0.0, 0.0);

    //expect(p1.getBounds().isEmpty==true,p1.getBounds().isEmpty);

    var offset1 = Offset(1, 1);
    var offset2 = Offset(10, 1);
    var offset3 = Offset(10, 10); //
    var offset4 = Offset(1, 10);
    p1.addPolygon(<Offset>[offset1, offset2, offset3, offset4], true);
    // expect(p1
    //     .getBounds()
    //     .isEmpty == false, p1
    //     .getBounds()
    //     .isEmpty);
    var offset10 = Offset(10, 10);
    var offset11 = Offset(20, 10);
    var offset12 = Offset(20, 20);
    var offset13 = Offset(10, 20);
    p2.addPolygon(<Offset>[offset10, offset11, offset12, offset13], true);
    // expect(p2.getBounds().isEmpty==false,p2.getBounds().isEmpty);

    var p3 = Path.combine(PathOperation.union, p1, p2);
    //expect(p3.getBounds().isEmpty==false,p3.getBounds().isEmpty);

    var offset44 = Offset(0, 0);
    var offset45 = Offset(10, 0);
    var offset46 = Offset(10, 10); //
    var offset47 = Offset(0, 10);

    var temp4 = Path();
    temp4.addPolygon(<Offset>[offset44, offset45, offset46, offset47], true);

    var p4 = Path.combine(PathOperation.difference, p3, temp4);
    // expect(p4.getBounds().isEmpty==false,p4.getBounds().isEmpty);

    var p5 = Path.combine(PathOperation.difference, p4, p2);
    var rect = p5.getBounds();
    expect(rect.height + rect.width, equals(0));
  });

  test('Path is   empty after adding 2 Polygons and then removing them', () {
    var p1 = Path();
    var p2 = Path();
    p1.moveTo(0.0, 0.0);
    p2.moveTo(0.0, 0.0);

    //expect(p1.getBounds().isEmpty==true,p1.getBounds().isEmpty);

    var offset1 = Offset(0, 0);
    var offset2 = Offset(10, 0);
    var offset3 = Offset(10, 10); //
    var offset4 = Offset(10, 0);
    p1.addPolygon(<Offset>[offset1, offset2, offset3, offset4], true);
    // expect(p1
    //     .getBounds()
    //     .isEmpty == false, p1
    //     .getBounds()
    //     .isEmpty);
    var offset10 = Offset(10, 10);
    var offset11 = Offset(20, 10);
    var offset12 = Offset(20, 20);
    var offset13 = Offset(10, 20);
    p2.addPolygon(<Offset>[offset10, offset11, offset12, offset13], true);
    // expect(p2.getBounds().isEmpty==false,p2.getBounds().isEmpty);

    var p3 = Path.combine(PathOperation.union, p1, p2);
    //expect(p3.getBounds().isEmpty==false,p3.getBounds().isEmpty);

    var p4 = Path.combine(PathOperation.difference, p3, p1);
    // expect(p4.getBounds().isEmpty==false,p4.getBounds().isEmpty);

    var p5 = Path.combine(PathOperation.difference, p4, p2);
    var rect = p5.getBounds();
    expect(rect.height + rect.width, equals(0));
  });

  test(
      'Path is   not empty after adding 2 Polygons and then removing all of them but leaving 1by 1',
      () {
    var p1 = Path();
    var p2 = Path();
    p1.moveTo(0.0, 0.0);
    p2.moveTo(0.0, 0.0);

    //expect(p1.getBounds().isEmpty==true,p1.getBounds().isEmpty);

    var offset1 = Offset(0, 0);
    var offset2 = Offset(10, 0);
    var offset3 = Offset(10, 10); //
    var offset4 = Offset(10, 0);
    p1.addPolygon(<Offset>[offset1, offset2, offset3, offset4], true);
    // expect(p1
    //     .getBounds()
    //     .isEmpty == false, p1
    //     .getBounds()
    //     .isEmpty);
    var offset10 = Offset(10, 10);
    var offset11 = Offset(20, 10);
    var offset12 = Offset(20, 20);
    var offset13 = Offset(10, 20);
    p2.addPolygon(<Offset>[offset10, offset11, offset12, offset13], true);
    // expect(p2.getBounds().isEmpty==false,p2.getBounds().isEmpty);

    var p3 = Path.combine(PathOperation.union, p1, p2);
    //expect(p3.getBounds().isEmpty==false,p3.getBounds().isEmpty);

    var offset22 = Offset(0, 0);
    var offset23 = Offset(1, 0);
    var offset24 = Offset(1, 1);
    var offset25 = Offset(0, 1);
    var temp = Path();
    temp.addPolygon(<Offset>[offset22, offset23, offset24, offset25], true);
    var p6 = Path.combine(PathOperation.union, p3, temp);

    var p4 = Path.combine(PathOperation.difference, p6, p1);
    // expect(p4.getBounds().isEmpty==false,p4.getBounds().isEmpty);

    var p5 = Path.combine(PathOperation.difference, p4, p2);
    var rect = p5.getBounds();

    expect(rect.height + rect.width, greaterThan(0));
  });

  test(
      'Path is   not empty after adding 2 Polygons and then removing all of them but leaving 1by 1 and removing big one far away',
      () {
    var p1 = Path();
    var p2 = Path();
    p1.moveTo(0.0, 0.0);
    p2.moveTo(0.0, 0.0);

    //expect(p1.getBounds().isEmpty==true,p1.getBounds().isEmpty);

    var offset1 = Offset(0, 0);
    var offset2 = Offset(10, 0);
    var offset3 = Offset(10, 10); //
    var offset4 = Offset(10, 0);
    p1.addPolygon(<Offset>[offset1, offset2, offset3, offset4], true);
    // expect(p1
    //     .getBounds()
    //     .isEmpty == false, p1
    //     .getBounds()
    //     .isEmpty);
    var offset10 = Offset(10, 10);
    var offset11 = Offset(20, 10);
    var offset12 = Offset(20, 20);
    var offset13 = Offset(10, 20);
    p2.addPolygon(<Offset>[offset10, offset11, offset12, offset13], true);
    // expect(p2.getBounds().isEmpty==false,p2.getBounds().isEmpty);

    var p3 = Path.combine(PathOperation.union, p1, p2);
    //expect(p3.getBounds().isEmpty==false,p3.getBounds().isEmpty);

    var offset22 = Offset(0, 0);
    var offset23 = Offset(1, 0);
    var offset24 = Offset(1, 1);
    var offset25 = Offset(0, 1);
    var temp = Path();
    temp.addPolygon(<Offset>[offset22, offset23, offset24, offset25], true);
    var p6 = Path.combine(PathOperation.union, p3, temp);

    var p4 = Path.combine(PathOperation.difference, p6, p1);
    // expect(p4.getBounds().isEmpty==false,p4.getBounds().isEmpty);

    var p5 = Path.combine(PathOperation.difference, p4, p2);

    var offset220 = Offset(100, 100);
    var offset230 = Offset(200, 100);
    var offset240 = Offset(200, 200);
    var offset250 = Offset(100, 200);

    var farAway = Path()
      ..addPolygon(<Offset>[offset220, offset230, offset240, offset250], true);
    var result = Path.combine(PathOperation.difference, p5, farAway);
    var rectAway = result.getBounds();

    expect(rectAway.height + rectAway.width, greaterThan(0));

    //expect(    rectAway.height+rectAway.width,greaterThan(10)  );
  });





  test(
      'checking properties of 3 exacly overlapping paths and making a diffrence between them and one which overlaps again',
          () {
        var p1 = Path();
        var p2 = Path();
        p1.moveTo(0.0, 0.0);
        p2.moveTo(0.0, 0.0);

        //expect(p1.getBounds().isEmpty==true,p1.getBounds().isEmpty);

        var offset1 = Offset(0, 0);
        var offset2 = Offset(10, 0);
        var offset3 = Offset(10, 10); //
        var offset4 = Offset(10, 0);
        p1.addPolygon(<Offset>[offset1, offset2, offset3, offset4], true);
        // expect(p1
        //     .getBounds()
        //     .isEmpty == false, p1
        //     .getBounds()
        //     .isEmpty);

        p2.addPolygon(<Offset>[offset1, offset2, offset3, offset4], true);
        // expect(p2.getBounds().isEmpty==false,p2.getBounds().isEmpty);

        var p3 = Path.combine(PathOperation.union, p1, p2);
        //expect(p3.getBounds().isEmpty==false,p3.getBounds().isEmpty);


        var temp = Path();
        temp.addPolygon(<Offset>[offset1, offset2 , offset3, offset4], true);
        var p6 = Path.combine(PathOperation.union, p3, temp);

       var rectAway=p6.getBounds();
        expect(rectAway.height + rectAway.width, greaterThan(0));

        //expect(    rectAway.height+rectAway.width,greaterThan(10)  );
      });
}
