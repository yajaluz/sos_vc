import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sos_vc/app/ui/layout.dart';

class ResumePage extends StatelessWidget {
  static String tag = '/index';

  final String cidade;
  final String descricao;
  final double temperaturaAtual;
  final double tempMax;
  final double tempMin;
  final double numeroIcone;

  const ResumePage(
      {Key? key,
      required this.cidade,
      required this.descricao,
      required this.temperaturaAtual,
      required this.tempMax,
      required this.tempMin,
      required this.numeroIcone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(padding: EdgeInsets.all(5)),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              Icon(Icons.brightness_6_outlined),
              Switch(
                value: false,
                onChanged: (valor) {},
              )
            ],
          )
        ],
      ),
      Text(cidade, style: TextStyle(fontSize: 20)),
      Padding(padding: EdgeInsets.all(5)),
      Row(),
    ]);
  }
}
