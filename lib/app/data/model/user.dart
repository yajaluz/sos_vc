class User {
  String? id;
  late String fullName;
  late String email;
  late String pic;
  late String biometric;
  late String pass;
  String? cpf;
  String? rg;

  User({
    this.id,
    required this.fullName,
    required this.email,
    required this.pic,
    required this.biometric,
    required this.pass,
    this.cpf,
    this.rg,
  });
}
