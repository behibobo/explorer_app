class UserLoplob {
    int id;
    int value;
    String date;
    String uuid;
    bool won;
    UserLoplob({
      this.id,
      this.value,
      this.date,
      this.uuid,
      this.won,
    });

    factory UserLoplob.fromJson(Map<String, dynamic> json) => new UserLoplob(
      value: json["value"],
      date: json["date"],
      uuid: json["uuid"],
      won: json["won"],
    );
}