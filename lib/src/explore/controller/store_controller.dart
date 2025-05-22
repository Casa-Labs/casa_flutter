import 'package:casaflutter/src/explore/model/service/store_service.dart';
import 'package:casaflutter/src/explore/model/store_model.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';

class StoreController extends GetxController {
  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //
  // Pagination - temporary calling 100 items
  RxInt page = 1.obs;
  RxInt limit = 30.obs;

  RxList<GetStoreInventory> storeInventory = <GetStoreInventory>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool hasMore = true.obs;

  // ========== STATES ========== //

  @override
  void onInit() {
    super.onInit();
    // Do nothing here, let the screen call with ID
  }

  // ========== UI FUNCTIONS ========== //

  // ========== APIs FUNCTIONS ========== //

  Future<void> getStoreInventoryByIdCall(
      {required String storeId, bool isInitial = false}) async {
    try {
      if (isInitial) {
        page.value = 1;
        hasMore.value = true;
        storeInventory.clear();
      }

      isInitial ? isLoading.value = true : isLoadingMore.value = true;

      final response =
          await StoreService().getStoreInventoryById(storeId: storeId);
      final fetchedList = response.getStoreInventory ?? [];

      if (fetchedList.length < limit.value) {
        hasMore.value = false;
      }

      if (isInitial) {
        storeInventory.value = fetchedList;
      } else {
        storeInventory.addAll(fetchedList);
      }

      page.value += 1;
    } catch (e) {
      logg.e("Pagination Error: $e");
      rethrow;
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }
}
