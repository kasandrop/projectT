import 'package:equatable/equatable.dart';
import 'package:tangram/data/models/point_system.dart';

class Level extends Equatable {
  Level({
    required this.grid,
    required this.pointSystem,
  });

  final int grid;
  final List<PointSystem> pointSystem;

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        grid: json["grid"],
        pointSystem: List<PointSystem>.from(
            json["pointSystem"].map((x) => PointSystem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "grid": grid,
        "pointSystem": List<dynamic>.from(pointSystem.map((x) => x.toJson())),
      };

  @override
  // TODO: implement props
  List<Object?> get props => [grid, pointSystem];
}
