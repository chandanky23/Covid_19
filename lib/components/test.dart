import 'package:flutter/material.dart';

// class PlaceholderPage extends StatefulWidget {
//   final color;
//   PlaceholderPage({Key key, @required this.color}) : super(key: key);
//   @override
//   PlaceholderWidgetRoute createState() => PlaceholderWidgetRoute(color);
// }

class PlaceholderPage extends StatelessWidget{
  final Color color;

  PlaceholderPage(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
