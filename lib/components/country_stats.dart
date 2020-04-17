import 'package:covid_19/components/line_charts.dart';
import 'package:flutter/material.dart';

Widget countryStats(
    BuildContext context, Axis scrollDirection, double height, List data) {
  print(data);
  return new Container(
      height: height,
      margin: EdgeInsets.all(10.0),
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: data?.length,
        scrollDirection: scrollDirection,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.all(10.0),
            color: Colors.white,
            width: MediaQuery.of(context).size.height * 0.4,
            child: (Center(
              // child: Text(
              //   '${data[index].cases.active}',
              //   style: TextStyle(color: Colors.amber),
              // ),
              child: SimpleLineChart(data),
            )),
          );
        },
      ));
}
