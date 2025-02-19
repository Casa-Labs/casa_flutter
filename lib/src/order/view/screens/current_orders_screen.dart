import 'package:casa_flutter/src/common/widgets/common_app_bars.dart';
import 'package:casa_flutter/src/order/controller/current_orders_controller.dart';
import 'package:casa_flutter/src/order/model/order_models.dart';
import 'package:casa_flutter/utils/padding_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_routes.dart';
import '../../../../utils/color_constant.dart';
import '../widgets/order_card.dart';
import '../widgets/order_tracker.dart';
import '../widgets/view_button.dart';

class CurrentOrdersScreen extends StatelessWidget {
  CurrentOrdersScreen({super.key});

  final ordersController = Get.put(CurrentOrdersController());

  @override
  Widget build(BuildContext context) {
    late Future<List<GetOrders>> orderFuture = ordersController.fetchProducts();
    return Scaffold(
      backgroundColor: BackgroundColor.white,
      appBar: CommonAppBar(
        isBodyText: true,
        title: 'Current Orders',
      ),
      body: SafeArea(
        child: FutureBuilder(
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
                          horizontal: 20, vertical: 10),
                      child: ListView.builder(
                        itemCount: orderItem!.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OrderCard(),
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
                                OrderTrackerModel(
                                    status: "Order\nAccepted", isCompleted: true),
                                OrderTrackerModel(
                                    status: "Out for\ndelivery",
                                    isCompleted: true),
                                OrderTrackerModel(status: "Order\ndelivered"),
                              ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order number #17727722262",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
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
                      ));
                },
              );
            }
          },
        ),
      ),

    );
  }
}
