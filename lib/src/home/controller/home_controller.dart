import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/home_models.dart';

class HomeController extends GetxController{
  var products = <ProductModel>[].obs;
  var isLoading = false.obs;
  RxList<ProductModel> reactiveProducts = <ProductModel>[].obs;
  bool isDisabled = false;
  final AppinioSwiperController controller = AppinioSwiperController();
  bool isShowReturn = false;
  bool isShowShipping = false;
  var price = ''.obs;
  var title = ''.obs;
  var id = ''.obs;
  int selectedColorIndex = -1;
  int selectedSizeIndex = -1;
  int cardIndex = 0;
  int currentIndex = 0;
  final ValueNotifier<int> counter = ValueNotifier<int>(1);
  IconData? swipeIcon;


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

  changeShippingPolicy(){
    isShowShipping = !isShowShipping;
    update();
  }

  changeReturnPolicy(){
    isShowReturn = !isShowReturn;
    update();
  }
}