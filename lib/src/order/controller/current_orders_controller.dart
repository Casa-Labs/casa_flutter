import 'package:casa_flutter/network/graph_ql_manager.dart';
import 'package:casa_flutter/src/order/model/order_models.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CurrentOrdersController extends GetxController {
  var orders = <GetOrders>[].obs;
  var isLoading = true.obs;

  void fetchOrders({required String userId}) async {
    isLoading(true);
    try {
      QueryResult result = await GraphQLManager().getOrders(userId);
      if (result.hasException) {
        print("GraphQL Error: ${result.exception}");
        Get.snackbar("Error", result.exception.toString());
        return;
      }
      print("API Response: ${result.data}");
      List<dynamic> data = result.data?['getOrders'] ?? [];
      List<GetOrders> orderList = data.map((json) => GetOrders.fromJson(json)).toList();
      orders.assignAll(orderList);
    } catch (e) {
      print('Error => : ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}




