import 'package:bloc_examples/models/weather_model.dart';
import 'package:flutter/cupertino.dart';

// enum WeatherStatus { initial, fetched, fetching, error}
abstract class WeatherState {}

class WeatherInitialState extends WeatherState{
}

class WeatherLoadingState extends WeatherState{}

class WeatherLoadedState extends WeatherState{
  final WeatherModel weatherModel;

  WeatherLoadedState({required this.weatherModel});
}

class WeatherErrorState extends WeatherState{
  final String errorMessage;

  WeatherErrorState(this.errorMessage);
}


