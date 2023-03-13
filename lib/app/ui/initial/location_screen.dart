import 'package:flutter/material.dart';
import '../initial/city_screen.dart';
import '../../controller/weather.dart';
import '../../util/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return //Scaffold(
        // body:
        // Container(
        // alignment: Alignment.centerLeft,
        // decoration: BoxDecoration(
        // image: DecorationImage(
        // image: const AssetImage('assets/location_background.jpg'),
        // fit: BoxFit.cover,
        // colorFilter: ColorFilter.mode(
        // Colors.white.withOpacity(0.8), BlendMode.dstATop),
        // ),
        // ),
        // constraints: const BoxConstraints.expand(),
        // child:
        // SafeArea(
        // child:
        Container(
      height: 50.0,
      width: 50.0,
      color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // children: <Widget>[
          // // TextButton(
          // // onPressed: () async {
          // // var weatherData = await weather.getLocationWeather();
          // // updateUI(weatherData);
          // // },
          // // child: const Icon(
          // // Icons.near_me,
          // // size: 50.0,
          // // ),
          // // ),
          // TextButton(
          // onPressed: () async {
          // var typedName = await Navigator.push(
          // context,
          // MaterialPageRoute(
          // builder: (context) {
          // return CityScreen();
          // },
          // ),
          // );
          // if (typedName != null) {
          // var weatherData = await weather.getCityWeather(typedName);
          // updateUI(weatherData);
          // }
          // },
          // child: const Icon(
          // Icons.location_city,
          // size: 50.0,
          // ),
          // ),
          // ],
          // ),
          // SizedBox(
          // height: 40,
          // ),
          Card(
            color: Colors.white.withOpacity(0.3),
            elevation: 8,
            margin: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Text(
                  cityName,
                  style: kCityTextStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '$temperature°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 30),
                  child: Text(
                    '$weatherMessage\nin $cityName',
                    textAlign: TextAlign.left,
                    style: kMessageTextStyle,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
    // );
    // ),
    // );
    // );
  }
}
