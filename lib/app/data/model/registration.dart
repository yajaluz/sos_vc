import 'package:flutter/cupertino.dart';

class Registration {
  late String id;
  @required
  String name;
  late String CPF;
  late String email;
  late String pass;

  Registration({
    this.id = '',
    required this.name,
    required this.CPF,
    required this.email,
    required this.pass,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'CPF': CPF,
        'email': email,
        'pass': pass,
      };

  static Registration fromJson(Map<String, dynamic> json) => Registration(
        name: json['name'],
        CPF: json['CPF'],
        email: json['email'],
        pass: json['pass'],
      );
}
