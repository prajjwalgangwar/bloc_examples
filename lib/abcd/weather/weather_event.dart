import 'package:flutter/material.dart';

abstract class WeatherEvent {}

class WeatherInitialEvent extends WeatherEvent {
}

class FetchWeatherEvent extends WeatherEvent {
  final String cityName;
  FetchWeatherEvent({required this.cityName});
}

class ResetEvent extends WeatherEvent {}