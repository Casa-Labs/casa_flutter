import 'package:casa_flutter/src/common/widgets/common_app_bars.dart';
import 'package:casa_flutter/src/order/controller/current_orders_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/app_routes.dart';
import '../../../common/widgets/app_bar.dart';
import '../../../common/widgets/text_widgets.dart';
import '../widgets/order_card.dart';
import '../widgets/order_tracker.dart';
import '../widgets/view_button.dart';

class CurrentOrdersScreen extends StatelessWidget {
  final CurrentOrdersController ordersController =
      Get.put(CurrentOrdersController());
  CurrentOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        isBodyText: true,
        title: 'Current Orders',
      ),
      /*  appBar: CustomAppbar(
        title: 'Current Orders',
        isLeadingBack: true,
        isLeading: false,
        isFilter: false,
        isNotification: false,
      ),*/
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderCard(),
                  SizedBox(height: 20),
                  Text(
                    "Delivery by CASA",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          // fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    "Tracking Id :182736223993",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          // fontSize: 13,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order number #17727722262",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              // fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SmallButton(
                        onPressed: () {
                          context.pushNamed(RouteNames.orderDetails);
                        },
                        text: 'View Detail',
                      )
                    ],
                  ),
                  Divider()
                ],
              );
            },
          )),
    );
  }
}
