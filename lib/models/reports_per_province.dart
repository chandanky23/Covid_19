class ReportPerProvince {
  Region region;
  String date;
  String confirmed;
  String deaths;
  String recovered;
  String confirmedDiff;
  String recoveredDiff;
  String deathsDiff;
  String active;
  String fatalityRate;

  ReportPerProvince(
    {
      this.region,
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

  factory ReportPerProvince.fromJson(Map<String, dynamic> json) {
    return ReportPerProvince(
      region: Region.fromJson(json['region']),
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

class Region {
  String iso;
  String name;
  String province;

  Region(
    {
      this.iso,
      this.name,
      this.province
    }
  );

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      iso: json['iso'] as String,
      name: json['name'] as String,
      province: json['province'] as String
    );
  }
}
