class Province{
  String active;
  String confirmed;
  String deaths;
  String name;
  String recovered;
  String newDeaths;
  
  Province(
    {
      this.active,
      this.confirmed,
      this.deaths,
      this.name,
      this.recovered,
      this.newDeaths
    }
  );

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      active: json['active'],
      confirmed: json['confirmed'],
      deaths: json['deaths'],
      name: json['name'],
      recovered: json['recovered'],
      newDeaths: json['newDeaths']
    );
  }
}