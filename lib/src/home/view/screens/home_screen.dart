import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:casa_flutter/src/common/widgets/app_bar.dart';
import 'package:casa_flutter/src/home/controller/home_controller.dart';
import 'package:casa_flutter/src/home/view/widgets/card.dart';
import 'package:casa_flutter/src/home/view/widgets/swipe_animation.dart';
import 'package:casa_flutter/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../cart/controller/cart_controller.dart';
import '../../../common/widgets/filter_row.dart';
import '../../model/home_models.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeCtrl = Get.put(HomeController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor.white,
      appBar: CustomAppbar(),
      body: SafeArea(child: GetBuilder<HomeController>(
        builder: (logic) {
          return SingleChildScrollView(
            child: logic.isLoading
                ? Center(
                    child: CircularProgressIndicator(color: BorderColor.black),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilterRow(
                        brandList: logic.brandFilter,
                        colorList: logic.colorFilter,
                        productList: logic.productFilter,
                        sizedList: logic.sizedFilter,
                      ),
                      SizedBox(height: 5),
                      _cardSwiper(logic, context, logic.products)
                    ],
                  ),
          );
        },
      )),
    );
  }

  _cardSwiper(
      HomeController logic, BuildContext context, List<Product>? products) {
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
                return Cards(index: index, product: products![index]);
              },
            ),
          ),
        ),
        SwipeAnimation(swipeIcon: logic.swipeIcon)
      ],
    );
  }
}
