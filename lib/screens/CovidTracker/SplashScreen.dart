import 'dart:async';
import 'dart:math' as Math;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CovidSplashScreen extends StatefulWidget {
  const CovidSplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<CovidSplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();

  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 6), ()=> Get.to(()=> CovidTracker()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: animationController,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.all(30),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                'https://www.sozialministerium.at/.imaging/overview/dam/sozialministeriumat/Anlagen/Startseite/Piktogramme,-Icons-etc./Icon_Coronavirus.png/jcr:content.jpg'))),
                  ),
                ),
                builder: (context, child) {
                  return Transform.rotate(
                    angle: animationController.value * 2.0 * Math.pi,
                    child: Transform.translate(offset: Offset(2, 5), child: child,),
                  );
                }),
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText('Covid-19 Tracker', textStyle: TextStyle(
                    color: Colors.red.shade50,
                    fontSize: 20,
                    letterSpacing: 1,
                    wordSpacing: 1), colors: [Colors.red, Colors.white70],),
                TypewriterAnimatedText(
                  'Covid Tracker',
                  textStyle: TextStyle(
                      color: Colors.red.shade50,
                      fontSize: 20,
                      letterSpacing: 1,
                      wordSpacing: 1),
                  speed: const Duration(milliseconds: 100)
                )
              ],
                totalRepeatCount: 1,
                // pause: Duration(milliseconds: 100),

            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}
