import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sos_vc/app/ui/auth/login.dart';
import 'package:sos_vc/app/ui/initial/index.dart';
import 'package:sos_vc/app/ui/register/new-pass.dart';
import 'package:sos_vc/app/ui/register/register.dart';
import 'package:sos_vc/app/ui/register/reset-password.dart';
import 'package:sos_vc/app/ui/register/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.cantarellTextTheme(
            Theme.of(context).textTheme,
          )),
      initialRoute: LoginPage.tag,
      // home: HomePageFinger(),
      routes: {
        LoginPage.tag: (_) => LoginPage(),
        RegisterPage.tag: (_) => RegisterPage(),
        SignUpPage.tag: (_) => SignUpPage(),
        ResetPasswordPage.tag: (_) => ResetPasswordPage(),
        NewPassPage.tag: (_) => NewPassPage(),
        IndexPage.tag: (_) => IndexPage(),
      },
    );
  }
}
