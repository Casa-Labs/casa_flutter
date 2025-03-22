import 'package:casaflutter/network/graph_ql_manager.dart';
import 'package:casaflutter/src/order/model/order_models.dart';
import 'package:get/get.dart';

import '../../../utils/preference_manager.dart';

class CurrentOrdersController extends GetxController {
  var isLoading = true.obs;
  final manager = GraphQLManager();
  final userID = PreferenceManager.getString(PreferenceManager.userId);

  Future<List<OrderModel>> fetchProducts() async {
    try {
      List<OrderModel> orderList = [];
      var response = await manager.getOrders(userID!);
      List<dynamic> data = response.data?['myOrders'] ?? [];
       orderList = data.map((json) => OrderModel.fromJson(json)).toList();
      return orderList;
    } catch (e) {
      return [];
    }
  }
}




