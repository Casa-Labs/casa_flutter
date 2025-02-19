import 'dart:math';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../network/graph_ql_manager.dart';
import '../model/home_models.dart';

class HomeController extends GetxController{

  // ========= CONTROLLERS ========= //

  final AppinioSwiperController controller = AppinioSwiperController();


  // ========= VARIABLES ========= //


  bool isDisabled = false;
  var products = <Product>[].obs;
  var isLoading = false.obs;
  RxList<Product> reactiveProducts = <Product>[].obs;
  bool isShowReturn = false;
  bool isShowShipping = false;
  bool isShowFilter = true;
  var price = ''.obs;
  var title = ''.obs;
  var id = ''.obs;
  int selectedColorIndex = -1;
  int selectedSizeIndex = -1;
  int cardIndex = 0;
  int currentIndex = 0;
  final ValueNotifier<int> counter = ValueNotifier<int>(1);
  IconData? swipeIcon;
  final List<ProductModelFilter> brandFilter = [
    ProductModelFilter(leading: 'Z', title: 'Zara'),
    ProductModelFilter(leading: 'H', title: 'H&M'),
    ProductModelFilter(leading: 'G', title: 'Gap'),
    ProductModelFilter(leading: 'C', title: 'CASA'),
    ProductModelFilter(leading: 'T', title: 'Tommy hilfiger')
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
  final List<ProductModelFilter> sizedFilter = [
    ProductModelFilter(leading: '', title: 'XXS'),
    ProductModelFilter(leading: '', title: 'XS'),
    ProductModelFilter(leading: '', title: 'S'),
    ProductModelFilter(leading: '', title: 'M'),
    ProductModelFilter(leading: '', title: 'L'),
    ProductModelFilter(leading: '', title: 'XL'),
    ProductModelFilter(leading: '', title: 'XXL')
  ];
  final manager = GraphQLManager();

  // ========== STATES ========== //

  // ========== UI FUNCTIONS ========== //

  void onEnd() {
    if (kDebugMode) {
      print('end reached!');
    }
  }

  void swipeEnd(int previousIndex, int targetIndex, SwiperActivity activity) {
    cardIndex = targetIndex;
    // price.value = reactiveProducts[targetIndex].price!;
    // title.value = reactiveProducts[targetIndex].title!;
    // id.value = reactiveProducts[targetIndex].id!;
    currentIndex = targetIndex;
    counter.value = 1;
    switch (activity) {
      case Swipe():
        if (kDebugMode) {
          print('The card was swiped to the: ${activity.direction}');
          print('Previous index: $previousIndex, Target index: $targetIndex');
        }
        // Add conditions for swipe directions
          if (activity.direction == AxisDirection.left) {
            swipeIcon = Icons.check_rounded; // ✅ Right Swipe
          } else if (activity.direction == AxisDirection.right) {
            swipeIcon = Icons.close_rounded; // ❌ Left Swipe
          }

          // Hide the icon after some time
          Future.delayed(Duration(milliseconds: 500), () {
                swipeIcon = null;
                update();
          });
          update();
        break;

      case Unswipe():
        if (kDebugMode) {
          print('A ${activity.direction.name} swipe was undone.');
          print('Previous index: $previousIndex, Target index: $targetIndex');
        }
        break;

      case CancelSwipe():
        if (kDebugMode) {
          print('A swipe was cancelled');
        }
        break;

      case DrivenActivity():
        if (kDebugMode) {
          print('Driven Activity');
        }
        break;
    }
    update();
  }

  showFilter(){
    isShowFilter = !isShowFilter;
    update();
  }

  changeShippingPolicy(){
    isShowShipping = !isShowShipping;
    update();
  }

  changeReturnPolicy(){
    isShowReturn = !isShowReturn;
    update();
  }

// ========== APIs FUNCTIONS ========== //

  Future<List<Product>> fetchProducts(Map<String, dynamic> map) async {
    try {
      List<Product> products = [];
      var response = await manager.getProducts(map);
      products = GetProducts.fromJson(response.data!['getProducts']).data!;
      // Attempt to convert the document data to a ProductModel

      products.shuffle(Random());

      return products;
    } catch (e) {
      return [];
    }
  }
}