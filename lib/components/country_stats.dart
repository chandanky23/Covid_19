import 'package:covid_19/components/bar_charts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid_19/models/country_stats_chart.dart';
import 'package:flutter/material.dart';

class ShowCountryStatistics extends StatelessWidget {
  final List chartData;
  final Axis scrollDirection;
  final double height;
  final List chartDataName;
  ShowCountryStatistics(
      {this.chartData, this.scrollDirection, this.height, this.chartDataName});

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: height,
        child: new ListView.builder(
          itemCount: chartData?.length,
          scrollDirection: scrollDirection,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
                height: height * 0.4,
                margin: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 20.0,
                        color: Colors.black26,
                        spreadRadius: 10.0)
                  ],
                  color: Colors.white,
                ),
                child: new Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        height: 500.0,
                        child: CountryStatsChart(
                          data: chartsDataConstructor(
                              chartData[index], chartDataName[index]),
                          chartTitle: chartDataName[index],
                        ))));
          },
        ));
  }
}

getChartColors(chartTitle) {
  switch (chartTitle) {
    case 'Total Deaths':
      return charts.ColorUtil.fromDartColor(Colors.red[700]);
    case 'New Deaths':
      return charts.ColorUtil.fromDartColor(Colors.red[700]);
    case 'Total Recovery':
      return charts.ColorUtil.fromDartColor(Colors.green[700]);
    case 'Active Cases':
      return charts.ColorUtil.fromDartColor(Colors.yellow[700]);
    case 'Critical Cases':
      return charts.ColorUtil.fromDartColor(Color.lerp(Colors.red, Colors.orange, 0.5));
    case 'New Cases':
      return charts.ColorUtil.fromDartColor(Colors.blue[700]);
    default:
      return charts.ColorUtil.fromDartColor(Color.lerp(Colors.blue, Colors.red, 0.4));
  }
}

List<CountryStatsDataSeries> chartsDataConstructor(chartData, chartDataName) {
  List<CountryStatsDataSeries> data = [];
  for (int i = chartData.length - 2; i >= 0; i--) {
    data.add(CountryStatsDataSeries(
        day: chartData[i].day,
        value: chartData[i].value,
        barColor: getChartColors(chartDataName)));
  }

  return data;
}
