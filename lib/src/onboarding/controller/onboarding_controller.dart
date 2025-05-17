import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/preference_manager.dart';

class OnBoardingController extends GetxController{
  List<Widget> tutorialList = [];
  int tutorialScreenIndex = 0;
  bool isCompleted = false;



   Future<void> skipIndexTutorial() async {
     if(tutorialList.length - 1 == tutorialScreenIndex) {
       isCompleted = true;
       await PreferenceManager.setData(
         PreferenceManager.isCompletedTutorial,
         true,
       );
     }else {
       tutorialScreenIndex = tutorialList.length - 1;
       isCompleted = false;
       await PreferenceManager.setData(
         PreferenceManager.isCompletedTutorial,
         false,
       );
     }
      update();
  }

   Future<void> changeIndexTutorial() async {
    if(tutorialList.length - 1 > tutorialScreenIndex) {
      tutorialScreenIndex += 1;
    }else{
      isCompleted = true;
      await PreferenceManager.setData(
        PreferenceManager.isCompletedTutorial,
        true,
      );
    }
    update();
  }
}