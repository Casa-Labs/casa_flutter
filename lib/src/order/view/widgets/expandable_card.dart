import 'package:casa_flutter/src/order/controller/order_review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/text_widgets.dart';

class ExpandableCard extends StatelessWidget {
  final OrderReviewController orderController;
  const ExpandableCard({super.key, required this.orderController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Material(
        elevation: 4,
        surfaceTintColor: Colors.white,
        color: Colors.white,
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
              color: Colors.white,
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
                            BodyText(
                              text: 'To pay ₹${orderController.total}',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
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
                      BodyText(
                        text: 'Item Total: ₹${orderController.itemtotal}',
                        fontSize: 14,
                      ),
                      BodyText(
                        text:
                            'Delivery Fee: ₹${orderController.deliveryCharge}',
                        fontSize: 14,
                      ),
                      BodyText(
                        text: 'Platform Fee: ₹${orderController.platFormFee}',
                        fontSize: 14,
                      ),
                      BodyText(
                        text:
                            'GST and Restaurant Charges: ₹${orderController.gst}',
                        fontSize: 14,
                      ),
                      SizedBox(height: 10),
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
