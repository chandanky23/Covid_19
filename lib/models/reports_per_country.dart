class ReportPerCountry {
  String iso;
  String name;
  String date;
  String confirmed;
  String deaths;
  String recovered;
  String confirmedDiff;
  String recoveredDiff;
  String deathsDiff;
  String active;
  String fatalityRate;

  ReportPerCountry(
    {
      this.iso,
      this.name,
      this.date,
      this.confirmed,
      this.deaths,
      this.recovered,
      this.confirmedDiff,
      this.recoveredDiff,
      this.deathsDiff,
      this.active,
      this.fatalityRate
    }
  );

  factory ReportPerCountry.fromJson(Map<String, dynamic> json) {
    return ReportPerCountry(
      iso: json['iso'],
      name: json['name'],
      date: json['date'],
      confirmed: json['confirmed'],
      deaths: json['deaths'],
      recovered: json['recovered'],
      confirmedDiff: json['confirmedDiff'],
      recoveredDiff: json['recoveredDiff'],
      deathsDiff: json['deathsDiff'],
      active: json['active'],
      fatalityRate: json['fatalityRate']
    );
  }
}