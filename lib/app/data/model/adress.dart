import 'package:sos_vc/app/data/model/user.dart';

class Adress {
  late String id;
  late String street;
  late String? number;
  late String country;
  late String city;
  late String state;
  late String neighborhood;
  String? complement;

  Adress({
    required this.id,
    required this.street,
    this.number,
    required this.country,
    required this.city,
    required this.state,
    required this.neighborhood,
    this.complement,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'street': street,
        'number': number,
        'country': country,
        'city': city,
        'state': state,
        'complement': complement,
        'neighborhood': neighborhood,
      };

  static Adress fromJson(Map<String, dynamic> json) => Adress(
        id: json['id'],
        street: json['street'],
        number: json['number'],
        country: json['country'],
        city: json['city'],
        state: json['state'],
        complement: json['complement'],
        neighborhood: json['neighborhood'],
      );
}
