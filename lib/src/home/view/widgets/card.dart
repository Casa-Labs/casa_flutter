import 'package:casa_flutter/routes/app_routes.dart';
import 'package:casa_flutter/src/cart/controller/cart_controller.dart';
import 'package:casa_flutter/src/common/widgets/buttons/buy_now_button.dart';
import 'package:casa_flutter/src/home/controller/home_controller.dart';
import 'package:casa_flutter/src/home/view/widgets/details_widget.dart';
import 'package:casa_flutter/utils/font.dart';
import 'package:casa_flutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

// import 'package:share_plus/share_plus.dart';

import '../../../../utils/color_constant.dart';
import '../../model/home_models.dart';

class Cards extends StatelessWidget {
  final int index;
  final Product product;
  const Cards({super.key, required this.index, required this.product});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (logic) {
      return GetBuilder<CartController>(builder: (cartLogin) {
        return Container(
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.grey.shade200),
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
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.758,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            child: Image.network(product.mainImage!,
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      /*   Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: Image.asset('assets/images/placeholder.png',
                                fit: BoxFit.fill)),
                      ),*/
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withValues(alpha: 0.0),
                                Colors.black.withValues(alpha: 0.5),
                                Colors.black.withValues(alpha: 0.7),
                              ],
                              stops: const [0.65, 0.95, 1.0],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 5, // todo : remake
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(0, 0, 0, 0),
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(15))),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                overlayColor:
                                    WidgetStateProperty.all(Colors.transparent),
                                splashFactory: NoSplash.splashFactory,
                                onTap: () {
                                  context.pushNamed(RouteNames.store);
                                },
                                child: CircleAvatar(
                                  maxRadius: 24,
                                  backgroundColor: const Color(0xFF002957),
                                  child: Text(
                                    "ZARA".substring(0, 4).toUpperCase(),
                                    style: const TextStyle(
                                        color: TextColor.white, fontSize: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 3),
                              // Shimmer.fromColors(
                              //   baseColor: Colors.grey[400]!,
                              //   highlightColor: Colors.grey[100]!,
                              // child:
                              Text(
                                product.name ?? AppStrings.productName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: TextColor.white,
                                    ),
                              ),
                              // ),
                              const SizedBox(height: 10),
                              // Shimmer.fromColors(
                              //   baseColor: Colors.grey[400]!,
                              //   highlightColor: Colors.grey[100]!,
                              //   child:
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

                              // ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Material(
                            elevation: 0,
                            borderRadius: BorderRadius.circular(70),
                            surfaceTintColor: Colors.transparent,
                            color: IconColor.black,
                            child: InkWell(
                              overlayColor:
                                  WidgetStateProperty.all(Colors.transparent),
                              splashFactory: NoSplash.splashFactory,
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {} /*logic.controller.unswipe*/,
                              child: Container(
                                width: 45,
                                height: 45,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.transparent,
                                ),
                                child: const Icon(
                                  Icons.undo,
                                  size: 35,
                                  color: IconColor.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        // Todo : remake, check again for right padding
                        bottom: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 30,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  overlayColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                  splashFactory: NoSplash.splashFactory,
                                  onTap: () {
                                    cartLogin.addProductsToCart(
                                        product, logic.quantity.value);
                                  },
                                  child: Icon(Icons.add_shopping_cart_outlined,
                                      color: IconColor.white, size: 30),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Icon(
                                  Icons.bookmark_border_rounded,
                                  color: IconColor.white,
                                  size: 30,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                    overlayColor: WidgetStateProperty.all(
                                        Colors.transparent),
                                    splashFactory: NoSplash.splashFactory,
                                    onTap: () {
                                      // Share.share(
                                      //     'Check out this amazing product at CASA app now !');
                                    },
                                    child: Icon(Icons.share_rounded,
                                        color: IconColor.white, size: 30)),
                              ),
                              BuyNowButton(onPressed: () {
                                context.pushNamed(RouteNames.orderReview);
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ProductDetails(product: product)
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
