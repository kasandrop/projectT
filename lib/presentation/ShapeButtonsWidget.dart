import 'package:flutter/material.dart';
import 'package:tangram/business/shapes/shapesData.dart';
import 'package:tangram/util/settings.dart';

class ShapeButtonsWidget1 extends StatelessWidget {
  final Settings settings;
  final RectWithoutTriangle rwt;
  final RectWithTriangle rWihoutT;
  final Trapezoid trapezoid;
  final Triangle t1;
  final Triangle t2;
  final Triangle t3;

  const ShapeButtonsWidget1({
    required this.settings,
    required this.rwt,
    required this.rWihoutT,
    required this.trapezoid,
    required this.t1,
    required this.t2,
    required this.t3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Row(children: <Widget>[]),
        ],
      ),
    );
  }
}
