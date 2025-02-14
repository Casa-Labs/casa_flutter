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

class CurrentOrdersScreen extends StatefulWidget {

  CurrentOrdersScreen({super.key});

  @override
  State<CurrentOrdersScreen> createState() => _CurrentOrdersScreenState();
}

class _CurrentOrdersScreenState extends State<CurrentOrdersScreen> {
  final CurrentOrdersController ordersController =
  Get.put(CurrentOrdersController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ordersController.fetchOrders(
        userId: "4ed11705-112e-4874-a646-0aaf496d5ce2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        isBodyText: true,
        title: 'Current Orders',
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Obx(() {
            if (ordersController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (ordersController.orders.isEmpty) {
              return const Center(child: Text("No orders found"));
            }
            return ListView.builder(
              itemCount: ordersController.orders.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                var item=ordersController.orders[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OrderCard(item.orderedProductDetails!,),
                    SizedBox(height: 20),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BodyText(
                          text: "Order number #17727722262",
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
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
            );
          })),
    );
  }
}
