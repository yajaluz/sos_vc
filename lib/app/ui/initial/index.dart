import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sos_vc/app/ui/initial/resume.dart';
import 'package:sos_vc/app/ui/layout.dart';

class IndexPage extends StatelessWidget {
  static String tag = '/index';

  @override
  Widget build(BuildContext context) {
    return Layout.render(
      // fab: null,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Center(
            child: Column(children: [
              ResumePage(
                cidade: 'Salvador-BA',
                temperaturaAtual: 28,
                tempMax: 30,
                tempMin: 26,
                descricao: 'Ensolarado',
                numeroIcone: 1,
              ),
            ]),
          ),
          // Text("OI!"),
        ],
      ),
    );
  }
}
