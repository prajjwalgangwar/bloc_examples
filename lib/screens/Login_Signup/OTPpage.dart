import 'dart:async';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:bloc_examples/screens/Home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerification extends StatefulWidget {
  final String phoneNumber;

  const OTPVerification({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  OTPVerificationState createState() => OTPVerificationState();
}

class OTPVerificationState extends State<OTPVerification> {
  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  static bool resendOTP = true;
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.7,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: CachedNetworkImageProvider("https://i.pinimg.com/originals/9e/6c/de/9e6cde2657da66499330770fbb8d8bfc.gif") //todo
                      )),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    "OTP VERIFICATION",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        letterSpacing: 2),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                        text: "Enter the code sent to ",
                        children: [
                          TextSpan(
                              text: "${widget.phoneNumber}",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10)),
                        ],
                        style: const TextStyle(color: Colors.black54, fontSize: 12)),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Form(
                    key: formKey,
                    child: PinCodeTextField(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      appContext: context,
                      textStyle: const TextStyle(
                        fontSize: 12,
                      ),
                      pastedTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                      length: 4,
                      blinkWhenObscuring: true,
                      animationType: AnimationType.slide,
                      validator: (v) {
                        return null;
                      },
                      //todo
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.circle,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          activeFillColor: Colors.green[50],
                          inactiveColor: Colors.red[900],
                          inactiveFillColor: Colors.white,
                          selectedColor: Colors.red[900],
                          activeColor: Colors.green[900],
                          selectedFillColor: Colors.red[50]),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      // onTap: () {
                      //   print("Pressed");
                      // },
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        return true;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    hasError ? "*Enter valid OTP" : "",
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                     const Text(
                        "Didn't receive the code? ",
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      ),
                      ArgonTimerButton(
                        initialTimer: 20,
                        height: 20,
                        width: 90,
                        minWidth: 50,
                        highlightColor: Colors.amber,
                        highlightElevation: 0,
                        roundLoadingShape: false,
                        onTap: (startTimer, btnState) {
                          if (btnState == ButtonState.Idle) {
                            startTimer(20);
                          }
                        },
                        loader: (timeLeft) {
                          return Text(
                            "Wait | $timeLeft",
                            style: TextStyle(
                                color: Colors.red[900],
                                fontSize: 12,
                                fontWeight: FontWeight.w100),
                          );
                        },
                        borderRadius: 5.0,
                        color: Colors.white,
                        elevation: 0,
                        // initialTimer: 10,
                        child: Text(
                          "Resend OTP",
                          style: TextStyle(
                              color: Colors.green.shade900,
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                        // borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.red[900],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      formKey.currentState!.validate();
                      // conditions for validating
                      if (currentText.length != 4 || currentText != "1234") {
                        errorController!.add(ErrorAnimationType
                            .shake); // Triggering error shake animation
                        setState(() => hasError = true);
                      } else {
                        setState(
                          () {
                            hasError = false;
                            snackBar("OTP Verified!!");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home()));
                          },
                        );
                      }
                    },
                    child: Center(
                        child: Text(
                      "VERIFY".toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
