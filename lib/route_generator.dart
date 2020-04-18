import 'package:flutter/material.dart';
import './views/dashboard.dart';
import './views/country_page.dart';
import './views/error_page.dart';

class RouteGenerator {
  static Route<dynamic> generatorRoute(RouteSettings settings) {
    // Getting args passed in while calling routes
    final ScreenArguments args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => Dashboard(),
            settings: RouteSettings(name: 'Landing page'));
      case '/country':
        return MaterialPageRoute(
            builder: (_) => CountryDashboard(
                country: args.country, iso: args.iso, flag: args.flag),
            settings: RouteSettings(name: 'Country page'));
      default:
        return MaterialPageRoute(
            builder: (_) => ErrorPage(),
            settings: RouteSettings(name: 'Error page'));
    }
  }
}

class ScreenArguments {
  String country;
  String iso;
  String flag;

  ScreenArguments({this.country, this.iso, this.flag});
}
