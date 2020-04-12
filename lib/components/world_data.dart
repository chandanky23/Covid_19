import 'package:flutter/material.dart';

Widget worldData() {
  return new Container(
    margin: EdgeInsets.only(top: 20.0),
    constraints: BoxConstraints.expand(),
    child: Card(
      child: Column(
        children: <Widget>[
          Text(
            "World Coronavirus Status",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            constraints: BoxConstraints.expand(height: 500),
            decoration: BoxDecoration(
              color: Colors.orange[700],
              borderRadius: BorderRadius.circular(10.0)
            ),
          )
        ],
      ),
    ),
  );
}
