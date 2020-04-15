class Loplob {
    int id;
    int value;
    String date;
    String uuid;
    bool won;
    Loplob({
      this.id,
      this.value,
      this.date,
      this.uuid,
      this.won,
    });

    factory Loplob.fromJson(Map<String, dynamic> json) => new Loplob(
      value: json["value"],
      date: json["date"],
      uuid: json["uuid"],
      won: json["won"],
    );
}