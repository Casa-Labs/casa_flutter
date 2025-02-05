import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../home/model/home_models.dart';

class OrderReviewController extends GetxController {
  List<String> savedAddresses = ['Navi Mumbai'];
  RxList<ProductModel> productsList = <ProductModel>[].obs;
  RxDouble total = 0.0.obs;
  RxDouble itemtotal = 0.0.obs;
  RxDouble gst = 0.0.obs;
  RxBool isExpaned = false.obs;
  double deliveryCharge = 34.00;
  double platFormFee = 7.00;

  @override
  void onInit() {
    super.onInit();
    getTotalPrice();
  }

  void getExpanded() {
    isExpaned.value = !isExpaned.value;
  }

  void getListData(List<ProductModel> products) {
    productsList.value = products;
    getTotalPrice();
  }

  void deleteItem(ProductModel product) {
    productsList.remove(product);
    getTotalPrice();
  }

  void getTotalPrice() {
    double totalSum = 0.0;
    for (var product in productsList) {
      String cleanedPrice = product.price!
          .replaceAll('Rs.', '')
          .replaceAll(',', '')
          .replaceAll('₹', '')
          .trim();
      double itemPrice = double.parse(cleanedPrice);
      totalSum += itemPrice * product.quantity!;
    }
    itemtotal.value = totalSum;
    gst.value = calculateGST(itemtotal.value);
    total.value = itemtotal.value + gst.value;

    print('Total Price: ${formatTotal(total.value)}');
  }

  double calculateGST(double totalValue) {
    return (totalValue * 18) / 100;
  }

  String formatTotal(double total) {
    final formatter = NumberFormat.decimalPattern('en_IN');
    return formatter.format(total).replaceAll('RS.', '₹');
  }
}
