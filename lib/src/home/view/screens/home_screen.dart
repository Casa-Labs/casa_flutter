import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:casaflutter/src/home/controller/home_controller.dart';
import 'package:casaflutter/src/home/view/widgets/card.dart';
import 'package:casaflutter/src/home/view/widgets/filter_button_row.dart';
import 'package:casaflutter/src/home/view/widgets/home_search_app_bar.dart';
import 'package:casaflutter/src/home/view/widgets/reset_dialog.dart';
import 'package:casaflutter/src/home/view/widgets/swipe_animation.dart';
import 'package:casaflutter/utils/color_constant.dart';
import 'package:casaflutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../cart/controller/cart_controller.dart';
import '../../../order/controller/order_review_controller.dart';
import '../../../wishlist/controller/wishlist_controller.dart';
import '../../model/home_models.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeCtrl = Get.put(HomeController());
  final cartController = Get.put(CartController());
  final orderReviewController = Get.put(OrderReviewController());
  final wishController = Get.put(WishlistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor.white,
      appBar: HomeSearchAppBar(),
      body: Obx(
        () => homeCtrl.isLoading.value
            ? Center(
                child: CircularProgressIndicator(color: BorderColor.black),
              )
            : Column(
                children: [
                  FilterButtonRow(
                    onFilterSettingsPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => ResetDialog(
                                onYesPressed: () {
                                  homeCtrl.fetchProducts({}, reset: true);
                                  context.pop();
                                },
                                onCancelPressed: () {
                                  context.pop();
                                },
                              ));
                    },
                    filters: [
                      FilterButtonModel(
                        title: 'Brand',
                        list: homeCtrl.brand.map((item) => item.name!).toList(),
                        onClear: () {
                          logg.i("Brand selection cleared");
                        },
                        onDone: (selectedName) {
                          final brandId = homeCtrl.brand
                              .firstWhereOrNull((e) => e.name == selectedName)
                              ?.id;
                          logg.i("Selected brand ID: $brandId");

                          if (brandId != null) {
                            homeCtrl.fetchProducts({"storeId": brandId});
                          }
                        },
                      ),
                      FilterButtonModel(
                        title: 'Product',
                        list: homeCtrl.category
                            .map((item) => item.name!)
                            .toList(),
                        onClear: () {
                          logg.i("Category selection cleared");
                        },
                        onDone: (selectedName) {
                          final category = homeCtrl.category
                              .firstWhereOrNull((e) => e.name == selectedName)
                              ?.id;
                          logg.i("Selected category ID: $category");

                          if (category != null) {
                            homeCtrl.fetchProducts({"categoryId": category});
                          }
                        },
                      ),
                      FilterButtonModel(
                        title: 'Colors',
                        list: ['Red', 'Blue', 'Green', 'Black', 'White', 'NA'],
                        onClear: () {
                          logg.i("Color selection cleared");
                        },
                        onDone: (selectedName) {
                          // final category = homeCtrl.category
                          //     .firstWhereOrNull((e) => e.name == selectedName)
                          //     ?.id;
                          // logg.i("Selected category ID: $category");

                          final selectedColor = selectedName;

                          if (selectedColor != null) {
                            homeCtrl.fetchProducts({
                              "productColor": [selectedColor]
                            });
                          }
                        },
                      ),
                      FilterButtonModel(
                        title: 'Size',
                        list: homeCtrl.size.map((item) => item.name!).toList(),
                        onClear: () {
                          logg.i("size selection cleared");
                        },
                        onDone: (selectedName) {
                          final selectedSize = homeCtrl.size
                              .firstWhereOrNull((e) => e.name == selectedName)
                              ?.id;
                          logg.i("Selected size ID: $selectedName");

                          if (selectedSize != null) {
                            homeCtrl.fetchProducts({
                              "productSize": [selectedSize]
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          homeCtrl.products.isNotEmpty
                              ? _cardSwiper(
                                  homeCtrl, context, homeCtrl.products)
                              : Center(
                                  child: Text('No products found'),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  _cardSwiper(
      HomeController logic, BuildContext context, List<Product> products) {
    return GetBuilder<HomeController>(builder: (logic) {
      return RefreshIndicator(
        onRefresh: () => logic.fetchProducts({}),
        child: Stack(
          alignment: logic.swipeIcon == Icons.add_shopping_cart_outlined
              ? Alignment.topCenter
              : Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: AppinioSwiper(
                  loop: true,
                  controller: logic.controller,
                  swipeOptions: const SwipeOptions.only(
                    left: true,
                    right: true,
                  ),
                  backgroundCardCount: 0,
                  cardCount: products.length,
                  isDisabled: logic.isDisabled,
                  onEnd: logic.onEnd,
                  initialIndex: logic.cardIndex != -1 ? logic.cardIndex : null,
                  onSwipeEnd: logic.swipeEnd,
                  cardBuilder: (context, index) {
                    if (index >= products.length) {
                      return Center(child: Text('No more cards'));
                    }
                    return Cards(index: index, product: products[index]);
                  },
                ),
              ),
            ),
            SwipeAnimation(swipeIcon: logic.swipeIcon),
          ],
        ),
      );
    });
  }
}
