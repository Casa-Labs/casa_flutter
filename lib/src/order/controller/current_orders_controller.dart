import 'package:casa_flutter/network/graph_ql_manager.dart';
import 'package:casa_flutter/src/order/model/order_models.dart';
import 'package:get/get.dart';

class CurrentOrdersController extends GetxController {
  var isLoading = true.obs;
  final manager = GraphQLManager();

  Future<List<GetOrders>> fetchProducts() async {
    try {
      List<GetOrders> orderList = [];
      var response = await manager.getOrders('4ed11705-112e-4874-a646-0aaf496d5ce2');
      List<dynamic> data = response.data?['getOrders'] ?? [];
       orderList = data.map((json) => GetOrders.fromJson(json)).toList();
      return orderList;
    } catch (e) {
      return [];
    }
  }
}




