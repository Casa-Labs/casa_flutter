import 'package:cached_network_image/cached_network_image.dart';
import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/cart/controller/cart_controller.dart';
import 'package:casaflutter/src/common/widgets/buttons/buy_now_button.dart';
import 'package:casaflutter/src/common/widgets/share_app_dialog.dart';
import 'package:casaflutter/src/home/controller/home_controller.dart';
import 'package:casaflutter/utils/font.dart';
import 'package:casaflutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

// import 'package:share_plus/share_plus.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/preference_manager.dart';
import '../../../order/controller/order_review_controller.dart';
import '../../../wishlist/controller/wishlist_controller.dart';
import '../../../wishlist/view/screens/add_to_closet.dart';
import '../../model/home_models.dart';
import 'details_widget.dart';

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
                              height: MediaQuery.of(context).size.height * 0.72,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22)),
                                child: CachedNetworkImage(
                                  imageUrl: product.mainImage ??
                                      ImageConstants.dummyNetworkPortrait,
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      margin: EdgeInsets.only(right: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              ImageConstants.errorImage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),

                          // Positioned Back button
                          Positioned(
                            top: 3,
                            left: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Material(
                                elevation: 0,
                                borderRadius: BorderRadius.circular(70),
                                surfaceTintColor: Colors.transparent,
                                color: IconColor.white,
                                child: InkWell(
                                  overlayColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                  splashFactory: NoSplash.splashFactory,
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: homeCtrl.controller.unswipe,
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.transparent,
                                    ),
                                    child:
                                        SvgPicture.asset(ImageConstants.undo),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Bottom Positioned Container
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(22),
                                bottomRight: Radius.circular(22),
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      BackgroundColor.black
                                          .withValues(alpha: 0),
                                      BackgroundColor.black
                                          .withValues(alpha: 0.2),
                                      BackgroundColor.black
                                          .withValues(alpha: 0.5),
                                    ],
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
                                          InkWell(
                                            overlayColor:
                                                WidgetStateProperty.all(
                                                    Colors.transparent),
                                            splashFactory:
                                                NoSplash.splashFactory,
                                            onTap: () {
                                              context.pushNamed(
                                                RouteNames.store,
                                                pathParameters: {
                                                  'id': product.store?.id ?? ''
                                                },
                                              );
                                            },
                                            child: Container(
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
                                                    Colors.transparent,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(24),
                                                  child: CachedNetworkImage(
                                                    imageUrl: (product.store
                                                                    ?.logo ??
                                                                '')
                                                            .isNotEmpty
                                                        ? product.store?.logo ??
                                                            ''
                                                        : ImageConstants
                                                            .dummyNetworkPortrait,
                                                    errorWidget:
                                                        (context, url, error) {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                ImageConstants
                                                                    .errorImage),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    fit: BoxFit.fill,
                                                  ),
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
                                                  fontWeight: FontWeight.w800,
                                                  color: TextColor.white,
                                                ),
                                          ),
                                          Text(
                                            '₹ ${product.price}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    fontFamily: Font.timeNew,
                                                    fontWeight: FontWeight.w800,
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
                                                    final token =
                                                        PreferenceManager
                                                            .getString(
                                                                PreferenceManager
                                                                    .token);
                                                    if (token == null ||
                                                        token.isEmpty) {
                                                      context.pushNamed(
                                                          RouteNames.signIn);
                                                    } else {
                                                      HapticFeedback
                                                          .heavyImpact();
                                                      cartLogin
                                                          .addProductsToCart(
                                                              product,
                                                              product.quantity!,
                                                              homeCtrl
                                                                  .selectedSize
                                                                  .value);
                                                      homeCtrl.addToCartSwipe();
                                                    }
                                                  },
                                                  icon: Image.asset(
                                                    IconConstants.cartAdd,
                                                    height: 40.0,
                                                    width: 40.0,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    final token =
                                                        PreferenceManager
                                                            .getString(
                                                                PreferenceManager
                                                                    .token);
                                                    if (token == null ||
                                                        token.isEmpty) {
                                                      context.pushNamed(
                                                          RouteNames.signIn);
                                                    } else {
                                                      HapticFeedback
                                                          .heavyImpact();

                                                      wishController
                                                          .selectedClosets
                                                          .clear();
                                                      showModalBottomSheet(
                                                        context: context,
                                                        isScrollControlled:
                                                            true,
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
                                                    }
                                                  },
                                                  icon: Image.asset(
                                                    IconConstants.bookMark,
                                                    height: 40.0,
                                                    width: 40.0,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    HapticFeedback
                                                        .heavyImpact();
                                                    showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          ShareAppDialog(
                                                        appName: "CASA",
                                                        androidAppLink:
                                                            "https://play.google.com/store/apps/details?id=com.casashop.casaflutterapp",
                                                        iosAppLink:
                                                            "https://apps.apple.com/app",
                                                      ),
                                                    );
                                                  },
                                                  icon: Image.asset(
                                                    IconConstants.forward,
                                                    height: 40.0,
                                                    width: 40.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          BuyNowButton(onPressed: () {
                                            final token =
                                                PreferenceManager.getString(
                                                    PreferenceManager.token);
                                            if (token == null ||
                                                token.isEmpty) {
                                              context
                                                  .pushNamed(RouteNames.signIn);
                                            } else {
                                              HapticFeedback.heavyImpact();

                                              orderReviewController
                                                  .getHomeProduct(
                                                      product,
                                                      product.quantity!,
                                                      homeCtrl
                                                          .selectedSize.value);
                                              context.pushNamed(
                                                  RouteNames.orderReview);
                                            }
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
                        size: homeCtrl.formattedSizesList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
