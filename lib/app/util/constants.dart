import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 60.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
);

const kCityTextStyle = TextStyle(
  fontSize: 50,
  letterSpacing: 1.5,
  fontFamily: 'MsMadi',
  fontWeight: FontWeight.bold,
  decoration: TextDecoration.underline,
);

const kLogoTextStyle = TextStyle(
  fontSize: 80,
  fontWeight: FontWeight.w500,
  letterSpacing: 1.0,
  fontFamily: 'MsMadi',
);

const kButtonTextStyle = TextStyle(
  fontSize: 28.0,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.bold,
);

const kConditionTextStyle = TextStyle(
  fontSize: 60.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);