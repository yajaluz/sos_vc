// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
// import 'package:sos_vc/app/data/model/registration.dart';
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
  // static String tag = '/login';
  final controllerEmail = TextEditingController();
  final controllerPass = TextEditingController();
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return Layout.render(
      // fab: FloatingActionButton(onPressed: () => null, child: Text('T')),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Padding(padding: EdgeInsets.all(5)),
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
                    // color: Color(0xFF7540EE).withOpacity(.2),
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(25),
                    // ),
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
        builder: (context) => Center(
              child: CircularProgressIndicator.adaptive(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: controllerEmail.text.trim(),
        password: controllerPass.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
