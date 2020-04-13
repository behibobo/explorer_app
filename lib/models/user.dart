class User {
  int gender;
  String email;
  String firstName;
  String lastName;
  String dob;
  String mobile;
  int credit;
  int totalItems;
  int totalGift;
  int minGift;
  int maxGift;

  User(
      {
        this.gender,
        this.email,
        this.firstName,
        this.lastName,
        this.dob,
        this.mobile,
        this.credit,
        this.totalItems,
        this.totalGift,
        this.minGift,
        this.maxGift,
    });

  User.fromJson(Map<String, dynamic> json) {
    gender = json['user']['gender'];
    firstName = json['user']['first_name'];
    lastName = json['user']['last_name'];
    credit = json['user']['credit'];
    email = json['user']['email'];
    dob = json['user']['dob'];
    mobile = json['user']['mobile'];
    totalItems = json['total_items'];
    totalGift = json['total_gifts'];
    minGift = json['min_gift'];
    maxGift = json['max_gift'];
  }  
}