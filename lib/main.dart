
import 'dart:convert';

import 'package:bloc_examples/abcd/weather/WeatherRepository.dart';
import 'package:bloc_examples/models/weather_model.dart';
import 'package:bloc_examples/screens/CovidTracker/CovidTracker.dart';
import 'package:bloc_examples/screens/CovidTracker/SplashScreen.dart';
import 'package:bloc_examples/screens/Home.dart';
import 'package:bloc_examples/screens/Weather/WeatherSearchScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;


void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  // debugRepaintRainbowEnabled = true;
  BlocOverrides.runZoned(
        () => runApp(MyApp()),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home()
    );
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition( bloc, transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}
