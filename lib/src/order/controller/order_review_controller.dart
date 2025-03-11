import 'package:get/get.dart';

import '../../cart/model/cart_models.dart';

class OrderReviewController extends GetxController {
  // ========= OBJECTS ============= //

  // ========= CONTROLLERS ========= //

  // ========= VARIABLES ========= //
  List<String> savedAddresses = ['Navi Mumbai'];
  RxList<CartItem> productsList = <CartItem>[].obs;
  RxDouble total = 0.0.obs;
  RxDouble itemtotal = 0.0.obs;
  RxDouble gst = 0.0.obs;
  RxBool isExpaned = false.obs;
  double deliveryCharge = 34.00;
  double platFormFee = 7.00;

  // ========== STATES ========== //
  void getAllProductItem(List<CartItem> cartList) {
    productsList.assignAll(cartList);
    getTotalPrice();
  }

  // ========== UI FUNCTIONS ========== //
  void getExpanded() {
    isExpaned.value = !isExpaned.value;
  }

  void deleteItem(CartItem product) {
    productsList.remove(product);
    getTotalPrice();
  }

  void deleteAllItem() {
    productsList.clear();
    getTotalPrice();
  }

  void getTotalPrice() {
    double totalSum = 0.0;
    for (var product in productsList) {
      double itemPrice = product.item!.price!.toDouble();
      totalSum += itemPrice * product.item!.quantity!;
    }
    itemtotal.value = totalSum;
    gst.value = calculateGST(itemtotal.value);
    total.value = itemtotal.value + gst.value;
  }

  double calculateGST(double totalValue) {
    return (totalValue * 18) / 100;
  }

  // ========== APIs FUNCTIONS ========== //
}
