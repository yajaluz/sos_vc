import 'location.dart';
import 'networking.dart';

const apiKey = '49ec3246e6cdfc5ab378eafb9217629e'; //api key
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  static final WeatherModel _singleton = WeatherModel._internal();

  factory WeatherModel() {
    return _singleton;
  }

  WeatherModel._internal();

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'Tempo de refrescar🍦';
    } else if (temp > 20) {
      return 'Põe uma chinela e 👕';
    } else if (temp < 10) {
      return 'Põe um agasalho 🧣 🧤';
    } else {
      return 'Leve um 🧥 na mochila';
    }
  }
}
