class UserModel {
  const UserModel(
      {this.id,
      required this.name,
      required this.email,
      required this.dateOfBirth,
      required this.accountNum,
      required this.phonenum,
      required this.password,
      required this.money});

  final String? id;
  final String name;
  final String email;
  final String dateOfBirth;
  final String accountNum;
  final String phonenum;
  final String password;
  final int money;

  toJson() {
    return {
      "FullName": name,
      "Email": email,
      "Date of Birth":dateOfBirth,
      "Account Num":accountNum,
      "PhoneNum":phonenum,
      "Password":password,
      "Money":money
    };
  }
}
