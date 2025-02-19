import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ProfileController extends GetxController{

  // ========= CONTROLLERS ========= //



  // ========= VARIABLES ========= //


  bool isSelectApple = Platform.isIOS ? true : false;
  bool isSelectPlay = Platform.isAndroid ? true : false;

  // ========== STATES ========== //

  // ========== UI FUNCTIONS ========== //


  selectApple(){
    isSelectPlay = false;
    isSelectApple = true;
    update();
  }

  selectPlay(){
    isSelectApple = false;
    isSelectPlay = true;
    update();
  }

  void shareApp(String link,String appName) {
    final message =
        isSelectPlay ? 'Android: $link' : 'iOS: $link';

    Share.share(message, subject: 'Check out $appName');
  }

// ========== APIs FUNCTIONS ========== //

}