import 'package:casa_flutter/src/explore/model/service/explore_service.dart';
import 'package:get/get.dart';

class ExploreController extends GetxController {
  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //
  final List<String> brandFilter = [
    'Zara',
    'H&M',
    'Gap',
    'CASA',
    'Tommy hilfiger'
  ];
  final List<String> productFilter = [
    'Topwear',
    'Shirt',
    'Sweatshirt',
    'T- shirt',
    'Hoodie'
  ];
  final List<String> colorFilter = [
    'Black',
    'Brown',
    'Green',
    'Denim',
    'Zebra print'
  ];

  RxInt selectedIndex = 0.obs;

  // Pagination
  RxInt page = 1.obs;
  RxInt limit = 5.obs;

  // ========== STATES ========== //

  // @override
  // void onReady() {
  //   super.onReady();
  //   getTrendingNowProductsCall();
  // }

  // ========== UI FUNCTIONS ========== //

  // ========== APIs FUNCTIONS ========== //

  Future<void> getTrendingNowProductsCall() async {
    await ExploreService().getTrendingNowProducts();
  }
}
