import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:casa_flutter/src/common/widgets/app_bar.dart';
import 'package:casa_flutter/src/home/controller/home_controller.dart';
import 'package:casa_flutter/src/home/view/widgets/card.dart';
import 'package:casa_flutter/src/home/view/widgets/swipe_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/filter_row.dart';
import '../../model/home_models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(),
      body: GetBuilder<HomeController>(
        builder: (logic) {
          return Column(
            children: [
              FilterRow(
                item: ['Brand', 'Product', 'Color', 'Price', 'Size'],
              ),
              _cardSwiper(logic,context)
            ],
          );
        },
      ),
    );
  }

  _cardSwiper(HomeController logic, BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.76,
            child: AppinioSwiper(
              loop: true,
              controller: logic.controller,
              swipeOptions: const SwipeOptions.only(
                left: true,
                right: true,
              ),
              backgroundCardCount: 0,
              cardCount: 15,
              isDisabled: logic.isDisabled,
              onEnd: logic.onEnd,
              initialIndex: logic.cardIndex != -1 ? logic.cardIndex : null,
              onSwipeEnd: logic.swipeEnd,
              cardBuilder: (context, index) {
                return Cards(index: index, product: ProductModel());
              },
            ),
          ),
        ),
        SwipeAnimation(swipeIcon: logic.swipeIcon)
      ],
    );
  }
}
