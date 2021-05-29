import 'package:flutter/material.dart';


class WeatherLocation {
  String city;
  String dateTime;
  String temperature;
  String weatherType;
  String description = 'clear sky';
  String iconUrl;

  WeatherLocation({
    @required this.city,
    @required this.dateTime,
    @required this.temperature,
    @required this.weatherType,
    @required this.iconUrl,
  });
}