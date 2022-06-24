import 'dart:core';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:bloc_examples/abcd/post_api/post_api_cubit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';


class DetailForm extends StatefulWidget {
  const DetailForm({Key? key}) : super(key: key);

  @override
  DetailFormState createState() => DetailFormState();
}

class DetailFormState extends State<DetailForm> with InputValidationMixin {
  TextEditingController passwordController = TextEditingController();
  TextEditingController cpController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String user_status = 'active';
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? gender;

  String dob = '';
  PickedFile? image;

  final _formKey = GlobalKey<FormState>();
  var val = -1;

  @override
  Widget build(BuildContext context) {
    print('Form Building');
    PostApiCubit cubit = BlocProvider.of<PostApiCubit>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.transparent,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: BlocListener<PostApiCubit, PostApiState>(
            listener: (context, state) {
              if (state is FormSubmittedState) {
                Get.snackbar('Form Submitted Successfully', 'status code: 200',
                    backgroundColor: Colors.green.shade500);
              }
              if (state is FormErrorState) {
                Get.snackbar(state.errorMessage, '',
                    backgroundColor: Colors.red.shade300);
              }
            },
            child: Column(
              children: [
                PickImageField(cubit),
                generalFields(nameController, name, 'Full Name', Icons.person_outline, false),
                generalFields(emailController, email, 'Email ID', Icons.email_outlined, false),
                generalFields(passwordController, password, 'Password', Icons.remove_red_eye_sharp, false),
                generalFields(cpController, confirmPassword, 'Confirm Password', Icons.remove_red_eye_sharp, true),
                genderField(),
                dateField(cubit),
                statusField(),
                Container(
                  margin: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF1D2677),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(color: Colors.transparent))),
                    onPressed: () async {
                      cubit.submitFormData(image, name, email, password, gender,
                          dob, user_status);
                      print('state in formPage : ${cubit.state}');
                    },
                    child: BlocBuilder<PostApiCubit, PostApiState>(
                      builder: (context, state) {
                        if (state is FormLoadingState) {
                          return const Align(
                              alignment: Alignment.bottomCenter,
                              child: LinearProgressIndicator());
                        }
                        return const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget PickImageField(cubit){
    return InkWell(onTap: () {
      cubit.pickImage();
    }, child: BlocBuilder<PostApiCubit, PostApiState>(
      builder: (context, state) {
        if (state is PickedImageState) {
          image = state.imageFile;
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
    ));
  }

  Widget generalFields(controller, var fieldValue, String hint, IconData iconData, bool isObscure ){
    return Container(
      margin:
      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        obscuringCharacter: '*',
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
        onChanged: (value) {
          fieldValue = value;
        },

        decoration: InputDecoration(
          focusColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
                color: Color(0xFF939393), width: 0.5),
          ),
          suffixIcon: Icon(
            iconData,
            color: const Color(0xFF939393),
            size: 19,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color(0xFFE45171), width: 0.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.grey,
          hintText: "$hint",
          hintStyle: const TextStyle(
            color: Color(0xFF939393),
            fontSize: 14,
            fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget genderField(){
    return Container(
      height: 55,
      margin:
      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: DropdownButtonFormField(
          hint: const Text(
            'Select Gender',
            style:
            TextStyle(color: Color(0xFF939393), fontSize: 14),
          ),
          itemHeight: 48,
          dropdownColor: Colors.white,
          value: gender,
          decoration: InputDecoration(
            focusColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                  color: Color(0xFF939393), width: 0.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color(0xFFE45171), width: 0.5),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onChanged: (String? value) {
            setState(() {
              gender = value!;
            });
          },
          items: const [
            DropdownMenuItem(
                value: "Male",
                child: Text(
                  "Male",
                  style: TextStyle(fontSize: 14),
                )),
            DropdownMenuItem(
                value: "Female",
                child: Text(
                  "Female",
                  style: TextStyle(fontSize: 14),
                )),
          ]),
    );
  }

  Widget dateField(cubit){
    return Container(
      margin:
      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: InkWell(
        onTap: () {
          cubit.selectDate(context);
        },
        child: IgnorePointer(
          child: BlocBuilder<PostApiCubit, PostApiState>(
            builder: (context, state) {
              if(state is DatePickedState){
                dob = state.dob;
                return TextFormField(
                  controller: dobController,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  onChanged: (value) {},
                  validator: (value) {},
                  decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        cubit.selectDate(context);
                        print('select date');
                      },
                      child: const Icon(
                        Icons.calendar_today,
                        color: Color(0xFF939393),
                        size: 19,
                      ),
                    ),
                    focusColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                          color: Color(0xFF939393), width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xFFE45171), width: 0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.grey,
                    hintText: state.dob.isEmpty ? "Date of Birth" : state.dob,
                    hintStyle: const TextStyle(
                      color: Color(0xFF939393),
                      fontSize: 14,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }
              return TextFormField(
                controller: dobController,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                onChanged: (value) {},
                validator: (value) {},
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      cubit.selectDate(context);
                      print('select date');
                    },
                    child: const Icon(
                      Icons.calendar_today,
                      color: Color(0xFF939393),
                      size: 19,
                    ),
                  ),
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                        color: Color(0xFF939393), width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color(0xFFE45171), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "Date of Birth",
                  hintStyle: const TextStyle(
                    color: Color(0xFF939393),
                    fontSize: 14,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );

            },
          ),
        ),
      ),
    );
  }

  Widget statusField(){
    return Row(
      children: [
        Radio(
          value: 1,
          groupValue: val,
          onChanged: (value) {
            setState(() {
              val = value as int;
              user_status = 'Active';
            });
          },
          activeColor: const Color(0xFFE45171),
        ),
        const Text('Active'),
        const SizedBox(
          width: 40,
        ),
        Radio(
          toggleable: true,
          value: 2,
          groupValue: val,
          onChanged: (value) {
            setState(() {
              val = value as int;
              user_status = 'Suspended';
            });
          },
          activeColor: const Color(0xFFE45171),
        ),
        const Text('Suspended')
      ],
    );
  }
}

mixin InputValidationMixin {
  bool isPasswordValid(password) => password.length > 6 ? true : false;

  bool isNameValid(name) => name.length > 2 ? true : false;

  bool isConfirmPasswordValid(password) => password.length > 6 ? true : false;

  bool isEmailValid(value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
}
