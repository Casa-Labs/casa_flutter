import 'package:get/get.dart';

import '../../../utils/preference_manager.dart';
import '../../../utils/utils.dart';
import '../../cart/model/cart_models.dart';
import '../model/create_order.dart';
import '../model/service/order_service.dart';

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
  final OrderService orderService = OrderService();

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
    itemtotal.value = double.parse(totalSum.toStringAsFixed(2));
    gst.value = calculateGST(itemtotal.value);
    total.value =
        double.parse((itemtotal.value + gst.value).toStringAsFixed(2));
  }

  double calculateGST(double totalValue) {
    return double.parse(((totalValue * 18) / 100).toStringAsFixed(2));
  }

  // ========== APIs FUNCTIONS ========== //

  Future<void> createOrder() async {
    List<Items> productItem = [];
    for (var product in productsList) {
      var item = Items();
      item.productId = product.id;
      item.quantity = product.item!.quantity;
      item.price = product.item!.price!;
      // item.color  = product.item!.color!;
      // item.size = product.item!.size!;
      productItem.add(item);
    }
    CreateOrder createOrder = CreateOrder(
        userId: PreferenceManager.getString(PreferenceManager.userId) ?? "",
        items: productItem,
        totalAmount: total.value);
    final createOrderResponse =
        await orderService.createOrder(createOrderRequestModel: createOrder);
   logg.d('create order $createOrderResponse');
  }
}
