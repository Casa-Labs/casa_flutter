import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:casaflutterapp/src/home/controller/home_controller.dart';
import 'package:casaflutterapp/src/home/view/widgets/card.dart';
import 'package:casaflutterapp/src/home/view/widgets/filter_button_row.dart';
import 'package:casaflutterapp/src/home/view/widgets/home_search_app_bar.dart';
import 'package:casaflutterapp/src/home/view/widgets/swipe_animation.dart';
import 'package:casaflutterapp/utils/color_constant.dart';
import 'package:casaflutterapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FilterButtonRow(
                      filters: [
                        FilterButtonModel(
                          title: 'Brand',
                          list:
                              homeCtrl.brand.map((item) => item.name!).toList(),
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
                          list: [
                            'Red',
                            'Blue',
                            'Green',
                            'Black',
                            'White',
                            'NA'
                          ],
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
                          list: [
                            'X-Small',
                            'Small',
                            'Medium',
                            'Large',
                            'X-Large',
                            'M',
                            'XL',
                            'S',
                            'L',
                            'Default Title',
                            'S / M',
                            'S / L',
                            'M / S',
                            'M / M',
                            'L / M',
                            'M / L',
                            'L / L',
                            'L / S',
                            'S / S',
                            'XS',
                            'XS / S',
                            'XS / XS',
                            'XS / M',
                            'S / XS',
                            'XS / L',
                            'M / XS',
                            'L / XS',
                            'Ivory / L',
                            'Black / XS',
                            'Black / S',
                            'Black / M',
                            'Navy / XS',
                            'Black / L',
                            'Navy / S',
                            'Ivory / XS',
                            'Navy / M',
                            'Ivory / S',
                            'Navy / L',
                            'Ivory / M'
                          ],
                          onClear: () {
                            logg.i("size selection cleared");
                          },
                          onDone: (selectedName) {
                            // final category = homeCtrl.category
                            //     .firstWhereOrNull((e) => e.name == selectedName)
                            //     ?.id;
                            // logg.i("Selected sizey ID: $category");

                            final selectedSize = selectedName;

                            if (selectedSize != null) {
                              homeCtrl.fetchProducts({
                                "productSize": [selectedSize]
                              });
                            }
                          },
                        ),

                        // FilterButtonModel(
                        //   title: 'Product',
                        //   list: homeCtrl.category
                        //       .map((item) => item.name!)
                        //       .toList(),
                        //   // onClear: () => clearBrandSelection(),
                        //   // onDone: () => applyBrandSelection(),
                        //   onClear: () {
                        //     logg.e('clearing category selection');
                        //     context.pop();
                        //   },
                        //   onDone: () {
                        //     logg.e('Category selection done');
                        //     context.pop();
                        //   },
                        // ),
                      ],
                    ),
                    SizedBox(height: 5),
                    homeCtrl.products.isNotEmpty
                        ? _cardSwiper(homeCtrl, context, homeCtrl.products)
                        : Center(
                            child: Text('No products found'),
                          ),
                  ],
                ),
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
                height: MediaQuery.of(context).size.height * 0.84,
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
