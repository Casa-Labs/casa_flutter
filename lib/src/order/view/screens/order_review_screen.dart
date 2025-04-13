import 'package:casaflutterapp/src/common/widgets/common_app_bars.dart';
import 'package:casaflutterapp/src/common/widgets/show_toast.dart';
import 'package:casaflutterapp/src/order/controller/order_review_controller.dart';
import 'package:casaflutterapp/src/order/view/widgets/add_instructions_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/padding_size.dart';
import '../../../../utils/string_constant.dart';
import '../widgets/expandable_card.dart';
import '../widgets/order_view_item_widget.dart';

class OrderReviewScreen extends StatelessWidget {
  const OrderReviewScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orderRiviweCtrl = Get.find<OrderReviewController>();

    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: BackgroundColor.white,
      appBar: CommonAppBar(
        title: 'Order review',
        actions: [
          InkWell(
            overlayColor: WidgetStateProperty.all(ButtonColor.transparent),
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              orderRiviweCtrl.deleteAllItem();
            },
            child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Clear',
                  style: textTheme.bodyMedium,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(PaddingSize.commonPadding),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return ListView.separated(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orderRiviweCtrl.productsList.length,
                          itemBuilder: (context, index) {
                            var product = orderRiviweCtrl.productsList[index];
                            return OrderViewItemWidget(
                              item: product.item!,
                              onorderItemDelete: () {
                                orderRiviweCtrl.deleteItem(product);
                              },
                            );
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: ButtonColor.black),
                                      child: Text(
                                        "Instructions",
                                        style: textTheme.bodyMedium?.copyWith(
                                          // fontSize: 14,
                                          color: TextColor.white,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return AddInstructionsWidget(
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                        orderController: orderRiviweCtrl,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Obx(() {
                return FilledButton(
                  style: FilledButton.styleFrom(
                    surfaceTintColor: const Color(0xFF2C9D24),
                    backgroundColor: const Color(0xFF2C9D24),
                  ),
                  onPressed: () async {
                    // context.pushNamed(RouteNames.paymentOptions);
                    await orderRiviweCtrl.createOrder();
                    if (orderRiviweCtrl.message.isNotEmpty) {
                      showToast(
                        message: orderRiviweCtrl.message(),
                      );
                    }
                  },
                  child: Text(
                    "Pay ₹${orderRiviweCtrl.total}",
                    style: textTheme.bodyMedium?.copyWith(
                      // fontSize: 14,
                      color: TextColor.white,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
