import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

part 'post_api_state.dart';

// final String _postUrl="https://anaajapp.com/api/user/submit_details";

class PostApiCubit extends Cubit<PostApiState> {
  PostApiCubit() : super(PostApiInitial());

  void signup(String email, String password) async {
    var client = http.Client();
    emit(LoadingState());
    try{
      var response =
          await client.post(Uri.parse('https://reqres.in/api/register'), body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        emit(SuccessState(body['token']));
      } else {
        emit(ErrorState());
      }
    }catch (e){
      Get.snackbar('Error', '', backgroundColor: Colors.red.shade700);
    }finally{
      client.close();
    }
  }

  void login(String email, String password) async {
    var client = http.Client();
    emit(LoadingState());
    try{
      var response =
      await client.post(Uri.parse('https://reqres.in/api/login'), body: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        emit(SuccessState(body['token']));
      } else {
        emit(ErrorState());
      }
    }catch (e){
      Get.snackbar('Error', '', backgroundColor: Colors.red.shade700);
    }finally{
      client.close();
    }
  }

  void submitFormData(PickedFile? image, name, email, password, gender, dob, user_status)async{
    try{
      var multipartRequest = http.MultipartRequest('POST', Uri.parse('https://anaajapp.com/api/user/submit_details'));
      multipartRequest.files.add(await http.MultipartFile.fromPath('image', image == null ? '' : image.path));
      multipartRequest.fields['name'] = name;
      multipartRequest.fields['email'] = email;
      multipartRequest.fields['password'] = password;
      multipartRequest.fields['gender'] = gender;
      multipartRequest.fields['dob'] = dob;
      multipartRequest.fields['user_status'] = user_status;

      var response = await multipartRequest.send();
      if(response.statusCode == 200){
        emit(FormSubmittedState());
      }
    }catch (e){
      emit(FormErrorState());
    }
  }

}
