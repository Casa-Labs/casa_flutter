import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController{
  List<Widget> tutorialList = [];
  int tutorialScreenIndex = 0;
  bool isCompleted = false;



   void skipIndexTutorial() {
     if(tutorialList.length - 1 == tutorialScreenIndex) {
       isCompleted = true;
     }else {
       tutorialScreenIndex = tutorialList.length - 1;
       isCompleted = false;
     }
      update();
  }

   void changeIndexTutorial() {
    if(tutorialList.length - 1 > tutorialScreenIndex) {
      tutorialScreenIndex += 1;
    }else{
      isCompleted = true;
    }
    update();
  }
}