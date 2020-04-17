import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleLineChart extends StatelessWidget {
  List<charts.Series> seriesList;
  bool animate;

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList, animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearStats, String>> _createData() {
    
    return [
      new charts.Series<LinearStats, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearStats data, _) => data.day,
        measureFn: (LinearStats data, _) => data.value,
        data: data,
      )
    ];
  }
}

class LinearStats {
  final String day;
  final int value;

  LinearStats(this.day, this.value);
}