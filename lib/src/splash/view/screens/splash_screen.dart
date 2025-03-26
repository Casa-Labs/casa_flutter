import 'package:casaflutterapp/utils/string_constant.dart';
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
        margin: EdgeInsets.all(60),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: splashCtrl.netImage() != ""
                ? NetworkImage(splashCtrl.netImage())
                : AssetImage(ImageConstants.splashBackground),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
