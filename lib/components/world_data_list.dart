import 'package:flutter/material.dart';
import 'package:covid_19/models/world_data.dart';

@override
Widget worldDataList(BuildContext context, World worldData) {
  return new Container(
    margin: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(color: Colors.white, boxShadow: [
      BoxShadow(blurRadius: 10.0, spreadRadius: 10.0, color: Colors.black12),
    ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Today',
              style: TextStyle(color: Colors.grey[700], fontSize: 30.0),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Total Cases',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            Text(
              '${worldData.cases.total}',
              style: TextStyle(color: Colors.grey[700], fontSize: 18.0),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Total Deaths',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            ),
            Text(
              '${worldData.deaths.total}',
              style: TextStyle(color: Colors.red[700], fontSize: 18.0),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Total Recovers',
                style: TextStyle(color: Colors.black, fontSize: 18.0)),
            Text(
              '${worldData.cases.recovered}',
              style: TextStyle(color: Colors.green[700], fontSize: 18.0),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('New Cases',
                style: TextStyle(color: Colors.black, fontSize: 18.0)),
            Text(
              '${worldData.cases.newCases}',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('New Deaths',
                style: TextStyle(color: Colors.black, fontSize: 18.0)),
            Text(
              '${worldData.deaths.newDeaths}',
              style: TextStyle(color: Colors.red[700], fontSize: 18.0),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Total Active',
                style: TextStyle(color: Colors.black, fontSize: 18.0)),
            Text(
              '${worldData.cases.active}',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Total Critical',
                style: TextStyle(color: Colors.black, fontSize: 18.0)),
            Text(
              '${worldData.cases.critical}',
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            )
          ],
        )
      ],
    ),
  );
}
