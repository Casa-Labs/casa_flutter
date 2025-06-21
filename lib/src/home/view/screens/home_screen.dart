import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:casaflutter/src/home/controller/filter_controller.dart';
import 'package:casaflutter/src/home/controller/home_controller.dart';
import 'package:casaflutter/src/home/view/widgets/card.dart';
import 'package:casaflutter/src/home/view/widgets/filter_button_row.dart';
import 'package:casaflutter/src/home/view/widgets/home_search_app_bar.dart';
import 'package:casaflutter/src/home/view/widgets/swipe_animation.dart';
import 'package:casaflutter/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../cart/controller/cart_controller.dart';
import '../../../order/controller/order_review_controller.dart';
import '../../../wishlist/controller/wishlist_controller.dart';
import '../../model/home_models.dart';
import '../widgets/home_big_filter_dialog.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeCtrl = Get.put(HomeController());
  final cartController = Get.put(CartController());
  final orderReviewController = Get.put(OrderReviewController());
  final wishController = Get.put(WishlistController());
  final filterController = Get.put(FilterController());

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
                        builder: (context) => HomeBigFilterDialog(
                          onYesPressed: () {
                            homeCtrl.selectedGender.value =
                                ''; // Reset gender selection
                            filterController.filters.clear();
                            homeCtrl.fetchProducts({}, reset: true);
                            context.pop();
                          },
                          onCancelPressed: () {
                            context.pop();
                          },
                        ),
                      );
                    },
                    filters: [
                      FilterButtonModel(
                        title: 'Brand',
                        list: homeCtrl.brand.map((item) => item.name!).toList(),
                        getSelectedValues: () {
                          return homeCtrl.brand
                              .where((e) => filterController
                                  .getFilter("storeIds")
                                  .contains(e.id))
                              .map((e) => e.name!)
                              .toList();
                        },
                        onClear: (_) {
                          filterController.clearFilter("storeIds");
                          homeCtrl.fetchProducts(
                              filterController.getCleanFilters(),
                              reset: true);
                        },
                        onDone: (selectedNames) {
                          final brandIds = homeCtrl.brand
                              .where((e) => selectedNames.contains(e.name))
                              .map((e) => e.id!)
                              .toList();

                          filterController.updateFilter("storeIds", brandIds);
                          homeCtrl.fetchProducts(
                              filterController.getCleanFilters(),
                              reset: true);
                        },
                      ),
                      FilterButtonModel(
                        title: 'Product',
                        list: homeCtrl.category
                            .map((item) => item.name!)
                            .toList(),
                        getSelectedValues: () {
                          return homeCtrl.category
                              .where((e) => filterController
                                  .getFilter("categories")
                                  .contains(e.id))
                              .map((e) => e.name!)
                              .toList();
                        },
                        onClear: (_) {
                          filterController.clearFilter("categories");
                          homeCtrl.fetchProducts(
                              filterController.getCleanFilters(),
                              reset: true);
                        },
                        onDone: (selectedNames) {
                          final catIds = homeCtrl.category
                              .where((e) => selectedNames.contains(e.name))
                              .map((e) => e.id!)
                              .toList();

                          filterController.updateFilter("categories", catIds);
                          homeCtrl.fetchProducts(
                              filterController.getCleanFilters(),
                              reset: true);
                        },
                      ),
                      FilterButtonModel(
                        title: 'Colors',
                        list:
                            homeCtrl.colors.map((item) => item.name!).toList(),
                        getSelectedValues: () {
                          return homeCtrl.colors
                              .where((e) => filterController
                                  .getFilter("productColor")
                                  .contains(e.id))
                              .map((e) => e.name!)
                              .toList();
                        },
                        onClear: (_) {
                          filterController.clearFilter("productColor");
                          homeCtrl.fetchProducts(
                              filterController.getCleanFilters(),
                              reset: true);
                        },
                        onDone: (selectedNames) {
                          final colorIds = homeCtrl.colors
                              .where((e) => selectedNames.contains(e.name))
                              .map((e) => e.id)
                              .whereType<String>()
                              .toList();
                          filterController.updateFilter(
                              "productColor", colorIds);
                          homeCtrl.fetchProducts(
                              filterController.getCleanFilters(),
                              reset: true);
                        },
                      ),
                      FilterButtonModel(
                        title: 'Size',
                        list: homeCtrl.size.map((item) => item.name!).toList(),
                        getSelectedValues: () {
                          return homeCtrl.size
                              .where((e) => filterController
                                  .getFilter("productSize")
                                  .contains(e.id))
                              .map((e) => e.name!)
                              .toList();
                        },
                        onClear: (_) {
                          filterController.clearFilter("productSize");
                          homeCtrl.fetchProducts(
                              filterController.getCleanFilters(),
                              reset: true);
                        },
                        onDone: (selectedNames) {
                          final sizeIds = homeCtrl.size
                              .where((e) => selectedNames.contains(e.name))
                              .map((e) => e.id)
                              .whereType<String>()
                              .toList();
                          filterController.updateFilter("productSize", sizeIds);
                          homeCtrl.fetchProducts(
                              filterController.getCleanFilters(),
                              reset: true);
                        },
                      ),
                    ],
                  ),

                  // FilterButtonRow(
                  //   onFilterSettingsPressed: () {
                  //     showDialog(
                  //         context: context,
                  //         builder: (context) => ResetDialog(
                  //               onYesPressed: () {
                  //                 homeCtrl.fetchProducts({}, reset: true);
                  //                 context.pop();
                  //               },
                  //               onCancelPressed: () {
                  //                 context.pop();
                  //               },
                  //             ));
                  //   },
                  //   filters: [
                  //     FilterButtonModel(
                  //       title: 'Brand',
                  //       list: homeCtrl.brand.map((item) => item.name!).toList(),
                  //       onClear: (values) {
                  //         logg.d("Brand selection cleared");
                  //         homeCtrl.filters["storeIds"] = null;
                  //         homeCtrl.fetchProducts(homeCtrl.getCleanFilters(),
                  //             reset: true);
                  //       },
                  //       onDone: (selectedNames) {
                  //         final brandIds = homeCtrl.brand
                  //             .where((e) => selectedNames.contains(e.name))
                  //             .map((e) => e.id)
                  //             .whereType<String>()
                  //             .toList();
                  //
                  //         logg.d("Selected brand IDs: $brandIds");
                  //
                  //         if (brandIds.isNotEmpty) {
                  //           homeCtrl.filters["storeIds"] = brandIds;
                  //           homeCtrl.fetchProducts(homeCtrl.getCleanFilters(),
                  //               reset: true);
                  //         }
                  //       },
                  //     ),
                  //     FilterButtonModel(
                  //       title: 'Colors',
                  //       list:
                  //           homeCtrl.colors.map((item) => item.name!).toList(),
                  //       onClear: (values) {
                  //         logg.d("Color selection cleared");
                  //         homeCtrl.filters["productColor"] = null;
                  //         homeCtrl.fetchProducts(homeCtrl.getCleanFilters(),
                  //             reset: true);
                  //       },
                  //       onDone: (selectedNames) {
                  //         final colorIds = homeCtrl.colors
                  //             .where((e) => selectedNames.contains(e.name))
                  //             .map((e) => e.id)
                  //             .whereType<String>()
                  //             .toList();
                  //
                  //         logg.d("Selected color IDs: $colorIds");
                  //
                  //         if (colorIds.isNotEmpty) {
                  //           homeCtrl.filters["productColor"] = colorIds;
                  //           homeCtrl.fetchProducts(homeCtrl.getCleanFilters(),
                  //               reset: true);
                  //         }
                  //       },
                  //     ),
                  //     FilterButtonModel(
                  //       title: 'Size',
                  //       list: homeCtrl.size.map((item) => item.name!).toList(),
                  //       onClear: (values) {
                  //         logg.d("Size selection cleared");
                  //         homeCtrl.filters["productSize"] = null;
                  //         homeCtrl.fetchProducts(homeCtrl.getCleanFilters(),
                  //             reset: true);
                  //       },
                  //       onDone: (selectedNames) {
                  //         final sizeIds = homeCtrl.size
                  //             .where((e) => selectedNames.contains(e.name))
                  //             .map((e) => e.id)
                  //             .whereType<String>()
                  //             .toList();
                  //
                  //         logg.d("Selected size IDs: $sizeIds");
                  //
                  //         if (sizeIds.isNotEmpty) {
                  //           homeCtrl.filters["productSize"] = sizeIds;
                  //           homeCtrl.fetchProducts(homeCtrl.getCleanFilters(),
                  //               reset: true);
                  //         }
                  //       },
                  //     ),
                  //   ],
                  // ),
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

// FilterButtonModel(
//   title: 'Product',
//   list: homeCtrl.category
//       .map((item) => item.name!)
//       .toList(),
//   onClear: (values) {
//     logg.i("Category selection cleared");
//     homeCtrl.filters["category"] = null;
//     homeCtrl.fetchProducts(homeCtrl.getCleanFilters());
//   },
//   onDone: (selectedName) {
//     final categoryId = homeCtrl.category
//         .firstWhereOrNull((e) => e.name == selectedName)
//         ?.id;
//     logg.i("Selected category ID: $categoryId");
//
//     if (categoryId != null) {
//       homeCtrl.filters["category"] = categoryId;
//       homeCtrl.fetchProducts(homeCtrl.getCleanFilters());
//     }
//   },
// ),
