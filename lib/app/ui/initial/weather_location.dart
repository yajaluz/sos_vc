import 'package:flutter/material.dart';
import '../../controller/weather.dart';
import '../../util/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);

  @override
  State<LocationScreen> createState() => WeatherLocation();
}

class WeatherLocation extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weatherIcon = '';
  String cityName = '';
  String? weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Erro';
        weatherMessage = 'Não foi possível analisar a previsão do tempo';
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

  Widget render({
    required Widget content,
    Widget? fab,
  }) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            color: Colors.white.withOpacity(0.3),
            elevation: 8,
            margin: const EdgeInsets.all(15),
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
                    '$weatherMessage\n em $cityName',
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
  }

  static Color light([double opacity = 1]) =>
      Color.fromRGBO(230, 230, 230, opacity);
  static Color dark([double opacity = 1]) =>
      Color(0xff333333).withOpacity(opacity);

  @override
  Widget build(BuildContext context) {
    return render(content: const LocationScreen());
  }
}
