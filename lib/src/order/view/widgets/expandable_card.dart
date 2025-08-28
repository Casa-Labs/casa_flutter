import 'package:casaflutter/src/order/controller/order_review_controller.dart';
import 'package:casaflutter/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpandableCard extends StatelessWidget {
  final OrderReviewController orderController;
  const ExpandableCard({super.key, required this.orderController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Material(
        elevation: 4,
        surfaceTintColor: ButtonColor.white,
        color: ButtonColor.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFCBCBCB), width: 0.5)),
        child: GestureDetector(
          onTap: () {
            orderController.getExpanded();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 10000),
            // width: 300,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: ButtonColor.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Image.asset(
                        //   "assets/images/order_review_2.png",
                        //   height: 69,
                        //   width: 68,
                        // ),
                        Icon(Icons.filter_frames_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'To pay ₹${orderController.total}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    // fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                            )
                            // BodyText(
                            //   text: '\$58 saved on the total order.',
                            //   fontSize: 14,
                            //   color: Color(0xFF2C9D24),
                            //   fontWeight: FontWeight.w600,
                            // ),
                          ],
                        ),
                      ],
                    ),
                    const Icon(Icons.keyboard_arrow_down)
                  ],
                ),
                if (orderController.isExpaned.value)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text('Item Total: ₹${orderController.total}',
                          style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: 5),
                      Text(
                          // 'Delivery Fee: ₹${orderController.deliveryCharge}',
                          'Delivery Fee: ₹0',
                          style: Theme.of(context).textTheme.bodyMedium),
                      SizedBox(height: 5),
                      // Text('Platform Fee: ₹${orderController.platFormFee}',
                      //     style: Theme.of(context).textTheme.bodyMedium),
                      // SizedBox(height: 10),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
