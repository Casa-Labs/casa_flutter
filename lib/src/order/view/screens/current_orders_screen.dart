import 'package:casaflutterapp/src/common/widgets/common_app_bars.dart';
import 'package:casaflutterapp/src/order/controller/current_orders_controller.dart';
import 'package:casaflutterapp/src/order/model/customer_order_model.dart';
import 'package:casaflutterapp/utils/padding_size.dart';
import 'package:casaflutterapp/utils/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/color_constant.dart';
import '../widgets/order_card.dart';
import '../widgets/order_tracker.dart';

class CurrentOrdersScreen extends StatelessWidget {
  final bool isHistory;

  CurrentOrdersScreen({super.key, required this.isHistory});

  final ordersController = Get.put(CurrentOrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor.white,
      appBar: CommonAppBar(
        isBodyText: true,
        title: isHistory ? 'My Orders' : 'Order History',
      ),
      body: isHistory
          ? FutureBuilder<GetCustomerOrdersResponseModel>(
              future: ordersController.getOrdersCall(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Can't fetch order"));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text("No Order available"));
                } else {
                  var orderList = snapshot.data?.customerOrders ?? [];

                  if (orderList.isEmpty) {
                    return const Center(child: Text("Order list empty"));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: PaddingSize.commonPadding,
                      vertical: 10,
                    ),
                    itemCount: orderList.length,
                    itemBuilder: (context, orderIndex) {
                      final order = orderList[orderIndex];
                      final orderItems = order.items ?? [];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...orderItems.map((item) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                OrderCard(
                                  imageUrl: item.product?.mainImage ??
                                      ImageConstants.dummyNetworkPortrait,
                                  name: item.product?.name ?? 'API Error',
                                  price: item.price?.toString() ?? 'API Error',
                                  brandName: item.product?.store?.name ??
                                      'Unknown Store',
                                  quantity: item.quantity?.toString() ?? '1',
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  "Delivery by CASA",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  "Tracking Id :182736223993", // Static for now
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                OrderTracker(statuses: [
                                  OrderTrackerModel(
                                      status: "Order\nAccepted",
                                      isCompleted: true),
                                  OrderTrackerModel(
                                    status: "Out for\ndelivery",
                                    isCompleted: order.status == "SHIPPED" ||
                                        order.status == "DELIVERED",
                                  ),
                                  OrderTrackerModel(
                                    status: "Order\ndelivered",
                                    isCompleted: order.status == "DELIVERED",
                                  ),
                                ]),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Order number #${item.id ?? 'API Error'}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                    // Uncomment and customize if needed
                                    // SmallButton(
                                    //   onPressed: () {
                                    //     context.pushNamed(
                                    //       RouteNames.orderDetails,
                                    //       extra: {
                                    //         "selectedItem": item,
                                    //         "orderData": order,
                                    //       },
                                    //     );
                                    //   },
                                    //   text: 'View Detail',
                                    // )
                                  ],
                                ),
                                const Divider(),
                              ],
                            );
                          })
                        ],
                      );
                    },
                  );
                }
              },
            )

          // FutureBuilder<GetCustomerOrdersResponseModel>(
          //         future: ordersController.getOrdersCall(),
          //         builder: (context, snapshot) {
          //           if (snapshot.connectionState == ConnectionState.waiting) {
          //             return const Center(child: CircularProgressIndicator());
          //           } else if (snapshot.hasError) {
          //             return const Center(child: Text("Can't fetch order"));
          //           } else if (!snapshot.hasData || snapshot.data == null) {
          //             return const Center(child: Text("No Order available"));
          //           } else {
          //             var orderItems = snapshot.data?.customerOrders ?? [];
          //             return GetBuilder<CurrentOrdersController>(
          //               builder: (logic) {
          //                 return Padding(
          //                     padding: const EdgeInsets.symmetric(
          //                         horizontal: PaddingSize.commonPadding,
          //                         vertical: 10),
          //                     child: ListView.builder(
          //                       itemCount: orderItems.length,
          //                       shrinkWrap: true,
          //                       itemBuilder: (BuildContext context, int index) {
          //                         // final items = orderItems[index].items ?? [];
          //                         // final item = items[index];
          //                         // final orderStatus = orderItems[index].status;
          //                         // var orderStatus = orderItem[0]
          //                         //     .status; // Get order status from API
          //                         //var trackingSteps = getOrderTrackingSteps(orderStatus!);
          //
          //                         final items = orderItems[index].items ?? [];
          //                         if (items.isEmpty)
          //                           return SizedBox(); // or display a placeholder
          //                         final item = items.first;
          //                         final orderStatus = orderItems[index].status;
          //
          //                         return Column(
          //                           crossAxisAlignment: CrossAxisAlignment.start,
          //                           children: [
          //                             OrderCard(
          //                               imageUrl: item.product?.mainImage ??
          //                                   ImageConstants.dummyNetworkPortrait,
          //                               name: item.product?.name ?? 'API Error',
          //                               price: item.price.toString() ?? 'API Error',
          //                               brandName: item.product?.store?.name ??
          //                                   'API Error',
          //                               quantity:
          //                                   item.quantity.toString() ?? 'API Error',
          //                             ),
          //                             SizedBox(height: 20),
          //                             Text(
          //                               "Delivery by CASA",
          //                               style: Theme.of(context)
          //                                   .textTheme
          //                                   .bodySmall
          //                                   ?.copyWith(
          //                                     // fontSize: 13,
          //                                     fontWeight: FontWeight.w600,
          //                                   ),
          //                             ),
          //                             Text(
          //                               "Tracking Id :182736223993",
          //                               style: Theme.of(context)
          //                                   .textTheme
          //                                   .bodySmall
          //                                   ?.copyWith(
          //                                     // fontSize: 13,
          //                                     fontWeight: FontWeight.w600,
          //                                   ),
          //                             ),
          //                             OrderTracker(statuses: [
          //                               OrderTrackerModel(
          //                                   status: "Order\nAccepted",
          //                                   isCompleted: true),
          //                               OrderTrackerModel(
          //                                   status: "Out for\ndelivery",
          //                                   isCompleted: orderStatus == "SHIPPED" ||
          //                                       orderStatus == "DELIVERED"),
          //                               OrderTrackerModel(
          //                                   status: "Order\ndelivered",
          //                                   isCompleted:
          //                                       orderStatus == "DELIVERED"),
          //                             ]),
          //                             Row(
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment.spaceBetween,
          //                               children: [
          //                                 Expanded(
          //                                   child: Text(
          //                                     "Order number #${item.id ?? 'API Error'}",
          //                                     style: Theme.of(context)
          //                                         .textTheme
          //                                         .bodySmall
          //                                         ?.copyWith(
          //                                           // fontSize: 13,
          //                                           fontWeight: FontWeight.w600,
          //                                         ),
          //                                   ),
          //                                 ),
          //                                 // SmallButton(
          //                                 //   onPressed: () {
          //                                 //     context.pushNamed(
          //                                 //       RouteNames.orderDetails,
          //                                 //       extra: {
          //                                 //         "selectedItem": item,
          //                                 //         "orderData": item,
          //                                 //       },
          //                                 //     );
          //                                 //   },
          //                                 //   text: 'View Detail',
          //                                 // )
          //                               ],
          //                             ),
          //                             Divider()
          //                           ],
          //                         );
          //                       },
          //                     ));
          //               },
          //             );
          //           }
          //         },
          //       )
          : Center(child: Text("No Order available")),
    );
  }
}
