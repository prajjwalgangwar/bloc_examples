import 'dart:io';
import 'package:bloc_examples/abcd/post_api/post_api_cubit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

import 'package:image_picker/image_picker.dart';

class DetailForm extends StatefulWidget{
  const DetailForm({Key? key}) : super(key: key);

  @override
  DetailFormState createState() => DetailFormState();
}
class DetailFormState extends State<DetailForm> with InputValidationMixin {

  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1905),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        dob='';
        dob+='${currentDate.day<=9 ? '0${currentDate.day}': currentDate.day.toString()}/';
        dob+='${currentDate.month<=9 ? '0${currentDate.month}': currentDate.month.toString()}/';
        dob+=currentDate.year.toString();
        print('dob ata temp is $dob');
        currentDate = pickedDate;
      });
    }
  }

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
  String dob='';
  PickedFile? image;

  final _formKey = GlobalKey<FormState>();
  var val = -1;

  @override
  Widget build(BuildContext context) {
    PostApiCubit cubit = BlocProvider.of<PostApiCubit>(context);
    return Container(
      padding:  const EdgeInsets.all(10),
      color: Colors.transparent,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            InkWell(
                onTap: ()async{
                  await ImagePicker.platform.pickImage(source: ImageSource.gallery).then((value) => image=value);
                  setState(() {

                  });
                },
                child: image == null ? DottedBorder(
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
                          children:  const [
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
                                style: TextStyle(color: Color(0xFF939393), fontSize: 12),
                              ),
                            )
                          ],
                        ))) : Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  margin:  const EdgeInsets.all(10),
                  child: Image.file(File(image!.path)),
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(5),
                  //     image: DecorationImage(
                  //         image: ima,
                  //     )
                  // ),
                )
            ),
            Container(
              margin: const  EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: TextFormField(
                controller: nameController,
                style:  const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                onChanged: (value) {
                  name = value;
                },
                validator: (value){
                  if(isNameValid(value)) return null;
                  return 'Enter Valid Name';
                },
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                    const BorderSide(color: Color(0xFF939393), width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Color(0xFFE45171), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "Full Name",
                  hintStyle:  const TextStyle(
                    color: Color(0xFF939393),
                    fontSize: 14,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: TextFormField(
                // inputFormatters : [
                //   FilteringTextInputFormatter.allow(RegExp(r'[a-z]')),
                // ],
                controller: emailController,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  isEmailValid(value) == true ? 'Enter Valid Email' : null;
                  return null;
                },
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                    const BorderSide(color: Color(0xFF939393), width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Color(0xFFE45171), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "Email ID",
                  hintStyle: const TextStyle(
                    color: Color(0xFF939393),
                    fontSize: 14,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),


                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: TextFormField(
                controller: passwordController,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (isPasswordValid(value)) return null;
                  return 'Password must be 6+ characters';
                },
                cursorHeight: 21,
                cursorColor: const Color(0xFF111111),
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.remove_red_eye_outlined,
                    color: Color(0xFF939393),
                    size: 19,
                  ),
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                    const BorderSide(color: Color(0xFF939393), width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Color(0xFFE45171), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "Create Password",
                  hintStyle: const TextStyle(
                    color: Color(0xFF939393),
                    fontSize: 14,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: TextFormField(
                controller: cpController,
                obscureText: true,
                obscuringCharacter: '*',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                onChanged: (value) {
                  confirmPassword = value;
                },
                validator: (value){
                  if( value == passwordController.text ) return null;
                  return 'password don\'t match';
                },
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.visibility_off_outlined,
                    color: Color(0xFF939393),
                    size: 19,
                  ),
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                    const BorderSide(color: Color(0xFF939393), width: 0.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                    const BorderSide(color: Color(0xFFE45171), width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  hintText: "Confirm Password",
                  hintStyle: const TextStyle(
                    color: Color(0xFF939393),
                    fontSize: 14,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Container(
              height: 55,
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: DropdownButtonFormField(
                  hint: const Text('Select Gender', style: TextStyle(color: Color(0xFF939393), fontSize: 14),),
                  itemHeight: 48,
                  dropdownColor: Colors.white,
                  value: gender,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                      const BorderSide(color: Color(0xFF939393), width: 0.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(color: Color(0xFFE45171), width: 0.5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(value: "Male", child: Text("Male", style: TextStyle(fontSize: 14),)),
                    DropdownMenuItem(value: "Female", child: Text("Female",  style: TextStyle(fontSize: 14),)),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: InkWell(
                onTap: (){
                  _selectDate(context);
                },
                child: IgnorePointer(
                  child: TextFormField(
                    controller: dobController,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    onChanged: (value) {
                    },
                    validator: (value){
                    },
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: (){
                          _selectDate(context);
                          // print('select date');
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
                        borderSide:
                        const BorderSide(color: Color(0xFF939393), width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Color(0xFFE45171), width: 0.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Colors.grey,
                      hintText: dob.isEmpty ?"Date of Birth":dob,
                      hintStyle: const TextStyle(
                        color: Color(0xFF939393),
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
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
                const SizedBox(width: 40,),
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
            ),
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

                  cubit.submitFormData(image, name, email, password, gender, dob, user_status);

                  // print('status code = ${statusCode.runtimeType}');
                  // statusCode == 200 ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved'))) : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nahi Karunga Save')));
                  // print('data of form: $name $email $password $confirmPassword $user_status ${currentDate.day}/${currentDate.month}/${currentDate.year}');
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

mixin InputValidationMixin{
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