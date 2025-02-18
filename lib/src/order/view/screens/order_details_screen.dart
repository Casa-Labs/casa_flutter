import 'package:casa_flutter/utils/color.dart';
import 'package:casa_flutter/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';
import '../../../../utils/font.dart';
import '../../../common/widgets/app_bar.dart';
import '../widgets/order_card.dart';
import '../widgets/view_button.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: BackgroundColor.white,
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
                Text(
                  "Shipment details",
                  style: textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(
                  "Tracking Id :182736223993",
                  style: textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                OrderCard(),
                SizedBox(height: 10),
                Text(
                  "Order packed",
                  style: textTheme.bodyMedium?.copyWith(
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
                          // fontFamily: Font.gilroy,
                          fontWeight: FontWeight.w500,
                          color: TextColor.black,
                        ),
                      ),
                      TextSpan(
                        text: 'Saturday, 21st July 2024',
                        style: TextStyle(
                          fontSize: 14,
                          // fontFamily: Font.gilroy,
                          fontWeight: FontWeight.w500,
                          color: TextColor.green,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "vendor : Zara Mumbai",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Qty : 1",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
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
                        Text(
                          'Track shipment',
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
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
                Text(
                  "Order Details",
                  style: textTheme.bodyMedium?.copyWith(
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
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Order #',
                            textAlign: TextAlign.start,
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'Order total',
                            textAlign: TextAlign.start,
                            style: textTheme.bodyMedium?.copyWith(
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
                          '21-07-2024 ',
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
                  onPressed: () {
                    context.pushNamed(RouteNames.orderDetails);
                  },
                  text: 'Download invoice',
                ),
                Divider(),
                Text(
                  "Payment Information",
                  style: textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: CColor.borderColor, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Method',
                            style: textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Visa ending in 7834',
                            style: textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Icon(Icons.chevron_right)
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Divider(),
                Text(
                  "Shipping Address",
                  style: textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
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
                Text(
                  "Order Summary",
                  style: textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                _orderSummary(context)
              ],
            ),
          )),
    );
  }

  _orderSummary(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Items:",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "\$767.00",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Postage and Packing:",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "\$20.00",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Before Tax:",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "\$760.00",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tax:",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              "\$7.00",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total:",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              "\$768.00",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order Total:",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(/* fontSize: 14 */ fontWeight: FontWeight.w600),
            ),
            Text(
              "\$784.00",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(/* fontSize: 14, */ fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
