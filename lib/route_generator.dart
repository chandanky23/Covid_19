import 'package:flutter/material.dart';
import './views/dashboard.dart';
import './views/country_page.dart';
import './views/error_page.dart';

class RouteGenerator {
  static Route<dynamic> generatorRoute(RouteSettings settings) {
    // Getting args passed in while calling routes
    final routingArgs = settings.arguments;

    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/country':
        return MaterialPageRoute(builder: (_) => CountryPage(
          data: routingArgs
        ));
      default:
        return MaterialPageRoute(builder: (_) => ErrorPage());
    }
  }
}