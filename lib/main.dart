import 'package:flutter/material.dart';
import './route_generator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Root of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID 19 - A Pandemic',
      theme: ThemeData(
        primaryColor: Colors.redAccent
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generatorRoute,
    );
  }
}