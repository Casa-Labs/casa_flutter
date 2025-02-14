import 'package:flutter/material.dart';

import '../../../common/widgets/app_bar.dart';
import '../widgets/button_widget.dart';
import '../widgets/order_card.dart';
import '../widgets/order_tracker.dart';
import '../widgets/view_button.dart';

class TrackShipment extends StatelessWidget {
  const TrackShipment({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
                Text(
                  "Order packed",
                  style: textTheme.bodyMedium?.copyWith(
                    // fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
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
                Text(
                  "vendor : Zara Mumbai",
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Qty : 1",
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(),
                Text(
                  "Delivery by CASA",
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Tracking Id :182736223993",
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                OrderTracker(statuses: [
                  OrderTrackerModel(
                      status: "Order\nAccepted", isCompleted: true),
                  OrderTrackerModel(
                      status: "Out for\ndelivery", isCompleted: true),
                  OrderTrackerModel(status: "Order\ndelivered"),
                ]),
                const Divider(),
                Text(
                  "Shipping Address",
                  style: textTheme.bodyLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Steve",
                  style: textTheme.bodyMedium,
                ),
                Text(
                  "A1 - 502 Akal Society",
                  style: textTheme.bodyMedium,
                ),
                Text(
                  "J.B. Nagar Andheri East",
                  style: textTheme.bodyMedium,
                ),
                Text(
                  "Mumbai, Maharashtra - 400099 India",
                  style: textTheme.bodyMedium,
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
                Text(
                  "Order Details",
                  style: textTheme.bodyLarge?.copyWith(
                    // fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Date',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Order #',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Order total',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '21-07-2024',
                          style: textTheme.bodyMedium,
                        ),
                        SizedBox(height: 3),
                        Text(
                          '201-2293837-209',
                          textAlign: TextAlign.start,
                          style: textTheme.bodyMedium,
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Rs.2014 (1 item)',
                          style: textTheme.bodyMedium,
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
                Text(
                  'Package was handed to resident',
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          )),
    );
  }
}
