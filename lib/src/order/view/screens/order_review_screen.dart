import 'package:casaflutter/routes/app_routes.dart';
import 'package:casaflutter/src/common/widgets/common_app_bars.dart';
import 'package:casaflutter/src/order/controller/order_review_controller.dart';
import 'package:casaflutter/src/order/view/widgets/add_instructions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/padding_size.dart';
import '../widgets/expandable_card.dart';
import '../widgets/order_view_item_widget.dart';

class OrderReviewScreen extends StatelessWidget {
  OrderReviewScreen({
    super.key,
  });

  final orderReviewController = Get.find<OrderReviewController>();

  @override
  Widget build(BuildContext context) {
    orderReviewController.startBlinking(); // Starts blinking loop

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
              orderReviewController.deleteAllItem();
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
                      Obx(
                        () => ListView.separated(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orderReviewController.productsList.length,
                          itemBuilder: (context, index) {
                            var product =
                                orderReviewController.productsList[index];
                            return OrderViewItemWidget(
                              item: product.item!,
                              onorderItemDelete: () {
                                orderReviewController.deleteItem(product);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                        ),
                      ),
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
                                          return AddInstructionsWidget();
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
                      const SizedBox(height: 10),
                      ExpandableCard(
                        orderController: orderReviewController,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: ButtonColor.white,
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Obx(
                () => AnimatedContainer(
                  duration: const Duration(milliseconds: 900),
                  decoration: BoxDecoration(
                    color: orderReviewController.isBlinking.value
                        ? const Color(0xFF2C9D24)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () async {
                      HapticFeedback.lightImpact();
                      router.pushNamed(RouteNames.addressList);
                    },
                    child: Text(
                      "Pay ₹${orderReviewController.total}",
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ).paddingSymmetric(horizontal: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
