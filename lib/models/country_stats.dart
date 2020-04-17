class CountryStats {
  String day;
  int val;

  CountryStats({this.day, this.val});

  factory CountryStats.fromJson(Map<String, dynamic> json) {
    return CountryStats(day: json['day'], val: json['val']);
  }
}
