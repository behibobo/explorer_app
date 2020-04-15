class Loplobs {
    String uuid;
    Loplobs({
      this.uuid,
    });

    factory Loplobs.fromJson(Map<String, dynamic> json) => new Loplobs(
      uuid: json["uuid"],
    );
}