import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc_examples/abcd/weather/weather_bloc.dart';
import 'package:bloc_examples/abcd/weather/weather_state.dart';
import 'package:bloc_examples/screens/WeatherScreen/WeatherDisplay.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../abcd/weather/weather_event.dart';

class WeatherSearchScreen extends StatefulWidget {
  const WeatherSearchScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<WeatherSearchScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();

  final TextEditingController _searchFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WeatherBloc weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        if (state is WeatherLoadedState) {
          Get.snackbar('Success: ', 'WeatherScreen Loaded',
              backgroundColor: Colors.blue.shade300);
        }
        if(state is WeatherErrorState){
          Get.snackbar('Error: ${state.errorMessage} ', 'Error Loading WeatherScreen',
              backgroundColor: Colors.red.shade300);
        }
        if(state is WeatherInitialState){
          _searchFieldController.clear();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (_, state) {
            if (state is WeatherLoadedState) {
              return WeatherDisplay(
                weatherModel: state.weatherModel,
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                    animation: animationController,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: const EdgeInsets.all(30),
                        padding: const EdgeInsets.all(30),
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    'https://cdn.dribbble.com/users/1107691/screenshots/3902329/de-earth.gif'))),
                      ),
                    ),
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(2, 5),
                        child: child,
                      );
                    }),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText('Search For WeatherScreen',
                        textStyle: TextStyle(
                            color: Colors.red.shade50,
                            fontSize: 20,
                            letterSpacing: 1,
                            wordSpacing: 1),
                        speed: const Duration(milliseconds: 100))
                  ],
                  totalRepeatCount: 1,
                  // pause: Duration(milliseconds: 100),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 80, bottom: 10),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                      controller: _searchFieldController,
                      maxLength: 300,
                      cursorHeight: 20,
                      cursorColor: Colors.green.shade900,
                      style: TextStyle(
                          color: Colors.grey.shade200,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          IconlyBroken.search,
                          color: Colors.white60,
                          size: 19,
                        ),
                        hintText: 'City Name',
                        hintStyle: const TextStyle(
                            color: Colors.white60, fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.blue.shade700,
                            width: 0.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.green.shade700,
                            width: 0.5,
                          ),
                        ),
                      )),
                ),
                OutlinedButton(onPressed: () {
                  if(_searchFieldController.text != ''){
                      weatherBloc.add(FetchWeatherEvent(
                          cityName: _searchFieldController.text));
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue.shade900),
                    minimumSize: MaterialStateProperty.all(const Size(300, 50)),
                    maximumSize: MaterialStateProperty.all(const Size(300, 50)),
                  ), child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherLoadingState) {
                      return SizedBox(
                        width: 20,
                        height: 20,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue.shade100,
                            strokeWidth: 3,
                          ),
                        ),
                      );
                    }
                    return Text('Search', style: TextStyle(color: Colors.grey.shade100, fontWeight: FontWeight.w400, letterSpacing: 2),);
                  },
                ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    _searchFieldController.clear();
  }
}
