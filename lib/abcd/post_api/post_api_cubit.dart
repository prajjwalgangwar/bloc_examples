import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_examples/widgets/api_details.dart';
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
    try {
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
    } catch (e) {
      Get.snackbar('Error', '', backgroundColor: Colors.red.shade700);
    } finally {
      client.close();
    }
  }

  void login(String email, String password) async {
    var client = http.Client();
    emit(LoadingState());
    try {
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
    } catch (e) {
      Get.snackbar('Error', '', backgroundColor: Colors.red.shade700);
    } finally {
      client.close();
    }
  }

  void submitFormData(PickedFile? image, name, email, password, gender, dob,
      user_status) async {
    emit(FormLoadingState());
    try {
      var multipartRequest = http.MultipartRequest(
          'POST', Uri.parse('https://anaajapp.com/api/user/submit_details'));
      multipartRequest.files.add(await http.MultipartFile.fromPath(
          'image', image == null ? '' : image.path));
      multipartRequest.fields['name'] = name;
      multipartRequest.fields['email'] = email;
      multipartRequest.fields['password'] = password;
      multipartRequest.fields['gender'] = gender;
      multipartRequest.fields['dob'] = dob;
      multipartRequest.fields['user_status'] = user_status;

      var response = await multipartRequest.send();
      if (response.statusCode == 200) {
        // print('response after submitting: ${response.statusCode}');
        emit(FormSubmittedState());
        // print('response after submitting: ${state}');
      }
    } catch (e) {
      emit(FormErrorState(e.toString()));
    }
  }

  PickedFile? imageFile;

  void pickImage() async {
    try {
      imageFile = await ImagePicker.platform.pickImage(
        source: ImageSource.gallery,
      );
      if (imageFile != null) {
        emit(PickedImageState(imageFile!));
      }
    } catch (e) {
      emit(FormErrorState(e.toString()));
    }
  }

  void uploadImage() async {
    emit(LoadingState());
    try {
      final imageFile = this.imageFile;
      if (imageFile != null) {
        var stream = http.ByteStream(File(imageFile.path).openRead());
        stream.cast();
        int length = await File(imageFile.path).length();
        var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
        var request = http.MultipartRequest('POST', url);
        request.fields['userId'] = 'Product Title';
        request.fields['id'] = 'Product Title';
        request.fields['title'] = 'Product Title';
        request.fields['body'] = 'Product Title';
        var multipartImage = http.MultipartFile('image', stream, length);
        request.files.add(multipartImage);
        var response = await request.send();
        print(response.statusCode);

        if (response.statusCode == 200) {
          print('13');
          emit(UploadedSuccessState(ApiDetails(
            responseCode: response.statusCode.toString(),
          )));

        }else {
          emit(FormErrorState(response.statusCode.toString()));
        }
        print(state);
      }
    } catch (e) {
      emit(FormErrorState(e.toString()));
    }
  }

  void selectDate(BuildContext context) async {
    emit(LoadingState());
    DateTime currentDate = DateTime.now();
    try {
      final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: currentDate,
          firstDate: DateTime(1905),
          lastDate: DateTime(2050));
      if (pickedDate != null && pickedDate != currentDate) {
        String dob = '';
        dob = '';
        dob +=
            '${currentDate.day <= 9 ? '0${currentDate.day}' : currentDate.day.toString()}/';
        dob +=
            '${currentDate.month <= 9 ? '0${currentDate.month}' : currentDate.month.toString()}/';
        dob += currentDate.year.toString();
        print('dob ata temp is $dob');
        currentDate = pickedDate;
        emit(DatePickedState(dob));
      }
    } catch (e) {
      emit(FormErrorState(e.toString()));
    }
  }
}
