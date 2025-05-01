import 'package:casaflutterapp/network/graph_ql_manager.dart';
import 'package:casaflutterapp/src/explore/controller/store_controller.dart';
import 'package:casaflutterapp/src/explore/model/store_model.dart';
import 'package:casaflutterapp/utils/utils.dart';
import 'package:get/get.dart';

class StoreService {
  final storeCtrl = Get.find<StoreController>();

  Future<GetStoreInventoryResponseModel> getStoreInventoryById(
      {required String storeId}) async {
    var response = await GraphQLManager().getStoreInventoryById(
        page: storeCtrl.page(), limit: storeCtrl.limit(), storeId: storeId);

    if (!response.hasException && response.data != null) {
      final storeInventoryResponse =
          GetStoreInventoryResponseModel.fromJson(response.data!);
      return storeInventoryResponse;
    } else {
      logg.e('Get store inventory by ID Exception: ${response.exception}');
      return GetStoreInventoryResponseModel();
    }
  }
}
