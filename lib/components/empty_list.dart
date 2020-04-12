import 'package:flutter/material.dart';

Widget emptyList(String _errortext) {

  return Container(
      child: Center(
    child: Text(
      _errortext,
      style: TextStyle(
        color: Colors.black54,
        fontSize: 20.0
      ),
    ),
  ));
}
