import 'package:tangram/business/shapes/shapesData.dart';
import 'package:tangram/util/coordinateSystem.dart';
import 'package:tangram/util/shape_enum.dart';

class GetPointsUseCase {
  final RectWithTriangle rectangleWithTriangle;
  final RectWithoutTriangle rectangleWithoutTriangle;
  final Triangle triangleGreen;
  final Triangle triangleRed;
  final Triangle triangleBlue;
  final Trapezoid trapezoid;

  const GetPointsUseCase({
    required this.rectangleWithTriangle,
    required this.rectangleWithoutTriangle,
    required this.triangleBlue,
    required this.triangleRed,
    required this.triangleGreen,
    required this.trapezoid,
  });
  Map<Shapes, List<PointSystem>> getMap() {
    return {
      Shapes.RectWithTriangle: rectangleWithTriangle.points,
      Shapes.RectWithoutTriangle: rectangleWithoutTriangle.points,
      Shapes.Trapezoid: trapezoid.points,
      Shapes.TriangleRed: triangleRed.points,
      Shapes.TriangleBlue: triangleBlue.points,
      Shapes.TriangleGreen: triangleGreen.points,
    };
  }

  List<PointSystem> getPoints(Shapes shape) {
    if (shape == Shapes.RectWithTriangle) {
      return rectangleWithTriangle.points;
    }
    if (shape == Shapes.RectWithoutTriangle) {
      return rectangleWithoutTriangle.points;
    }
    if (shape == Shapes.Trapezoid) {
      return trapezoid.points;
    }
    if (shape == Shapes.TriangleRed) {
      return triangleRed.points;
    }
    if (shape == Shapes.TriangleBlue) {
      return triangleBlue.points;
    }
    if (shape == Shapes.TriangleGreen) {
      return triangleGreen.points;
    }
    return [];
  }
}
