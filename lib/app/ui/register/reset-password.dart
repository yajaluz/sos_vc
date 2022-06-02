import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sos_vc/app/ui/layout.dart';

class ResetPasswordPage extends StatelessWidget {
  static String tag = '/reset';
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout.render(
      content: Container(
        padding: EdgeInsets.only(top: 40, left: 40, right: 40),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 200,
              child: Image.asset('assets/reset-pass.png'),
            ),
            SizedBox(height: 20),
            Text(
              'Esqueceu sua senha?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF7540EE),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Por favor, informe o e-mail associado a sua conta',
              style: TextStyle(
                color: Color(0xFF787993),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'E-mail',
                hintStyle: TextStyle(
                  color: Color(0xFF787993),
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
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
              style: TextStyle(
                fontSize: 16,
                color: Colors.black45,
              ),
            ),
            SizedBox(height: 20),
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
                    'Enviar',
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
            SizedBox(height: 5),
            Column(
              children: <Widget>[
                Divider(
                  height: 50,
                  thickness: 3,
                  indent: 20,
                  endIndent: 20,
                ),
                // Text('_____ Ou _____'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
