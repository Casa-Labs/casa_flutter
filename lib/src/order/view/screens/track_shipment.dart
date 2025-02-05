import 'package:flutter/material.dart';

import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/text_widgets.dart';
import '../widgets/button_widget.dart';
import '../widgets/order_card.dart';
import '../widgets/order_tracker.dart';
import '../widgets/view_button.dart';

class TrackShipment extends StatelessWidget {
  const TrackShipment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        title: 'Track shipment',
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
                OrderCard(),
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
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Saturday, 21st July 2024',
                        style: TextStyle(
                          fontSize: 14,
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
                SizedBox(height: 20),
                Divider(),
                const BodyText(
                  text: "Delivery by CASA",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                const BodyText(
                  text: "Tracking Id :182736223993",
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                OrderTracker(statuses: [
                  OrderTrackerModel(
                      status: "Order\nAccepted", isCompleted: true),
                  OrderTrackerModel(
                      status: "Out for\ndelivery", isCompleted: true),
                  OrderTrackerModel(status: "Order\ndelivered"),
                ]),
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
                SizedBox(
                  height: 60,
                  child: Row(
                    spacing: 15,
                    children: [
                      ButtonWidget(
                          text: "Update delivery\ninstructions",
                          onPressed: () {}),
                      ButtonWidget(text: "Buy again", onPressed: () {}),
                      ButtonWidget(
                          text: "Return or\nreplace", onPressed: () {}),
                    ],
                  ),
                ),
                const Divider(),
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
                  onPressed: () {},
                  text: 'Download invoice',
                ),
                BodyText(
                  text: 'package was handed to resident',
                ),
              ],
            ),
          )),
    );
  }
}
