import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_vc/app/ui/layout.dart';
import 'package:sos_vc/app/ui/register/finger-face-authID.dart';
import 'package:basic_utils/basic_utils.dart';

import '../../../main.dart';

class ResetWidget extends StatefulWidget {
  static String tag = '/reset';

  const ResetWidget({Key? key}) : super(key: key);

  @override
  ResetPasswordPage createState() => ResetPasswordPage();
}

class ResetPasswordPage extends State<ResetWidget> {
  // static String tag = '/reset';
  @override
  FingerFaceIDPage createState() => FingerFaceIDPage();

  final _key = GlobalKey<FormState>();
  late BuildContext _context;
  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Layout.render(
      content: Container(
        padding: EdgeInsets.only(top: 40, left: 40, right: 40),
        child: Form(
          key: _key,
          child: ListView(
            // key: _key,
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
                controller: controllerEmail,
                autofocus: true,
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
                  child: TextButton(
                    child: Text(
                      'Enviar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7540EE),
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      _context = context;
                      ResetPassword();
                    },
                  ),
                ),
              ),
              SizedBox(height: 25),
              Column(
                children: <Widget>[
                  Divider(
                    color: Color(0xFF7540EE).withOpacity(.2),
                    thickness: 2,
                    indent: 3,
                    endIndent: 0,
                    // width: 10,
                  ),
                  SizedBox(height: 25),
                  Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          TextButton(
                            onPressed: () => FingerFaceIDPage().initState(),
                            child: SizedBox(
                              width: 100,
                              height: 120,
                              child: Image.asset('assets/finger.png'),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 100,
                              // padding: const EdgeInsets.all(10),
                              child: VerticalDivider(
                                color: Color(0xFF7540EE).withOpacity(.2),
                                thickness: 2,
                                indent: 3,
                                endIndent: 0,
                                width: 10,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () => FingerFaceIDPage().initState(),
                            child: SizedBox(
                              width: 73,
                              height: 120,
                              child: Image.asset('assets/face.png'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future ResetPassword() async {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: ((context) => const Center(
              child: CircularProgressIndicator.adaptive(),
            )));

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: controllerEmail.text.trim());

      // Utils.showSnackBar('Enviado');
      _showMyDialog('Enviado', 'Verifique sua caixa de mensagens');
    } on FirebaseAuthException catch (e) {
      // Utils.showSnackBar(e.message);
      _showMyDialog('Error', 'Erro ao enviar:');
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<void> _showMyDialog(String titulo, String mensagem) async {
    return showDialog<void>(
      context: _context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titulo),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("$mensagem"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
