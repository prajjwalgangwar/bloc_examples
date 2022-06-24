import 'dart:io';
import 'package:bloc_examples/widgets/api_details.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bloc_examples/abcd/post_api/DetailForm.dart';
import 'package:bloc_examples/abcd/post_api/post_api_cubit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class PostApiPage extends StatelessWidget {

  const PostApiPage({Key? key}) : super(key: key);

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
          Get.snackbar(
              'Signup Error', '', backgroundColor: Colors.red.shade700);
        }
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
              appBar: AppBar(
                title: const Text('POST METHOD'),
                bottom: const TabBar(
                  tabs: [
                    Tab(text: 'Signup',),
                    Tab(text: 'Login',),
                    Tab(text: 'Form Upload',),
                    Tab(text: 'Upload Image',),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  SignupScreen(),
                  LoginScreen(),
                  const DetailForm(),
                  UploadImageUsingPost()
                ],
              )),
        );
      },
    );
  }
}

class SignupScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            obscuringCharacter: '*',
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
              if (state is LoadingState) {
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


class UploadImageUsingPost extends StatelessWidget {

  UploadImageUsingPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostApiCubit cubit = BlocProvider.of<PostApiCubit>(context);
    return BlocListener<PostApiCubit, PostApiState>(
      listener: (context, state) {
        if(state is FormErrorState){
          Get.snackbar(state.errorMessage, '' , backgroundColor: Colors.red);
        }
        if(state is UploadedSuccessState){
          Get.snackbar(state.apiDetails.responseCode, 'Success', backgroundColor: Colors.green);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(onTap: () {
            cubit.pickImage();
          }, child: BlocBuilder<PostApiCubit, PostApiState>(
            builder: (context, state) {
              if (state is PickedImageState) {
                return Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.all(10),
                  child: Image.file(File(state.imageFile.path)),
                );
              }
              return DottedBorder(
                  dashPattern: const [3, 4],
                  strokeWidth: 0.5,
                  child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.camera_enhance_rounded,
                            size: 32,
                            color: Color(0xFF939393),
                            semanticLabel: 'Upload',
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'Upload',
                              style: TextStyle(
                                  color: Color(0xFF939393), fontSize: 12),
                            ),
                          )
                        ],
                      )));
            },
          )),
          OutlinedButton(onPressed: () {
            cubit.uploadImage();
          },
              child: BlocBuilder<PostApiCubit, PostApiState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  return const Text('Upload');
                },
              )
          ),
          BlocBuilder<PostApiCubit, PostApiState>(
            builder: (context, state) {
              if (state is UploadedSuccessState) {
                return ApiDetails(responseCode: state.apiDetails.responseCode);
              }else if(state is FormErrorState){
                return ApiDetails(responseCode: state.errorMessage);
              }
              return Divider(thickness: 4, color: Colors.red.shade200,);
            },
          )
        ],
      ),
    );
  }
}

