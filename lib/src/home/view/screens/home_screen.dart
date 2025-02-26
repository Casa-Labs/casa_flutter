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
    late Future<List<Product>> productsFuture = homeCtrl.fetchProducts();

    return Scaffold(
      backgroundColor: BackgroundColor.white,
      appBar: CustomAppbar(),
      body: FutureBuilder(
        future: productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error fetching products"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No products available"));
          } else {
            var products = snapshot.data;
            return GetBuilder<HomeController>(
              builder: (logic) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      FilterRow(
                          brandList: logic.brandFilter,
                          colorList: logic.colorFilter,
                          productList: logic.productFilter),
                      _cardSwiper(logic, context, products)
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
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
