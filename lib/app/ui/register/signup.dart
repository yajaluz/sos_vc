import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sos_vc/app/ui/auth/login.dart';
import 'package:sos_vc/app/ui/layout.dart';

class SignUpPage extends StatelessWidget {
  static String tag = '/signup';

  @override
  Widget build(BuildContext context) {
    return Layout.render(
      // fab: null,
      content: Container(
        padding: EdgeInsets.only(top: 20, left: 40, right: 40),
        color: Colors.white,
        child: ListView(children: <Widget>[
          Container(
            width: 200,
            height: 200,
            alignment: Alignment(0.0, 1.20),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: AssetImage('assets/default.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: Container(
              height: 56,
              width: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color(0xFF7540EE).withOpacity(.2),
                  border: Border.all(
                    width: 4.0,
                    color: const Color(0xFFFFFFFF),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(56))),
              child: SizedBox.expand(
                child: Icon(
                  FontAwesomeIcons.plus,
                  color: Color(0xFF7540EE),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            autofocus: true,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: 'Nome completo',
              hintStyle: TextStyle(
                fontSize: 16,
                color: Color(0xFF787993),
                fontStyle: FontStyle.italic,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFDFDFE4),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF787993),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'CPF',
              hintStyle: TextStyle(
                fontSize: 16,
                color: Color(0xFF787993),
                fontStyle: FontStyle.italic,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFDFDFE4),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF787993),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: TextStyle(
                fontSize: 16,
                color: Color(0xFF787993),
                fontStyle: FontStyle.italic,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFDFDFE4),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF787993),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              hintText: 'Senha',
              hintStyle: TextStyle(
                fontSize: 16,
                color: Color(0xFF787993),
                fontStyle: FontStyle.italic,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFDFDFE4),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF787993),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Confirmar senha',
              hintStyle: TextStyle(
                fontSize: 16,
                color: Color(0xFF787993),
                fontStyle: FontStyle.italic,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFDFDFE4),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF787993),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          Container(
            height: 60,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Color(0xFF7540EE).withOpacity(.2),
              border: Border.all(
                width: 4.0,
                color: const Color(0xFFFFFFFF),
              ),
              borderRadius: BorderRadius.all(Radius.circular(56)),
            ),
            child: SizedBox.expand(
              child: FlatButton(
                child: Text(
                  'Cadastrar',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7540EE),
                    fontSize: 16,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 40,
            alignment: Alignment.center,
            child: FlatButton(
              child: Text(
                'Cancelar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF7540EE),
                  fontStyle: FontStyle.italic,
                  // fontSize: 15,
                ),
              ),
              onPressed: () =>
                  Get.toNamed(LoginPage.tag), //Navigator.pop(context, false),
            ),
          )
        ]),
      ),
    );
  }
}
