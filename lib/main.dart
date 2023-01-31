import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sos_vc/app/ui/auth/login.dart';
import 'package:sos_vc/app/ui/initial/index.dart';
import 'package:sos_vc/app/ui/register/new-pass.dart';
import 'package:sos_vc/app/ui/register/register.dart';
import 'package:sos_vc/app/ui/register/reset-password.dart';
import 'package:sos_vc/app/ui/register/signup.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(FirebaseAuth.instance);
  });

  runApp(const Teste());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Teste extends StatelessWidget {
  const Teste({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      home: const MyApp(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.cantarellTextTheme(
            Theme.of(context).textTheme,
          )),
      initialRoute: LoginWidget.tag,
      routes: {
        SignUpAux.tag: (_) => SignUpAux(),
        LoginWidget.tag: (_) => const LoginWidget(),
        RegisterPage.tag: (_) => RegisterPage(),
        // AuxPage.tag: (_) => AuxPage(),
        ResetPasswordPage.tag: (_) => ResetPasswordPage(),
        NewPassPage.tag: (_) => NewPassPage(),
        IndexPage.tag: (_) => const IndexPage(),
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Algo saiu errado'),
              );
            } else if (snapshot.hasData) {
              return const IndexPage();
            } else {
              return const LoginWidget();
            }
          },
        ),
      );
}
