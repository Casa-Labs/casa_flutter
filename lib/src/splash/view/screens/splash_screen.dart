import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final splashCtrl = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(splashCtrl.splashLogos
                .firstWhere((logo) => logo.logoId == splashCtrl.dayIndex())
                .logo),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
