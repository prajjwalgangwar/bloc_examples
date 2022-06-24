import 'package:bloc_examples/abcd/weather/weather_bloc.dart';
import 'package:bloc_examples/models/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../abcd/weather/weather_event.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherModel weatherModel;

  const WeatherDisplay({Key? key, required this.weatherModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.all(10),
                color: Colors.blue.shade900,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      IconlyBold.editSquare,
                      color: Colors.blue.shade900,
                    ),
                    Text(
                      weatherModel.name,
                      style: TextStyle(color: Colors.blue.shade50, fontSize: 18),
                    ),
                    Icon(
                      IconlyBold.editSquare,
                      color: Colors.blue.shade900,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                color: Colors.white60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Coordinates'),
                    Text(
                        'lat: ${weatherModel.coord.lat.toString()} \nlong: ${weatherModel.coord.lon.toString()}')
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                color: Colors.white60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Weather'),
                    Text(
                        'id: ${weatherModel.weather.first.id} \nmain: ${weatherModel.weather.first.main} \ndesc: ${weatherModel.weather.first.description}')
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                color: Colors.white60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Main'),
                    Text(
                        'temperature: ${weatherModel.main.temp} \n'
                            'feels_like: ${weatherModel.main.feelsLike}\n'
                            'temp_min: ${weatherModel.main.tempMin} \n'
                            'feels_max: ${weatherModel.main.tempMax}\n'
                            'pressure: ${weatherModel.main.pressure} \n'
                            'humidity: ${weatherModel.main.humidity}\n'
                            'ground_leve: ${weatherModel.main.grndLevel} \n'
                            'sea_level: ${weatherModel.main.seaLevel}\n')
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                color: Colors.white60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Visibility'),
                    Text(
                        '${weatherModel.visibility} metres ')
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                color: Colors.white60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Wind'),
                    Text(
                        'speed: ${weatherModel.wind.speed} \ndegree: ${weatherModel.wind.deg} \ngust: ${weatherModel.wind.gust} ')
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                color: Colors.white60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Clouds'),
                    Text(
                        'all: ${weatherModel.clouds.all} ')
                  ],
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    weatherBloc.add(WeatherInitialEvent());
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
                    minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.9, 50)),
                    maximumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.9, 50)),
                  ),
                  child: Text('Search Again', style: TextStyle(color: Colors.grey.shade100),))
            ],
          ),
        ),
      ),
    );
  }
}
