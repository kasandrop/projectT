import 'package:tangram/business/shapes/shapesData.dart';
import 'package:tangram/util/shape_enum.dart';

class GetInitialRotationPointsUseCase {
  final RectWithTriangle rectangleWithTriangle;
  final RectWithoutTriangle rectangleWithoutTriangle;
  final Triangle triangleGreen;
  final Triangle triangleRed;
  final Triangle triangleBlue;
  final Trapezoid trapezoid;

  const GetInitialRotationPointsUseCase({
    required this.rectangleWithTriangle,
    required this.rectangleWithoutTriangle,
    required this.triangleBlue,
    required this.triangleRed,
    required this.triangleGreen,
    required this.trapezoid,
  });
  Map<Shapes, BaseShape> getMap() {
    return {
      Shapes.RectWithTriangle: rectangleWithTriangle,
      Shapes.RectWithoutTriangle: rectangleWithoutTriangle,
      Shapes.Trapezoid: trapezoid,
      Shapes.TriangleRed: triangleRed,
      Shapes.TriangleBlue: triangleBlue,
      Shapes.TriangleGreen: triangleGreen,
    };
  }

  //to correct the error. it keeps the point here or in the state
  // void rotateShape({required Shapes shape}) {
  //   if (shape == Shapes.RectWithTriangle) {
  //     rectangleWithTriangle.rotateRight();
  //   }
  //   if (shape == Shapes.RectWithoutTriangle) {
  //     rectangleWithoutTriangle.rotateRight();
  //   }
  //   if (shape == Shapes.Trapezoid) {
  //     trapezoid.rotateRight();
  //   }
  //   if (shape == Shapes.TriangleRed) {
  //     triangleRed.rotateRight();
  //   }
  //   if (shape == Shapes.TriangleBlue) {
  //     triangleBlue.rotateRight();
  //   }
  //   if (shape == Shapes.TriangleGreen) {
  //     triangleGreen.rotateRight();
  //   }
  // }
  //
  // //this is wrong as well
  // List<PointSystem> getPoints({required Shapes shape}) {
  //   if (shape == Shapes.RectWithTriangle) {
  //     return rectangleWithTriangle.points;
  //   }
  //   if (shape == Shapes.RectWithoutTriangle) {
  //     return rectangleWithoutTriangle.points;
  //   }
  //   if (shape == Shapes.Trapezoid) {
  //     return trapezoid.points;
  //   }
  //   if (shape == Shapes.TriangleRed) {
  //     return triangleRed.points;
  //   }
  //   if (shape == Shapes.TriangleBlue) {
  //     return triangleBlue.points;
  //   }
  //   if (shape == Shapes.TriangleGreen) {
  //     return triangleGreen.points;
  //   }
  //   return [];
  // }
}
