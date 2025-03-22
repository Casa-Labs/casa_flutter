import 'package:casaflutter/src/onboarding/controller/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/filter_row.dart';
import '../widget/position_tutorial.dart';
import '../widget/swipe_tutorial.dart';

class TutorialScreen extends StatefulWidget {
  final int index;
  final Function() onTap;

  const TutorialScreen({super.key, required this.index, required this.onTap});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final OnBoardingController homeController = Get.put(OnBoardingController());

  @override
  void initState() {
    super.initState();
    homeController.tutorialList = [
      SwipeTutorial(
        image: "assets/icons/swipe_right.png",
        crossAxisAlignment: CrossAxisAlignment.end,
        text: "Swipe right for the clothes you like",
        onTap: widget.onTap,
      ),
      SwipeTutorial(
        image: "assets/icons/swipe_left.png",
        crossAxisAlignment: CrossAxisAlignment.start,
        text: "Swipe left for the clothes you don't like",
        onTap: widget.onTap,
      ),
      PositionTutorial(
        horizontal: 20,
        top: Get.height * .061,
        crossAxisAlignmentSecond: CrossAxisAlignment.start,
        text: "view all catogeies",
        data: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Text(
                'CASA',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    // fontSize: 23,
                    // fontFamily: Font.montaga // Custom font
                    ),
              )
            ],
          ),
        ),
        onTap: widget.onTap,
      ),
      PositionTutorial(
        top: Get.height * .11,
        onTap: widget.onTap,
        crossAxisAlignmentSecond: CrossAxisAlignment.start,
        text: "use filters to search specific item",
        data: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
          child:
              SizedBox(height: 35, width: Get.width * .95, child: FilterRow()),
        ),
      ),
      PositionTutorial(
        onTap: widget.onTap,
        top: Get.height * 0.18,
        text: "use the navigate go to previous\nitem",
        horizontal: 5,
        data: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.transparent,
          ),
          child: const Icon(
            Icons.undo,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      PositionTutorial(
          onTap: widget.onTap,
          bottom: Get.height * 0.174,
          right: 0.0,
          crossAxisAlignment: CrossAxisAlignment.end,
          text: "use to add item to cart",
          horizontal: 15,
          isAbove: false,
          data: Icon(
            Icons.shopping_cart_outlined,
          )),
      PositionTutorial(
          onTap: widget.onTap,
          bottom: Get.height * 0.106,
          crossAxisAlignment: CrossAxisAlignment.end,
          text: "use to share",
          right: 0.0,
          horizontal: 15,
          isAbove: false,
          data: Icon(Icons.share_rounded)),
      PositionTutorial(
        onTap: widget.onTap,
        bottom: Get.height * 0.01,
        crossAxisAlignment: CrossAxisAlignment.end,
        text: "instant buy",
        right: 0.0,
        horizontal: 31,
        isAbove: false,
        data: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          ),
          onPressed: () {},
          child: Text(
            'Buy now',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 13,
              shadows: [
                Shadow(
                  offset: const Offset(1.0, 1.0),
                  blurRadius: 6.0,
                  color: Colors.black.withValues(alpha: 0.2),
                ),
              ],
            ),
          ),
        ),
      ),
      PositionTutorial(
        onTap: widget.onTap,
        bottom: Get.height * 0.136,
        text: "Click the logo to visit store",
        horizontal: 16,
        isAbove: false,
        data: CircleAvatar(
          maxRadius: 24,
          backgroundColor: const Color(0xFF002957),
          child: Text(
            "ZARA".substring(0, 4).toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
      PositionTutorial(
        onTap: widget.onTap,
        bottom: Get.height * 0.0,
        text: "home",
        horizontal: 5,
        isAbove: false,
      ),
      PositionTutorial(
        onTap: widget.onTap,
        bottom: Get.height * 0.0,
        left: Get.width * .15,
        text: "explore",
        isAbove: false,
      ),
      PositionTutorial(
        onTap: widget.onTap,
        bottom: Get.height * 0.0,
        left: Get.width * .33,
        text: "add to\ncart",
        isAbove: false,
      ),
      PositionTutorial(
        onTap: widget.onTap,
        bottom: Get.height * 0.0,
        right: Get.width * .15,
        text: "my\ncloset",
        isAbove: false,
      ),
      PositionTutorial(
        onTap: widget.onTap,
        bottom: Get.height * 0.0,
        right: Get.width * .0,
        crossAxisAlignmentSecond: CrossAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        horizontal: 0,
        text: "Profile",
        isAbove: false,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return homeController.tutorialList[widget.index];
  }
}
