import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:bloc_examples/models/weather_model.dart';
import 'WeatherRepository.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitialState()){
    on<WeatherInitialEvent>(initial);
    on<FetchWeatherEvent>(fetchWeatherEvent);
  }

  void initial(WeatherInitialEvent event, Emitter<WeatherState> emit) async{
    emit(WeatherInitialState());
  }

  void fetchWeatherEvent(FetchWeatherEvent event, Emitter<WeatherState> emit) async{
    emit(WeatherLoadingState());
    try{
      WeatherModel? weatherModel = await weatherRepository.getWeather(event.cityName);
      if(weatherModel!=null){
        if (weatherModel.cod == 200) {
          emit(WeatherLoadedState(weatherModel: weatherModel));
        }
      }
      else {
        emit(WeatherErrorState('City not found'));
      }
    }catch (e){
      emit(WeatherErrorState(e.toString()));
    }
  }
}


