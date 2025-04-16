import 'package:casaflutterapp/network/graph_ql_manager.dart';
import 'package:casaflutterapp/src/order/model/customer_order_model.dart';
import 'package:casaflutterapp/utils/utils.dart';
import 'package:get/get.dart';

import '../../../utils/preference_manager.dart';

class CurrentOrdersController extends GetxController {
  var isLoading = true.obs;
  final userID = PreferenceManager.getString(PreferenceManager.userId);

  Future<GetCustomerOrdersResponseModel> getOrdersCall() async {
    try {
      var response = await GraphQLManager().getOrders(userID!);

      if (!response.hasException && response.data != null) {
        // TODO : parse this response without hard string
        final orderResponse = GetCustomerOrdersResponseModel.fromJson(
            {'customerOrders': response.data!['customerOrders']});
        return orderResponse;
      } else {
        logg.e('Get customer orders Exception: ${response.exception}');
        return GetCustomerOrdersResponseModel();
      }
    } catch (e) {
      logg.e('Exception during getOrdersCall: $e');
      return GetCustomerOrdersResponseModel();
    }
  }
}
