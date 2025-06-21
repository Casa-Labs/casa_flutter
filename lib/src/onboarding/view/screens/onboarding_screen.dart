import 'package:casaflutter/src/onboarding/controller/onboarding_controller.dart';
import 'package:casaflutter/src/onboarding/view/widget/swipe_tutorial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/string_constant.dart';

class OnboardingScreen extends StatefulWidget {
  final bool? isFirstTime;
  const OnboardingScreen({super.key, this.isFirstTime});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final OnBoardingController onBoardingCtrl = Get.put(OnBoardingController());
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _initializeTutorialList();
      _isInitialized = true;
    }
  }

  void _initializeTutorialList() {
    onBoardingCtrl.tutorialList = [
      SwipeTutorial(
        image: ImageConstants.tutorialPenguinSeven,
        alignment: Alignment.topCenter,
        text:
            "Welcome to CASA! \nHere is a small tutorial to guide you through.",
        onTap: onBoardingCtrl.changeIndexTutorial,
        bottom: 0,
        bottomImage: 0,
        top: 50,
        topImage: 30,
        onSkip: onBoardingCtrl.skipIndexTutorial,
      ),
      SwipeTutorial(
          image: ImageConstants.tutorialPenguinTwo,
          alignment: Alignment.topCenter,
          text: "Swipe right on the clothes you like.",
          onTap: onBoardingCtrl.changeIndexTutorial,
          bottom: 0,
          bottomImage: 50,
          top: 150,
          topImage: 50,
          onSkip: onBoardingCtrl.skipIndexTutorial),
      SwipeTutorial(
          image: ImageConstants.tutorialPenguinThree,
          alignment: Alignment.topCenter,
          text:
              "Swipe left on the clothes you don't like! We will learn the rest.",
          onTap: onBoardingCtrl.changeIndexTutorial,
          bottom: 0,
          bottomImage: 0,
          top: 180,
          topImage: 50,
          onSkip: onBoardingCtrl.skipIndexTutorial),
      SwipeTutorial(
          image: ImageConstants.tutorialPenguinFour,
          alignment: Alignment.topCenter,
          text: "Click the back button to go to the previous item.",
          onTap: onBoardingCtrl.changeIndexTutorial,
          bottom: 10,
          bottomImage: 80,
          top: 70,
          topImage: 0,
          onSkip: onBoardingCtrl.skipIndexTutorial),
      SwipeTutorial(
          image: ImageConstants.tutorialPenguinFive,
          alignment: Alignment.bottomCenter,
          text: "Click on the logo to visit the store.",
          onTap: onBoardingCtrl.changeIndexTutorial,
          bottom: 170,
          bottomImage: 90,
          top: 0,
          topImage: 0,
          onSkip: onBoardingCtrl.skipIndexTutorial),
      SwipeTutorial(
          image: ImageConstants.tutorialPenguinSix,
          alignment: Alignment.bottomCenter,
          text:
              "Use the add to cart, save to closet and buy now for instant checkout.",
          onTap: onBoardingCtrl.changeIndexTutorial,
          bottom: 240,
          bottomImage: 100,
          top: 0,
          topImage: 0,
          onSkip: onBoardingCtrl.skipIndexTutorial),
      SwipeTutorial(
          image: ImageConstants.tutorialPenguinSeven,
          alignment: Alignment.topCenter,
          text:
              "Steve and Derek the founders of CASA welcome you. We're cooking up our next move to get unique offers and discounts for you!",
          onTap: onBoardingCtrl.changeIndexTutorial,
          bottom: 0,
          bottomImage: 0,
          top: 170,
          topImage: 20,
          onSkip: onBoardingCtrl.skipIndexTutorial),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _initializeTutorialList();
    return GetBuilder<OnBoardingController>(builder: (logic) {
      if (!logic.isCompleted && (widget.isFirstTime ?? false)) {
        return logic.tutorialList[logic.tutorialScreenIndex];
      } else {
        return SizedBox();
      }
    });
  }
}
