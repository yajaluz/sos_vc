import 'package:sos_vc/app/data/model/user.dart';

class Adress {
  late String street;
  String? number;
  late String country;
  late String city;
  late String state;
  late String district;
  String? complement;

  Adress({
    required this.street,
    this.number,
    required this.country,
    required this.city,
    required this.state,
    required this.district,
    this.complement,
  });
}
