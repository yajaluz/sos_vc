import 'package:flutter/material.dart';
import '../../util/constants.dart';
import 'location_screen.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName = '';

  @override
  Widget build(BuildContext context) {
    return //Scaffold(
        // body:
        Container(
      // decoration: const BoxDecoration(
      // image: DecorationImage(
      // image: AssetImage('assets/city_background.jpg'),
      // fit: BoxFit.cover,
      // )),
      constraints: const BoxConstraints.expand(),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 50.0,
                ),
              ),
            ),
            // Text(
            // 'Weatrio',
            // style: kLogoTextStyle,
            // ),
            // SizedBox(
            // height: 100,
            // ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: kTextFieldInputDecoration,
                onChanged: (value) {
                  cityName = value;
                },
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.cyan),
                ),
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: const Text(
                  'Buscar',
                  style: kButtonTextStyle,
                ))
          ],
        ),
      ),
    );
    // );
  }
}
