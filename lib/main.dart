import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sos_vc/app/ui/auth/login.dart';
import 'package:sos_vc/app/ui/initial/animationpage.dart';
import 'package:sos_vc/app/ui/initial/faq.dart';
import 'package:sos_vc/app/ui/initial/index.dart';
import 'package:sos_vc/app/ui/initial/loading_screen.dart';
import 'package:sos_vc/app/ui/profile/my-donation.dart';
import 'package:sos_vc/app/ui/profile/my-order.dart';
import 'package:sos_vc/app/ui/profile/my-profile.dart';
import 'package:sos_vc/app/ui/profile/my-region.dart';
import 'package:sos_vc/app/ui/register/reset-password.dart';
import 'package:sos_vc/app/ui/register/signup.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/ui/profile/my-order-continue.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future main() async {
  HttpOverrides.global = MyHttpOverrides();

  Animate.restartOnHotReload = true;

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
      initialRoute: AnimationPage.tag,
      routes: {
        AnimationPage.tag: (_) => const AnimationPage(),
        SignUpAux.tag: (_) => const SignUpAux(),
        LoginWidget.tag: (_) => const LoginWidget(),
        MyFavoritePageAux.tag: (_) => const MyFavoritePageAux(),
        MyOrderPageAux.tag: (_) => const MyOrderPageAux(),
        MyOrderPageAuxContinue.tag: (_) => const MyOrderPageAuxContinue(),
        MyRegionPageAux.tag: (_) => const MyRegionPageAux(),
        MyProfilePageAux.tag: (_) => const MyProfilePageAux(),
        ResetWidget.tag: (_) => const ResetWidget(),
        IndexPageAux.tag: (_) => const IndexPageAux(),
        LoadingScreen.tag: (_) => const LoadingScreen(),
        FAQPageAux.tag: (_) => const FAQPageAux(),
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
              return const IndexPageAux();
            } else {
              return const LoginWidget();
            }
          },
        ),
      );
}
