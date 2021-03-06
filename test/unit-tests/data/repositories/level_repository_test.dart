import 'dart:convert';
import 'dart:ui';

import 'package:triangram/data/models/level.dart';
import 'package:triangram/data/models/levels.dart';
import 'package:triangram/util/grid_enum.dart';
import 'package:test/test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  var ps1 = Offset(2, 0);
  var ps2 = Offset(3, 0);
  var level1 = Level(grid: Grid.Turned, points: <Offset>[ps1, ps2]);
  var ps21 = Offset(22, 2);
  var ps22 = Offset(23, 3);
  var level2 = Level(grid: Grid.Turned, points: <Offset>[ps21, ps22]);
  var levels = Levels(levels: <Level>[level1, level2]);

  group('fromJson', () {
    test('LevelRepositories returns Levels object', () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('levels.json'));
      // act
      final result = Levels.fromJson(jsonMap);
      // assert
      expect(result, levels);
    });
  });

  test('toJson() LevelObject can return toJson()', () async {
    //arrange
    final Map<String, dynamic> jsonMap = json.decode(fixture('levels.json'));
    // act
    final result = levels.toJson();
    // assert
    expect(result, jsonMap);
  });
}
/*
{
    "levels": [
      {
        "grid": 1,
        "pointSystem": [
          {"dx": 2, "dy": 0},
          {"dx": 3, "dy": 0},

        ]
      },
      {
        "grid": 1,
        "pointSystem": [
          {
            "dx": 22,
            "dy": 2
          },
          {
            "dx": 23,
            "dy": 3
          }
        ]
      }
    ]
  }
 */

/*
  abstract class LevelsRepository {
  Future<Levels> getLevels();
}

class LevelsRepositoryImpl implements LevelsRepository {
  Client client=Client();
  @override
  Future<Levels> getLevels() async {
    var url = Uri.parse(httpAddress);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
     var levels = Levels.fromJson(data);
      return levels;
    } else {
      throw Exception();
    }
  }

}
*/
