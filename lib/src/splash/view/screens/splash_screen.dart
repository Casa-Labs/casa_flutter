import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashCtrl = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    splashCtrl.initSplashLogo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(splashCtrl.currentLogo),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
