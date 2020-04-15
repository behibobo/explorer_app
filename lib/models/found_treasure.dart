class FoundTrasure {
    int id;
    int value;
    String date;
    FoundTrasure({
      this.id,
      this.value,
      this.date,
    });

    factory FoundTrasure.fromJson(Map<String, dynamic> json) => new FoundTrasure(
      value: json["value"],
      date: json["date"],
    );
}