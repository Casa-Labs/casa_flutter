import 'package:casaflutter/src/explore/model/service/store_service.dart';
import 'package:casaflutter/src/explore/model/store_model.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //
  // Pagination - temporary calling 100 items
  RxInt page = 1.obs;
  RxInt limit = 30.obs;

  // ========== STATES ========== //

  // ========== UI FUNCTIONS ========== //

  // ========== APIs FUNCTIONS ========== //

  Future<GetStoreInventoryResponseModel> getStoreInventoryByIdCall(
      {required String storeId}) async {
    return await StoreService().getStoreInventoryById(storeId: storeId);
  }
}
