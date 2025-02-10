import 'package:get/get.dart';

class ExploreController extends GetxController {
  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //
  final List<String> brandFilter  = ['Zara','H&M','Gap', 'CASA', 'Tommy hilfiger'];
  final List<String> productFilter  = ['Topwear', 'Shirt', 'Sweatshirt', 'T- shirt','Hoodie'];
  final List<String> colorFilter  = ['Black', 'Brown', 'Green', 'Denim','Zebra print'];

  RxInt selectedIndex = 0.obs;

  // ========== STATES ========== //

  // ========== UI FUNCTIONS ========== //

  // ========== APIs FUNCTIONS ========== //
}
