import 'package:bloc_examples/abcd/authentication/authentication_bloc.dart';
import 'package:bloc_examples/abcd/authentication/authentication_event.dart';
import 'package:bloc_examples/abcd/orderdetail_cubit/OrderDetailPage.dart';
import 'package:bloc_examples/abcd/orderdetail_cubit/order_detail_cubit.dart';
import 'package:bloc_examples/abcd/post_api/post_api_cubit.dart';
import 'package:bloc_examples/abcd/weather/WeatherRepository.dart';
import 'package:bloc_examples/abcd/weather/weather_bloc.dart';
import 'package:bloc_examples/screens/CovidTracker/CovidTracker.dart';
import 'package:bloc_examples/screens/CovidTracker/SplashScreen.dart';
import 'package:bloc_examples/screens/Login_Signup/LoginPage.dart';
import 'package:bloc_examples/screens/PostApiPage.dart';
import 'package:bloc_examples/widgets/card_navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../abcd/counter_cubit/counter_view.dart';
import '../abcd/posts/posts_view.dart';
import 'Weather/WeatherSearchScreen.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardNavigationButton(
                name: 'Counter',
                color: Colors.blue.shade900,
                navigate: CounterPage(),
              ),
              CardNavigationButton(
                name: 'Posts',
                color: Colors.green.shade900,
                navigate: const PostsPage(),
              ),
              CardNavigationButton(
                name: 'Authentication',
                color: Colors.red.shade900,
                navigate: BlocProvider(
                  create: (context) =>
                  AuthenticationBloc()
                    ..add(AuthenticationInitialEvent()),
                  child: LoginPage(),
                ),
              ),
              CardNavigationButton(
                name: 'Post APIs Examples',
                color: Colors.grey.shade900,
                navigate: BlocProvider(
                  create: (context) => PostApiCubit(),
                  child: PostApiPage(),
                ),
              ),
              CardNavigationButton(
                name: 'Order List Using Cubit',
                color: Colors.amber.shade900,
                navigate: BlocProvider(
                  create: (context) => OrderDetailCubit(),
                  child: const OrderDetail(),
                ),
              ),
              CardNavigationButton(
                name: 'Covid Tracker',
                color: Colors.lightGreen.shade900,
                navigate: const CovidSplashScreen(),
              ),
              CardNavigationButton(
                name: 'Weather Search',
                color: Colors.teal.shade900,
                navigate: BlocProvider(
                  create: (context) => WeatherBloc(weatherRepository: WeatherRepository()),
                  child: const WeatherSearchScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
