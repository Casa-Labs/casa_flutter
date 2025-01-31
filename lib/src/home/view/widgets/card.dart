import 'package:casa_flutter/src/home/controller/home_controller.dart';
import 'package:casa_flutter/src/home/view/widgets/details_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/widgets/text_widgets.dart';
import '../../model/home_models.dart';

class Cards extends StatelessWidget {
  final int index;
  final ProductModel product;
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
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: Image.asset('assets/images/placeholder.png',
                          fit: BoxFit.fill)),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.0),
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.7),
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
                    left: 0,
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
                            onTap: () {},
                            child: CircleAvatar(
                              maxRadius: 24,
                              backgroundColor: const Color(0xFF002957),
                              child: Text(
                                "ZARA".substring(0, 4).toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                          const SizedBox(height: 3),
                          // Shimmer.fromColors(
                          //   baseColor: Colors.grey[400]!,
                          //   highlightColor: Colors.grey[100]!,
                          // child:
                          BodyText(
                            text: product.title ?? "",
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          // ),
                          const SizedBox(height: 10),
                          // Shimmer.fromColors(
                          //   baseColor: Colors.grey[400]!,
                          //   highlightColor: Colors.grey[100]!,
                          //   child:
                          BodyText(
                            text: '₹${product.price}',
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
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
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              overlayColor:
                                  WidgetStateProperty.all(Colors.transparent),
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                                // _addToCart(context, logic);
                              },
                              child: Icon(Icons.add_shopping_cart_outlined,
                                  color: Colors.white, size: 30),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                                overlayColor:
                                    WidgetStateProperty.all(Colors.transparent),
                                splashFactory: NoSplash.splashFactory,
                                onTap: () {},
                                child: Icon(Icons.share_rounded,
                                    color: Colors.white, size: 30)),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                            ),
                            onPressed: () {
                              // product.quantity = logic.counter.value;
                              // final CheckoutController checkoutController =
                              // Get.put(CheckoutController());
                              // checkoutController.getListData([product]);
                              // Get.to(() => OrderSummary())?.whenComplete(() {
                              //   setState(() {});
                              // });
                            },
                            child: Text(
                              'Buy now',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 13,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(1.0, 1.0),
                                    blurRadius: 6.0,
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ],
                              ),
                            ),
                          ),
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