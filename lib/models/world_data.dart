class World {
  Cases cases;
  Deaths deaths;
  String day;
  String country;
  String time;
  Tests total;

  World(
      {this.cases, this.deaths, this.day, this.country, this.time, this.total});

  factory World.fromJson(Map<String, dynamic> json) {
    return World(
        cases: Cases.fromJson(json['cases']),
        deaths: Deaths.fromJson(json['deaths']),
        country: json['country'],
        day: json['day'],
        time: json['time'],
        total: Tests.fromJson(json['tests']));
  }
}

class Cases {
  String active;
  String critical;
  String newCases;
  String recovered;
  String total;

  Cases(
      {this.active, this.critical, this.newCases, this.recovered, this.total});

  factory Cases.fromJson(Map<String, dynamic> json) {
    return Cases(
        active: json['active'],
        critical: json['critical'],
        newCases: json['new'],
        recovered: json['recovered'],
        total: json['total']);
  }
}

class Deaths {
  String newDeaths;
  String total;

  Deaths({this.newDeaths, this.total});

  factory Deaths.fromJson(Map<String, dynamic> json) {
    return Deaths(newDeaths: json['new'], total: json['total']);
  }
}

class Tests {
  String totalTests;

  Tests({this.totalTests});

  factory Tests.fromJson(Map<String, dynamic> json) {
    return Tests(totalTests: json['total']);
  }
}
