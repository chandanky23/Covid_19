import 'package:flutter/material.dart';

Widget emptyList() {
  return Container(
      child: Center(
    child: Text(
      "Oops! no matching country name",
      style: TextStyle(
        color: Colors.black54,
        fontSize: 20.0
      ),
    ),
  ));
}
