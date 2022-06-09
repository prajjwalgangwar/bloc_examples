
import 'package:bloc_examples/screens/Home.dart';
import 'package:bloc_examples/utilities/app_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SignupPage extends StatefulWidget {
  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {

  bool loginButtonDisable = true;
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool agree = false;

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  void _saveFormSignUp() {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      Get.to(()=>Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.7,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider("https://cdn.dribbble.com/users/1047147/screenshots/3706662/media/f7563ab4d0e3694938892f3eb60f6907.gif") //todo
                      )),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            color: Colors.white70,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthText(authScreenName: AppConstants.signupText, authScreenDesc: AppConstants.signupPageDesc),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone_iphone_outlined,
                              color: Colors.black, size: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Colors.black45),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Enter 10 digit mobile number",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                          )),
                      validator: (value) {
                        if (value!.isEmpty ||
                            value.length < 10 ||
                            value.length > 10) {
                          return "Enter valid mobile number";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black45),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Enter Email address",
                          hintStyle: TextStyle(
                            fontSize: 14,
                          )),
                      validator: (value) {
                        if (!(value!.contains(_emailRegExp)))
                          return "Enter Valid email";
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.drive_file_rename_outline,
                            color: Colors.black,
                            size: 20,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black45),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: "Enter your name",
                          hintStyle: TextStyle(
                            fontSize: 14,
                          )),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 3)
                          return "Enter valid name";
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Wrap(
                      children: [
                        Container(
                          child: Text(
                            "On clicking below button, I accept the Terms & conditions & Privacy Policy",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w200,
                                fontSize: 12,
                                letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.width * 0.1,
                    color: Colors.red[900],
                    child: MaterialButton(
                        onPressed: () {
                          _saveFormSignUp();
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        }, //todo
                        child: Text(
                          "CLICK TO SIGNUP",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              wordSpacing: 2,
                              letterSpacing: 2),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class AuthText extends StatelessWidget{
  final String authScreenName;
  final String authScreenDesc;

  const AuthText({Key? key, required this.authScreenName, required this.authScreenDesc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        authScreenName,
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 16,
            letterSpacing: 1),
      ),
      subtitle: Text(
        authScreenDesc,
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 11,
            letterSpacing: 1),
      ),
    );
  }

}
