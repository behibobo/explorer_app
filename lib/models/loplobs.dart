class Loplobs {
    int id;
    int requiredCredit;
    int qty;
    Loplobs({
      this.id,
      this.requiredCredit,
      this.qty,
    });

    factory Loplobs.fromJson(Map<String, dynamic> json) => new Loplobs(
      id: json["id"],
      requiredCredit: json["required_credit"],
      qty: json["qty"],
    );
}