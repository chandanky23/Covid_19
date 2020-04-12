class Country {
  Cases cases;
  String country;
  String day;
  Deaths deaths;
  Tests tests;
  String time;
  String flag;

  Country(
    {
      this.country,
      this.day,
      this.cases,
      this.deaths,
      this.tests,
      this.time,
      this.flag
    }
  );

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      cases: Cases.fromJson(json['cases']),
      country: json['country'],
      day: json['day'],
      deaths: Deaths.fromJson(json['deaths']),
      tests: Tests.fromJson(json['tests']),
      time: json['time'],
      flag: json['flag']
    );
  }
}

class Cases{
  int active;
  int critical;
  String newcases; // new is a reserved keyword and hence using newcases instead of new
  int recovered;
  int total;

  Cases(
    {
      this.active,
      this.critical,
      this.newcases,
      this.recovered,
      this.total
    }
  );

  factory Cases.fromJson(Map<String, dynamic> json) {
    return Cases(
      active: json['active'],
      critical: json['critical'],
      newcases: json['new'],
      recovered: json['recovered'],
      total: json['total']
    );
  }
}

class Tests {
  int total;

  Tests(
    {
      this.total
    }
  );
  factory Tests.fromJson(Map<String, dynamic> json) {
    return Tests(
      total: json['total']
    );
  }
}

class Deaths {
  String newdeaths;
  int total;
  Deaths(
    {
      this.newdeaths,
      this.total
    }
  );

  factory Deaths.fromJson(Map<String, dynamic> json) {
    return Deaths(
      newdeaths: json['new'],
      total: json['total']
    );
  }
}