import 'package:casaflutterapp/routes/app_routes.dart';
import 'package:casaflutterapp/src/cart/controller/cart_controller.dart';
import 'package:casaflutterapp/src/common/widgets/buttons/buy_now_button.dart';
import 'package:casaflutterapp/src/home/controller/home_controller.dart';
import 'package:casaflutterapp/src/home/view/widgets/details_widget.dart';
import 'package:casaflutterapp/utils/font.dart';
import 'package:casaflutterapp/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

// import 'package:share_plus/share_plus.dart';

import '../../../../utils/color_constant.dart';
import '../../../order/controller/order_review_controller.dart';
import '../../../wishlist/controller/wishlist_controller.dart';
import '../../../wishlist/view/screens/add_to_closet.dart';
import '../../model/home_models.dart';

class Cards extends StatelessWidget {
  final int index;
  final Product product;
  const Cards({super.key, required this.index, required this.product});

  @override
  Widget build(BuildContext context) {
    final homeCtrl = Get.find<HomeController>();
    final cartLogin = Get.find<CartController>();
    final orderReviewController = Get.find<OrderReviewController>();
    final wishController = Get.find<WishlistController>();

    return Obx(
      () => homeCtrl.isLoading.value
          ? const Center()
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(18), bottom: Radius.circular(18)),
              ),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          // Image
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.758,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                                child: Image.network(product.mainImage!,
                                    fit: BoxFit.fill),
                              ),
                            ),
                          ),

                          // Positioned Back button
                          Positioned(
                            top: 20,
                            left: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Material(
                                elevation: 0,
                                borderRadius: BorderRadius.circular(70),
                                surfaceTintColor: Colors.transparent,
                                color: IconColor.white.withValues(alpha: 0.5),
                                child: InkWell(
                                  overlayColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                  splashFactory: NoSplash.splashFactory,
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {} /*logic.controller.unswipe*/,
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.transparent,
                                    ),
                                    child: const Icon(
                                      Icons.undo,
                                      size: 35,
                                      color: IconColor.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Bottom Positioned Container
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 10),
                                width: MediaQuery.of(context).size.width * 0.91,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      BackgroundColor.black
                                          .withValues(alpha: 0.05),
                                      BackgroundColor.black
                                          .withValues(alpha: 0.5),
                                      BackgroundColor.black
                                          .withValues(alpha: 0.7),
                                    ],
                                    stops: const [0.2, 0.78, 1.0],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    // Left Column
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        spacing: 5,
                                        children: [
                                          // Todo : Circle Avatar should accept network image => done
                                          InkWell(
                                            overlayColor:
                                                WidgetStateProperty.all(
                                                    Colors.transparent),
                                            splashFactory:
                                                NoSplash.splashFactory,
                                            onTap: () {
                                              // context.pushNamed(RouteNames.store);
                                            },

                                            /// Need to add dummy image preview image
                                            child: /*NetworkImageWidget(
                                              url: '',
                                              height: 50,
                                              width: 50,
                                            )*/
                                                /// Remove this after use above code
                                                Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 2),
                                                shape: BoxShape.circle,
                                              ),
                                              padding: EdgeInsets.all(1.5),
                                              child: CircleAvatar(
                                                maxRadius: 24,
                                                backgroundColor:
                                                    const Color(0xFF002957),
                                                child: Text(
                                                  "ZARA"
                                                      .substring(0, 4)
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                      color: TextColor.white,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            product.name ??
                                                AppStrings.productName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: TextColor.white,
                                                ),
                                          ),
                                          Text(
                                            '₹ ${AppStrings.productPrice}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    fontFamily: Font.timeNew,
                                                    fontWeight: FontWeight.w600,
                                                    color: TextColor.white,
                                                    fontSize: 20),
                                          )
                                        ],
                                      ),
                                    ),
                                    // Right Column
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        spacing: 10,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 12),
                                            child: Column(
                                              spacing: 10,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    HapticFeedback
                                                        .heavyImpact();
                                                    cartLogin.addProductsToCart(
                                                        product,
                                                        homeCtrl.quantity.value,
                                                        homeCtrl.selectedSize
                                                            .value);
                                                  },
                                                  icon: Icon(
                                                      Icons
                                                          .add_shopping_cart_outlined,
                                                      color: IconColor.white,
                                                      size: 30),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    HapticFeedback
                                                        .heavyImpact();

                                                    wishController
                                                        .selectedClosets
                                                        .clear();
                                                    showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled: true,
                                                      builder: (context) {
                                                        return AddToCloset(
                                                          imageUrl: product
                                                              .mainImage
                                                              .toString(),
                                                          itemId: product.id
                                                              .toString(),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons
                                                        .bookmark_border_rounded,
                                                    color: IconColor.white,
                                                    size: 30,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    HapticFeedback
                                                        .heavyImpact();
                                                    Share.share(
                                                        'Check out the CASA app now');
                                                  },
                                                  icon: Icon(
                                                      Icons.share_rounded,
                                                      color: IconColor.white,
                                                      size: 30),
                                                ),
                                              ],
                                            ),
                                          ),
                                          BuyNowButton(onPressed: () {
                                            HapticFeedback.heavyImpact();

                                            orderReviewController
                                                .getHomeProduct(
                                                    product,
                                                    homeCtrl.quantity.value,
                                                    homeCtrl
                                                        .selectedSize.value);
                                            context.pushNamed(
                                                RouteNames.orderReview);
                                          }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ProductDetails(
                          product: product,
                          size: homeCtrl.formattedSizesList(product))
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
