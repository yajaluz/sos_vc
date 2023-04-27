import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sos_vc/app/ui/auth/login.dart';
import 'package:sos_vc/app/ui/layout.dart';

class AnimationPage extends StatefulWidget {
  static String tag = '/animation';

  const AnimationPage({Key? key}) : super(key: key);

  @override
  SplashAnimatedPage createState() => SplashAnimatedPage();
}

class SplashAnimatedPage extends State<AnimationPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 8)).then((_) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginWidget()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Layout.render(
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.houseChimneyMedical,
              color: Color(0xFF7540EE),
              size: 100,
            )
                .animate(
                  onPlay: ((controller) => controller.repeat()),
                )
                .moveY(
                    begin: -25,
                    end: 15,
                    curve: Curves.easeInOut,
                    duration: 1000.ms)
                .then()
                .moveY(begin: 15, end: -25, curve: Curves.easeInOut),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                width: 150,
                height: 15,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(150, 15),
                  ),
                ),
              ),
            )
                .animate(
                  onPlay: ((controller) => controller.repeat()),
                )
                .scaleX(
                    begin: 1.2,
                    end: .8,
                    curve: Curves.easeInOut,
                    duration: 1000.ms)
                .then()
                .scaleX(begin: .8, end: 1.2, curve: Curves.easeInOut)
          ],
        ),
      ),
    );
  }
}
