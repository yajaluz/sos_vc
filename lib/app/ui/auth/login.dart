import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sos_vc/app/ui/initial/index.dart';
import 'package:sos_vc/app/ui/layout.dart';
import 'package:sos_vc/app/ui/register/reset-password.dart';
import 'package:sos_vc/app/ui/register/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sos_vc/main.dart';

class LoginWidget extends StatefulWidget {
  static String tag = '/login';

  const LoginWidget({Key? key}) : super(key: key);

  @override
  LoginPage createState() => LoginPage();
}

class LoginPage extends State<LoginWidget> {
  final controllerEmail = TextEditingController();
  final controllerPass = TextEditingController();
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return Layout.render(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Icon(FontAwesomeIcons.houseChimneyMedical,
                      color: Color(0xFF7540EE)),
                  SizedBox(width: 10),
                  Text('SOS VC',
                      style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: Color(0xFF7540EE)))
                ]),
          ),
          Expanded(
              flex: 5,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Oferecemos boas-vindas e solidariedade',
                        style: TextStyle(
                          color: Color(0xFF25265E),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 20),
                    Text('Informe seus dados para entrar no portal',
                        style: TextStyle(
                          color: Color(0xFF787993),
                          fontStyle: FontStyle.italic,
                        )),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: controllerEmail,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
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
                      validator: (value) {
                        if (value != null &&
                            !value.isEmpty &&
                            !EmailValidator.validate(value)) {
                          return 'Formato de email inválido';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controllerPass,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
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
                      validator: (value) {
                        if (value != null && !value.isEmpty) {
                          if (value.length < 6) {
                            return 'A senha deve ter pelo menos 6 caracteres.';
                          } else {
                            return null;
                          }
                        }
                      },
                    ),
                    SizedBox(height: 20),
                  ])),
          Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      _context = context;
                      SignIn();
                    },
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        color: Color(0xFF7540EE),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(ResetWidget.tag),
                    child: Text(
                      'Esqueceu sua senha?',
                      style: TextStyle(
                        color: Color(0xFF7540EE),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              )),
          Expanded(
              flex: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Ainda não tem uma conta?',
                    style: TextStyle(
                      color: Color(0xFF787993),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(SignUpAux.tag),
                    child: Text(
                      'Crie uma agora!',
                      style: TextStyle(
                        color: Color(0xFFFF7052),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Future SignIn() async {
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) {
        Future.delayed(const Duration(seconds: 5), () {
          Navigator.of(context).pop(true);
        });

        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: controllerEmail.text.trim(),
        password: controllerPass.text.trim(),
      );
      // .then((authResult) {

      // });
    } on FirebaseAuthException catch (e) {
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );

      if (e.code == 'user-not-found') {
        var msg1 = 'Usuário não encontrado com esse email';
        AlertDialog alert = AlertDialog(
          title: Text("Erro"),
          content: Text(msg1),
          actions: [
            okButton,
          ],
        );
        showDialog(
          context: _context,
          builder: (BuildContext context) {
            return alert;
          },
        );
        print(msg1);
      } else if (e.code == 'wrong-password') {
        var msg1 = 'Senha errada';
        AlertDialog alert = AlertDialog(
          title: Text("Erro"),
          content: Text(msg1),
          actions: [
            okButton,
          ],
        );
        showDialog(
          context: _context,
          builder: (BuildContext context) {
            return alert;
          },
        );
        print(msg1);
      }

      // Navigator.pop(_context);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
