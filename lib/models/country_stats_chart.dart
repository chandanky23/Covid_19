import 'package:flutter/foundation.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CountryStatsDataSeries {
  final String day;
  final int value;
  final charts.Color barColor;

  CountryStatsDataSeries({
    @required this.day,
    @required this.value,
    this.barColor
  });
}