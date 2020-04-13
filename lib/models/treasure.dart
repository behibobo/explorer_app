class Treasure {
    String lat;
    String lng;
    Treasure({
      this.lat,
      this.lng,
    });

    factory Treasure.fromJson(Map<String, dynamic> json) => new Treasure(
      lat: json["lat"],
      lng: json["lng"],
    );
}