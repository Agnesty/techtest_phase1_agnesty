import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techtest_phase1_agnesty/routes/app_pages.dart';

import '../controllers/auth_ctr.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        Future.delayed(const Duration(seconds: 2), () {
          if (controller.user.value == null) {
            Get.offAllNamed(Routes.LOGIN);
          } else {
            Get.offAllNamed(Routes.BOTTOMNAV);
          }
        });

        return Scaffold(
          body: Center(
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.amber[300],
                shape: BoxShape.circle,
                border: Border.all(width: 2, color: Colors.black),
              ),
              child: const Center(
                child: Text(
                  'LeptopIn',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
