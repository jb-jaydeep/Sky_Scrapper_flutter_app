import 'dart:async';

import 'package:flutter/cupertino.dart';

class Weather {
  String condition;
  double temp_c;
  String name;
  String region;
  String country;
  double feelslike_c;
  double wind_kph;
  int humidity;
  double uv;
  String sunrise;
  String sunset;
  int is_day;
  List hour;

  double vis_km;
  double pressure_mb;

  Weather({
    required this.humidity,
    required this.uv,
    required this.vis_km,
    required this.condition,
    required this.temp_c,
    required this.name,
    required this.region,
    required this.country,
    required this.pressure_mb,
    required this.sunrise,
    required this.sunset,
    required this.feelslike_c,
    required this.wind_kph,
    required this.is_day,
    required this.hour,
  });

  factory Weather.formMap({required Map data}) {
    return Weather(
      condition: data['current']['condition']['text'],
      temp_c: data['current']['temp_c'],
      name: data['location']['name'],
      region: data['location']['region'],
      country: data['location']['country'],
      feelslike_c: data['current']['feelslike_c'],
      wind_kph: data['current']['wind_kph'],
      sunset: data['forecast']['forecastday'][0]['astro']['sunset'],
      is_day: data['current']['is_day'],
      humidity: data['current']['humidity'],
      uv: data['current']['uv'],
      vis_km: data['current']['vis_km'],
      hour: data['forecast']['forecastday'][0]['hour'],
      pressure_mb: data['current']['pressure_mb'],
      sunrise: data['forecast']['forecastday'][0]['astro']['sunrise'],
    );
  }
}

class SearchLocation {
  String Location;
  Weather? weather;
  TextEditingController locationController;

  SearchLocation({
    required this.Location,
    this.weather,
    required this.locationController,
  });
}

class ConnectionModel {
  String connectivityStatus;
  StreamSubscription? connectivityStream;

  ConnectionModel({
    required this.connectivityStatus,
    this.connectivityStream,
  });
}
