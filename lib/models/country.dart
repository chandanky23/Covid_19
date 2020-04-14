class Country {
  String active;
  String cases;
  String updated;
  String country;
  CountryInfo countryInfo;
  String todayCases;
  String deaths;
  String todayDeaths;
  String recovered;
  String critical;
  String casesPerOneMillion;
  String deathsPerOneMillion;
  String tests;
  String testsPerOneMillion;

  Country(
    {
      this.active,
      this.cases,
      this.updated,
      this.country,
      this.countryInfo,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.critical,
      this.casesPerOneMillion,
      this.deathsPerOneMillion,
      this.tests,
      this.testsPerOneMillion
    }
  );

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country (
      active: json['active'],
      cases: json['cases'],
      updated: json['updated'],
      country: json['country'],
      countryInfo: CountryInfo.fromJson(json['countryInfo']),
      todayCases: json['todayCases'],
      deaths: json['deaths'],
      todayDeaths: json['todayDeaths'],
      recovered: json['recovered'],
      critical: json['critical'],
      casesPerOneMillion: json['casesPerOneMillion'],
      deathsPerOneMillion: json['deathsPerOneMillion'],
      tests: json['tests'],
      testsPerOneMillion: json['testsPerOneMillion']
    );
  }
}

class CountryInfo {
  int id;
  String iso2;
  String iso3;
  String flag;

  CountryInfo(
    {
      this.id,
      this.iso2,
      this.iso3,
      this.flag
    }
  );

  factory CountryInfo.fromJson(Map<String, dynamic> json) {
    return CountryInfo(
      flag: json['flag'],
      id: json['_id'],
      iso2: json['iso2'],
      iso3: json['iso3'],
    );
  }
}