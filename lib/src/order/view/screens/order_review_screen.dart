import 'package:casa_flutter/routes/app_routes.dart';
import 'package:casa_flutter/src/order/controller/order_review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/color_constant.dart';
import '../../../common/widgets/app_bar.dart';
import '../widgets/expandable_card.dart';

class OrderReviewScreen extends StatelessWidget {
  OrderReviewScreen({
    super.key,
  });
  final orderReviewController = Get.put(OrderReviewController());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: BackgroundColor.white,
      appBar: CustomAppbar(
          title: 'Order review',
          isLeadingBack: true,
          isLeading: false,
          isNotification: false,
          isFilter: false),
      body: SafeArea(
        child: Column(
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
                            border: Border.all(color: TextColor.black),
                            borderRadius: BorderRadius.circular(50)),
                        child: CircleAvatar(
                          maxRadius: 24,
                          backgroundColor: const Color(0xFF002957),
                          child: Text(
                            "ZARA".substring(0, 3).toUpperCase(),
                            style: textTheme.bodyMedium?.copyWith(
                              color: TextColor.white,
                              // fontSize: 14,
                            ),
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
                                  color: TextColor.white,
                                  border:
                                      Border.all(color: TextColor.black, width: 0.7),
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
                                          color: ButtonColor.white,
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
                                                      child: Text(
                                                        product.title!,
                                                        style: textTheme.bodyLarge
                                                            ?.copyWith(
                                                          // fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "₹${product.price!.replaceAll('Rs.', '').replaceAll(' ', '')}",
                                                      style: textTheme.bodyLarge
                                                          ?.copyWith(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'Zara',
                                                  style: textTheme.bodyMedium
                                                      ?.copyWith(
                                                    // fontSize: 16,
                                                    color: TextColor.black54,
                                                  ),
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
                                                    Text(
                                                      'Size Guide',
                                                      style: textTheme.bodySmall
                                                          ?.copyWith(
                                                        color: TextColor.black54,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Size:',
                                                      style: textTheme.bodyMedium
                                                          ?.copyWith(
                                                        // fontSize: 14,
                                                        color: TextColor.black54,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      'M',
                                                      style: textTheme.bodyMedium
                                                          ?.copyWith(
                                                        // fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
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
                                                    Text(
                                                      'Quantity:',
                                                      style: textTheme.bodyMedium
                                                          ?.copyWith(
                                                        // fontSize: 14,
                                                        color: TextColor.black54,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
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
                                                      child: Text(
                                                        product.quantity
                                                            .toString(),
                                                        style: textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                          // fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  highlightColor:
                                                      IconColor.transparent,
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
                        surfaceTintColor: ButtonColor.white,
                        color: ButtonColor.white,
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
                                        ButtonColor.transparent),
                                    splashFactory: NoSplash.splashFactory,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: ButtonColor.black),
                                      child: Text(
                                        "Delivery type",
                                        style: textTheme.bodyMedium?.copyWith(
                                          fontSize: 14,
                                          color: TextColor.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    overlayColor: WidgetStateProperty.all(
                                        ButtonColor.transparent),
                                    splashFactory: NoSplash.splashFactory,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: ButtonColor.black),
                                      child: Text(
                                        "Instructions",
                                        style: textTheme.bodyMedium?.copyWith(
                                          // fontSize: 14,
                                          color: TextColor.white,
                                        ),
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
                                      Text(
                                        "Standard",
                                        style: textTheme.bodyMedium?.copyWith(
                                          // fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF4220FF),
                                        ),
                                      ),
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
              color: ButtonColor.white,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "PAY USING",
                            style: textTheme.bodyMedium?.copyWith(
                              // fontSize: 14,
                              color: TextColor.black,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_up,
                          )
                        ],
                      ),
                      Text(
                        "Phone Pay",
                        style: textTheme.bodyMedium?.copyWith(
                          // fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: TextColor.black,
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    return FilledButton(
                      style: FilledButton.styleFrom(
                        surfaceTintColor: const Color(0xFF2C9D24),
                        backgroundColor: const Color(0xFF2C9D24),
                      ),
                      onPressed: () {
                        context.pushNamed(RouteNames.paymentOptions);
                      },
                      child: Text(
                        "Pay ₹${orderReviewController.total}",
                        style: textTheme.bodyMedium?.copyWith(
                          // fontSize: 14,
                          color: TextColor.white,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
