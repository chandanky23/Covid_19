class CountryStats {
  String day;
  int value;

  CountryStats({this.day, this.value});

  factory CountryStats.fromJson(Map<dynamic, dynamic> json) {
    return CountryStats(day: json['day'], value: json['value']);
  }
}
