import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../controller/weather.dart';

class LoadingScreen extends StatefulWidget {
  static String tag = '/weather';
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();

    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    // return Container(
    // child: LocationScreen2(
    // locationWeather: weatherData,
    // ));
    // }));

    // return weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return const SpinKitDoubleBounce(
      color: Color(0xFF7540EE),
      size: 30.0,
    );
  }
}
