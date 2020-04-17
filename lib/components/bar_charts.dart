import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid_19/models/country_stats_chart.dart';
import 'package:flutter/material.dart';

class CountryStatsChart extends StatelessWidget {
  final List<CountryStatsDataSeries> data;
  final String chartTitle;

  CountryStatsChart({@required this.data, this.chartTitle});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<CountryStatsDataSeries, String>> series = [
      charts.Series<CountryStatsDataSeries, String>(
          id: 'CountryStatsDataSeries',
          data: data,
          domainFn: (CountryStatsDataSeries series, _) => series.day,
          measureFn: (CountryStatsDataSeries series, _) => series.value,
          colorFn: (CountryStatsDataSeries series, _) => series.barColor)
    ];
    return new charts.BarChart(
      series,
      animate: true,
      domainAxis: new charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelRotation: 60,
        ),
      ),
      behaviors: [
        new charts.ChartTitle(chartTitle,
            titleStyleSpec: charts.TextStyleSpec(fontSize: 20, fontWeight: 'bold'),
            behaviorPosition: charts.BehaviorPosition.bottom),
      ],
    );
  }
}
