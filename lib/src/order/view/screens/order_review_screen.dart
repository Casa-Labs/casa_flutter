import 'package:casa_flutter/src/order/controller/order_review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/text_widgets.dart';
import '../widgets/expandable_card.dart';

class OrderReviewScreen extends StatelessWidget {
  OrderReviewScreen({
    super.key,
  });
  final orderReviewController = Get.put(OrderReviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
          title: 'Order review',
          isLeadingBack: true,
          isLeading: false,
          isNotification: false,
          isFilter: false),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(50)),
                      child: CircleAvatar(
                        maxRadius: 24,
                        backgroundColor: const Color(0xFF002957),
                        child: BodyText(
                          text: "ZARA".substring(0, 3).toUpperCase(),
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      return ListView.separated(
                        padding: const EdgeInsets.all(0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: orderReviewController.productsList.length,
                        itemBuilder: (context, index) {
                          var product =
                              orderReviewController.productsList[index];
                          return Container(
                              padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 0.7),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Card(
                                        elevation: 2,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            product.images![0].src.toString(),
                                            fit: BoxFit.cover,
                                            width: 109,
                                            height: 166,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: BodyText(
                                                      text: product.title!,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  BodyText(
                                                    text:
                                                        "₹${product.price!.replaceAll('Rs.', '').replaceAll(' ', '')}",
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),
                                              const BodyText(
                                                text: 'Zara',
                                                fontSize: 16,
                                                color: Colors.black54,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(Icons
                                                      .bike_scooter_outlined),
                                                  // SvgPicture.asset(
                                                  //     'assets/icon/ruler.svg'),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const BodyText(
                                                    text: 'Size Guide',
                                                    color: Colors.black54,
                                                    fontSize: 10,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Row(
                                                children: [
                                                  BodyText(
                                                    text: 'Size:',
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  Spacer(),
                                                  BodyText(
                                                    text: 'M',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  SizedBox(
                                                    width: 25,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  const BodyText(
                                                    text: 'Quantity:',
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 2),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: const Color
                                                            .fromARGB(106, 217,
                                                            217, 217)),
                                                    child: BodyText(
                                                      text: product.quantity
                                                          .toString(),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                ],
                                              ),
                                              IconButton(
                                                highlightColor:
                                                    Colors.transparent,
                                                icon: Icon(Icons.delete),
                                                // icon: SvgPicture.asset(
                                                //   'assets/icon/delete.svg',
                                                //   height: 23,
                                                //   width: 23,
                                                // ),
                                                onPressed: () {
                                                  orderReviewController
                                                      .deleteItem(product);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                      );
                    }),
                    const SizedBox(
                      height: 30,
                    ),
                    Material(
                      elevation: 4,
                      surfaceTintColor: Colors.white,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                              color: Color(0xFFCBCBCB), width: 0.5)),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            height: 28,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAE6E6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  overlayColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                  splashFactory: NoSplash.splashFactory,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black),
                                    child: const BodyText(
                                      text: "Delivery type",
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  overlayColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                  splashFactory: NoSplash.splashFactory,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black),
                                    child: const BodyText(
                                      text: "Instructions",
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 20,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFF4220FF),
                                            width: 4),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const BodyText(
                                      text: "Standard",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF4220FF),
                                    )
                                  ],
                                ),
                                // Image.asset(
                                //   "assets/images/order_review_1.png",
                                //   height: 104,
                                //   width: 70,
                                // )
                                Icon(Icons.filter_frames_outlined),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ExpandableCard(
                      orderController: orderReviewController,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 4,
                        ),
                        BodyText(
                          text: "PAY USING",
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        Icon(
                          Icons.arrow_drop_up,
                        )
                      ],
                    ),
                    BodyText(
                      text: "Phone Pay",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ],
                ),
                Obx(() {
                  return FilledButton(
                    style: FilledButton.styleFrom(
                      surfaceTintColor: const Color(0xFF2C9D24),
                      backgroundColor: const Color(0xFF2C9D24),
                    ),
                    onPressed: () {},
                    child: BodyText(
                      text: "Pay ₹${orderReviewController.total}",
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
