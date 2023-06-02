import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'data_screen.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splashscreen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              const Text("Intern Test",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 200,
                  height: 200,
                  child: Image.asset("assets/images/logo.png", fit: BoxFit.cover,),
                ),
              ),
              const Text("By Agnesty",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))
            ],
          ),
        ),
      ),
      nextScreen: DataScreen(),
      duration: 2000,
      splashIconSize: 350,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
