
import 'package:tangram/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:tangram/pages/game_page.dart';
import 'package:tangram/pages/home_page.dart';
import 'package:tangram/util/constants.dart';

abstract class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    log.d('Route name: ${settings.name}');
    switch (settings.name) {

      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomePage());
        break;
      case Routes.game:
        return MaterialPageRoute(builder: (BuildContext context) {
          return GamePage();
        });
        break;
      case Routes.error:
      default:
      // Validation of correct data type
      // if (args is String)
      return _errorRoute();
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        //return _errorRoute();
        break;

  }}

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
