class Province{
  String iso;
  String name;
  String province;
  String lat;
  String long;

  Province(
    {
      this.iso,
      this.name,
      this.province,
      this.lat,
      this.long
    }
  );

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      iso: json['iso'],
      name: json['name'],
      province: json['province'],
      lat: json['lat'],
      long: json['long']
    );
  }
}