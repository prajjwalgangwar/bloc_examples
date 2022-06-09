import 'package:bloc_examples/authentication/authentication_bloc.dart';
import 'package:bloc_examples/authentication/authentication_event.dart';
import 'package:bloc_examples/authentication/authentication_state.dart';
import 'package:bloc_examples/screens/Login_Signup/SignupPage.dart';
import 'package:bloc_examples/utilities/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'OTPpage.dart';


class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final phoneController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthenticationBloc>(context);
    print("${bloc.state}");
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
                      image: NetworkImage(
                          "https://i.pinimg.com/originals/fe/93/b0/fe93b053043276b38386e625295af6cc.gif") //todo
                      )),
            ),
          ),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AuthText(
                        authScreenName: AppConstants.loginText,
                        authScreenDesc: AppConstants.loginPageDesc),
                    const SizedBox(
                      height: 1,
                    ),
                    (state is AuthenticationErrorState)
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                margin:
                                    const EdgeInsets.only(left: 12, bottom: 5),
                                child: Text(
                                  'Enter Valid Phone Number',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.red.shade900),
                                  textAlign: TextAlign.start,
                                )))
                        : Container(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: phoneController,
                            cursorColor: Colors.red[900],
                            keyboardType: TextInputType.phone,
                            // onFieldSubmitted: (value){
                            //   phoneNumber = value;
                            // },
                            onChanged: (value) {
                              bloc.add(AuthenticationErrorEvent(
                                  phoneNumberValue: phoneController.text));
                            },
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.phone_iphone_outlined,
                                  color: Colors.black87,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.black87),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                hintText: "Enter 10 digit mobile number",
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                )),
                          )),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: state is AuthenticationValidState ? true : false,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.89,
                        child: Wrap(
                          children: const [
                            Text(
                              "On clicking below button, I accept the Terms & conditions & Privacy Policy",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                  letterSpacing: 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocListener<AuthenticationBloc, AuthenticationState>(
                      listener: (context, state) {
                        if(state is AuthenticatedUserState){
                          Get.snackbar('Authenticated User', 'success');
                          Get.to(()=> OTPVerification(phoneNumber: phoneController.text));
                        }else if(state is NewUserState){
                          Get.snackbar('New User', 'success');
                          Get.to(()=> SignupPage());
                        }
                      },
                      child: Visibility(
                        visible:
                            (state is AuthenticationValidState) ? true : false,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.width * 0.1,
                          color: Colors.red.shade900,
                          child: MaterialButton(
                              onPressed: () {
                                // bloc.
                                if (state is AuthenticationValidState) {
                                  bloc.add(AuthenticationSuccessEvent(
                                    phoneNumber: phoneController.text,
                                  ));
                                }
                                print(bloc.state);
                                if (state is AuthenticatedUserState) {
                                  Get.snackbar('OTP Page', 'message');
                                } else if (state is NewUserState) {
                                  Get.snackbar('Signup Page', 'message');
                                }
                              }, //todo
                              child: const Text(
                                "CLICK TO LOGIN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    wordSpacing: 2,
                                    letterSpacing: 2),
                              )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
