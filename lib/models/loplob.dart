class Loplob {
    int requiredCredit;
    String uuid;
    int value;
    Loplob({
      this.uuid,
      this.requiredCredit,
      this.value,
    });

    factory Loplob.fromJson(Map<String, dynamic> json) => new Loplob(
      uuid: json["uuid"],
      requiredCredit: json["required_credit"],
      value: json["value"],
    );
}