import 'package:flutter/cupertino.dart';

class Order {
  late String id;
  late String nameFather;
  @required
  late String orderNumber;
  late String forWho;
  late String name;
  late String CPF;
  late String docType;
  late String RG;
  late String nameMother;
  late String natural;
  late String birthDate;
  late String maritalStatus;
  late String gender;

  Order({
    this.id = '',
    this.nameFather = '',
    required this.orderNumber,
    required this.forWho,
    required this.name,
    required this.CPF,
    required this.docType,
    required this.RG,
    required this.nameMother,
    required this.natural,
    required this.birthDate,
    required this.maritalStatus,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderNumber': orderNumber,
        'forWho': forWho,
        'name': name,
        'CPF': CPF,
        'docType': docType,
        'RG': RG,
        'nameMother': nameMother,
        'nameFather': nameFather,
        'natural': natural,
        'birthDate': birthDate,
        'maritalStatus': maritalStatus,
        'gender': gender,
      };

  static Order fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        orderNumber: json['orderNumber'],
        forWho: json['forWho'],
        name: json['name'],
        CPF: json['CPF'],
        docType: json['docType'],
        RG: json['RG'],
        nameMother: json['nameMother'],
        nameFather: json['nameFather'],
        natural: json['natural'],
        birthDate: json['birthDate'],
        maritalStatus: json['maritalStatus'],
        gender: json['gender'],
      );
}
