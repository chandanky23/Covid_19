import 'package:covid_19/services/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './route_generator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Root of the application
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[
        AnalyticsService().getAnalyticsObserver()
      ],
      theme: ThemeData(primaryColor: Colors.black),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generatorRoute,
    );
  }
}
