import 'package:casaflutterapp/network/graph_ql_manager.dart';
import 'package:casaflutterapp/src/order/model/order_models.dart';
import 'package:get/get.dart';

import '../../../utils/preference_manager.dart';

class CurrentOrdersController extends GetxController {
  var isLoading = true.obs;
  final manager = GraphQLManager();
  final userID = PreferenceManager.getString(PreferenceManager.userId);

  Future<List<CustomerOrders>> fetchProducts() async {
    try {
      List<CustomerOrders> orderList = [];
      var response = await manager.getOrders(userID!);
      List<CustomerOrders> data = response.data?['customerOrders'] ?? [];
       orderList = data.map((json) => CustomerOrders.fromJson(response.data!)).toList();
      return orderList;
    } catch (e) {
      return [];
    }
  }
}




