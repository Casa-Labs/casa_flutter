import 'package:casa_flutter/routes/app_routes.dart';
import 'package:casa_flutter/src/explore/view/screens/product_description_screen.dart';
import 'package:casa_flutter/src/home/controller/home_controller.dart';
import 'package:casa_flutter/src/home/view/widgets/details_widget.dart';
import 'package:casa_flutter/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
// import 'package:share_plus/share_plus.dart';

import '../../../../utils/color_constant.dart';
import '../../../common/widgets/text_widgets.dart';
import '../../model/home_models.dart';

class Cards extends StatelessWidget {
  final int index;
  final Product product;
  const Cards({super.key, required this.index, required this.product});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (logic) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(18), bottom: Radius.circular(18)),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  //  Positioned.fill(
                  //   child: ClipRRect(
                  //     borderRadius:
                  //     BorderRadius.vertical(top: Radius.circular(18)),
                  //     child: Material(
                  //       elevation: 4,
                  //       color: Colors.grey.shade300,
                  //       child: Image.network(
                  //         product.images![0].src.toString(),
                  //         fit: BoxFit.cover,
                  //         width: double.infinity,
                  //         height: double.infinity,
                  //         loadingBuilder: (context, child, loadingProgress) {
                  //           if (loadingProgress == null) {
                  //             return child;
                  //           }
                  //           return Shimmer.fromColors(
                  //             baseColor: Colors.grey[300]!,
                  //             highlightColor: Colors.grey[100]!,
                  //             child: Container(
                  //               color: Colors.white,
                  //               width: double.infinity,
                  //               height: double.infinity,
                  //             ),
                  //           );
                  //         },
                  //         errorBuilder: (context, error, stackTrace) {
                  //           return Image.asset('assets/images/placeholder.png');
                  //         },
                  //       ),
                  //       // Image.asset('assets/images/placeholder.png',
                  //       //     fit: BoxFit.cover),
                  //     ),
                  //   ),
                  // )
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: Image.asset('assets/images/placeholder.png',
                            fit: BoxFit.fill)),
                  ),
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
                    left: 15,
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
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: TextColor.white,
                                    ),
                          )

                          // ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Material(
                        elevation: 0,
                        borderRadius: BorderRadius.circular(12),
                        surfaceTintColor: Colors.transparent,
                        color: Colors.transparent,
                        child: InkWell(
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                          splashFactory: NoSplash.splashFactory,
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {} /*logic.controller.unswipe*/,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.transparent,
                            ),
                            child: const Icon(
                              Icons.undo,
                              size: 30,
                              color: IconColor.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 10,
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              overlayColor:
                                  WidgetStateProperty.all(Colors.transparent),
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                                // _addToCart(context, logic);
                                context.pushNamed(RouteNames.cart);
                              },
                              child: Icon(Icons.add_shopping_cart_outlined,
                                  color: IconColor.white, size: 30),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                                overlayColor:
                                    WidgetStateProperty.all(Colors.transparent),
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
      );
    });
  }
}
