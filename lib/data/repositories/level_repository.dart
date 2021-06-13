import 'dart:convert';

import 'package:http/http.dart' show Client; //as http;
import 'package:tangram/data/models/levels.dart';
import 'package:tangram/util/constants.dart';

abstract class LevelsRepository {
  Future<Levels> getLevels();
}

class LevelsRepositoryImpl implements LevelsRepository {
  Client client = Client();

  @override
  Future<Levels> getLevels() async {
    var url = Uri.parse(httpAddress);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var levels = Levels.fromJson(data);
      return levels;
    } else {
      //TODO: display error
      throw Exception();
    }
  }
}
