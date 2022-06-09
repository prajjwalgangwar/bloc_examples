
import 'package:bloc_examples/authentication/authentication_bloc.dart';
import 'package:bloc_examples/screens/Login_Signup/LoginPage.dart';
import 'package:bloc_examples/widgets/card_navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../authentication/authentication_view.dart';
import '../counter/counter_view.dart';
import '../posts/posts_view.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CardNavigationButton(name: 'Counter', color: Colors.blue.shade900, navigate: CounterPage(),),
              CardNavigationButton(name: 'Posts', color: Colors.green.shade900, navigate: const PostsPage(),),


              CardNavigationButton(name: 'Authentication', color: Colors.red.shade900, navigate: BlocProvider(
  create: (context) => AuthenticationBloc(),
  child: LoginPage(),
),),
              CardNavigationButton(name: 'Login Using Mobile', color: Colors.grey.shade900, navigate: LoginPage(),),

            ],
          ),
        ),
      ),
    );
  }

}