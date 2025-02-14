import 'package:casa_flutter/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/font.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/text_widgets.dart';
import '../widgets/order_card.dart';
import '../widgets/view_button.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: 'Order details',
        isLeadingBack: true,
        isLeading: false,
        isFilter: false,
        isNotification: false,
        isSupport: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BodyText(
                  text: "Shipment details",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                const BodyText(
                  text: "Tracking Id :182736223993",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 10),
                OrderCard(null),
                SizedBox(height: 10),
                const BodyText(
                  text: "Order packed",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'delivery date : ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: Font.gilroy,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Saturday, 21st July 2024',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: Font.gilroy,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                const BodyText(
                  text: "vendor : Zara Mumbai",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                const BodyText(
                  text: "Qty : 1",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 15),
                InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    context.pushNamed(RouteNames.trackShipment);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: CColor.borderColor, width: 2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BodyText(
                          text: 'Track shipment',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const BodyText(
                  text: "Order Details",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BodyText(
                            text: 'Order Date',
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 3),
                          BodyText(
                            text: 'Order #',
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 3),
                          BodyText(
                            text: 'Order total',
                            textAlign: TextAlign.start,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BodyText(
                          text: '21-07-2024 ',
                        ),
                        SizedBox(height: 3),
                        BodyText(
                          text: '201-2293837-209',
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 3),
                        BodyText(
                          text: 'Rs.2014(i item)',
                        ),
                      ],
                    )
                  ],
                ),
                const Divider(height: 20),
                SmallButton(
                  onPressed: () {
                    context.pushNamed(RouteNames.orderDetails);
                  },
                  text: 'Download invoice',
                ),
                Divider(),
                const BodyText(
                  text: "Payment Information",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: CColor.borderColor, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BodyText(
                            fontSize: 14,
                            text: 'Payment Method',
                            fontWeight: FontWeight.bold,
                          ),
                          BodyText(
                              fontSize: 14,
                              text: 'Visa ending in 7834',
                              fontWeight: FontWeight.w600)
                        ],
                      ),
                      Icon(Icons.chevron_right)
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(),
                const BodyText(
                  text: "Shipping Address",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 8),
                const BodyText(
                  text: "Steve",
                ),
                const BodyText(
                  text: "A1 - 502 Akal Society",
                ),
                const BodyText(
                  text: "J.B. Nagar Andheri East",
                ),
                const BodyText(
                  text: "Mumbai, Maharashtra - 400099 India",
                ),
                const SizedBox(height: 12),
                const Divider(),
                const BodyText(
                  text: "Order Summary",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 8),
                _orderSummary()
              ],
            ),
          )),
    );
  }

  _orderSummary() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodyText(
              text: "Items:",
            ),
            BodyText(
              text: "\$767.00",
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodyText(
              text: "Postage and Packing:",
            ),
            BodyText(
              text: "\$20.00",
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodyText(
              text: "Total Before Tax:",
            ),
            BodyText(
              text: "\$760.00",
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodyText(
              text: "Tax:",
            ),
            BodyText(
              text: "\$7.00",
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodyText(
              text: "Total:",
              fontWeight: FontWeight.w600,
            ),
            BodyText(
              text: "\$768.00",
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodyText(
              text: "Order Total:",
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            BodyText(
              text: "\$784.00",
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ],
    );
  }
}
