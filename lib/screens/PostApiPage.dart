import 'package:bloc_examples/abcd/post_api/DetailForm.dart';
import 'package:bloc_examples/abcd/post_api/post_api_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class PostApiPage extends StatelessWidget {

  // TabController tabController = TabController(length: 2, vsync: this);
  PostApiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostApiCubit, PostApiState>(
      listener: (context, state) {
        if (state is SuccessState) {
          Get.snackbar('Successful', 'token: ${state.token}',
              backgroundColor: Colors.green.shade900,
              colorText: Colors.green.shade50);
        }
        if (state is ErrorState) {
          Get.snackbar('Signup Error', '', backgroundColor: Colors.red.shade700);
        }
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
              appBar: AppBar(
                title: const Text('POST METHOD'),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Signup',),
                    Tab(text: 'Login',),
                    Tab(text: 'Image Upload',),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  SignupScreen(),
                  LoginScreen(),
                  const DetailForm(),
                ],
              )),
        );
      },
    );
  }
}

class SignupScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostApiCubit cubit = BlocProvider.of<PostApiCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
                hintText: 'Email'
            ),
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            obscuringCharacter: '#',
            decoration: const InputDecoration(
              hintText: 'Password',

            ),
          ),
          BlocBuilder<PostApiCubit, PostApiState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator(),);
              }
              return OutlinedButton(onPressed: () {
                cubit.signup(emailController.text, passwordController.text);
              }, child: const Text('Signup'));
            },
          )
        ],
      ),
    );
  }

}


class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostApiCubit cubit = BlocProvider.of<PostApiCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
                hintText: 'Email'
            ),
          ),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            obscuringCharacter: '*',
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
          ),
          BlocBuilder<PostApiCubit, PostApiState>(
            builder: (context, state) {
              if(state is LoadingState){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return OutlinedButton(onPressed: () {
                cubit.login(emailController.text, passwordController.text);
              }, child: const Text('Login'));
            },
          )
        ],
      ),
    );
  }
}
