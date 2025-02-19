import 'package:get/get.dart';

import '../../home/model/home_models.dart';

class ExploreController extends GetxController {
  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //
  final List<ProductModelFilter> brandFilter = [
    ProductModelFilter(leading: '', title: 'Zara'),
    ProductModelFilter(leading: '', title: 'H&M'),
    ProductModelFilter(leading: '', title: 'Gap'),
    ProductModelFilter(leading: '', title: 'CASA'),
    ProductModelFilter(leading: '', title: 'Tommy hilfiger')
  ];
  final List<ProductModelFilter> productFilter = [
    ProductModelFilter(leading: '', title: 'Topwear'),
    ProductModelFilter(leading: '', title: 'Shirt'),
    ProductModelFilter(leading: '', title: 'Sweatshirt'),
    ProductModelFilter(leading: '', title: 'T- shirt'),
    ProductModelFilter(leading: '', title: 'Hoodie')
  ];
  final List<ProductModelFilter> colorFilter = [
    ProductModelFilter(leading: '', title:'Black'),
    ProductModelFilter(leading: '', title:'Brown'),
    ProductModelFilter(leading: '', title:'Green'),
    ProductModelFilter(leading: '', title:'Denim'),
    ProductModelFilter(leading: '', title:'Zebra print')
  ];

  RxInt selectedIndex = 0.obs;

  // ========== STATES ========== //

  // ========== UI FUNCTIONS ========== //

  // ========== APIs FUNCTIONS ========== //
}
