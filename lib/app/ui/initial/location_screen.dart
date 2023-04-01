// import 'package:flutter/material.dart';
// import '../../controller/weather.dart';
// import '../../util/constants.dart';

// class LocationScreen2 extends StatefulWidget {
//   final locationWeather;

//   const LocationScreen2({Key? key, this.locationWeather}) : super(key: key);

//   @override
//   State<LocationScreen2> createState() => _LocationScreen2State();
// }

// class _LocationScreen2State extends State<LocationScreen2> {
//   WeatherModel weather = WeatherModel();
//   late int temperature;
//   late String weatherIcon;
//   late String cityName;
//   late String weatherMessage;

//   @override
//   void initState() {
//     super.initState();

//     updateUI(widget.locationWeather);
//   }

//   void updateUI(dynamic weatherData) {
//     setState(() {
//       if (weatherData == null) {
//         temperature = 0;
//         weatherIcon = 'Error';
//         weatherMessage = 'Unable to get weather data';
//         cityName = '';
//         return;
//       }
//       double temp = weatherData["main"]["temp"];
//       temperature = temp.toInt();
//       var condition = weatherData['weather'][0]['id'];
//       weatherIcon = weather.getWeatherIcon(condition);
//       weatherMessage = weather.getMessage(temperature);
//       cityName = weatherData['name'];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 50.0,
//       width: 50.0,
//       color: Colors.white,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Card(
//             color: Colors.white.withOpacity(0.3),
//             elevation: 8,
//             margin: EdgeInsets.all(15),
//             child: Column(
//               children: <Widget>[
//                 Text(
//                   cityName,
//                   style: kCityTextStyle,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15.0, top: 10),
//                   child: Row(
//                     children: <Widget>[
//                       Text(
//                         '$temperature°',
//                         style: kTempTextStyle,
//                       ),
//                       Text(
//                         weatherIcon,
//                         style: kConditionTextStyle,
//                       )
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 20.0, top: 30),
//                   child: Text(
//                     '$weatherMessage\nin $cityName',
//                     textAlign: TextAlign.left,
//                     style: kMessageTextStyle,
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
