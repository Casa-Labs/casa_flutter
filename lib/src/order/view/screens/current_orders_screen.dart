import 'package:casaflutter/src/common/widgets/common_app_bars.dart';
import 'package:casaflutter/src/order/controller/current_orders_controller.dart';
import 'package:casaflutter/src/order/model/order_models.dart';
import 'package:casaflutter/utils/padding_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/color_constant.dart';
import '../widgets/order_card.dart';
import '../widgets/order_tracker.dart';
import '../widgets/view_button.dart';

class CurrentOrdersScreen extends StatelessWidget {
  final bool isHistory;

  CurrentOrdersScreen({super.key, required this.isHistory});

  final ordersController = Get.put(CurrentOrdersController());

  @override
  Widget build(BuildContext context) {
    late Future<List<OrderModel>> orderFuture = ordersController.fetchProducts();
    return Scaffold(
      backgroundColor: BackgroundColor.white,
      appBar: CommonAppBar(
        isBodyText: true,
        title: isHistory?'My Orders':'Order History',
      ),
      body: SafeArea(
        child: isHistory?FutureBuilder(
          future: orderFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Can't fetch order"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No Order available"));
            } else {
              var orderItem = snapshot.data;
              return GetBuilder<CurrentOrdersController>(
                builder: (logic) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: PaddingSize.commonPadding, vertical: 10),
                      child: ListView.builder(
                        itemCount: orderItem![0].orderedItems!.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          var item=orderItem[0].orderedItems![index];
                          var orderStatus = orderItem[0].status; // Get order status from API
                          //var trackingSteps = getOrderTrackingSteps(orderStatus!);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OrderCard(orderItem: item),
                              SizedBox(height: 20),
                              Text(
                                "Delivery by CASA",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      // fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Text(
                                "Tracking Id :182736223993",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      // fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              OrderTracker(statuses: [
                                OrderTrackerModel(status: "Order\nAccepted", isCompleted: true),
                                OrderTrackerModel(
                                    status: "Out for\ndelivery",
                                    isCompleted: orderStatus == "SHIPPED" || orderStatus == "DELIVERED"),
                                OrderTrackerModel(status: "Order\ndelivered", isCompleted: orderStatus == "DELIVERED"),
                              ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Order number #${orderItem[0].orderNumber}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            // fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  SmallButton(
                                    onPressed: () {
                                      context.pushNamed(
                                        RouteNames.orderDetails,
                                        extra: {
                                          "selectedItem": item,
                                          "orderData": orderItem[0],
                                        },
                                      );
                                    },
                                    text: 'View Detail',
                                  )
                                ],
                              ),
                              Divider()
                            ],
                          );
                        },
                      ));
                },
              );
            }
          },
        ):Center(child: Text("No Order available")),
      ),

    );
  }

}
