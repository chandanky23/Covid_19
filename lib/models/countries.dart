class Countries {
  String iso;
  String name; 

  Countries(
    {
      this.iso,
      this.name
    }
  );

  factory Countries.fromJson(Map<String, dynamic> json) {
    return Countries(
      iso: json['iso'],
      name: json['name']
    );
  }
}
