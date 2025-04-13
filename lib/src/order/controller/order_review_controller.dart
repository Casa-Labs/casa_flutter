import 'dart:convert';

import 'package:casaflutterapp/src/auth/model/add_user_address_response_model.dart';
import 'package:casaflutterapp/src/common/payment/razorpay.dart';
import 'package:casaflutterapp/src/order/model/service/order_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../utils/preference_manager.dart';
import '../../../utils/utils.dart';
import '../../auth/model/auth_models.dart';
import '../../cart/controller/cart_controller.dart';
import '../../cart/model/cart_models.dart';
import '../../home/model/home_models.dart';
import '../model/create_order.dart';

class OrderReviewController extends GetxController {
  // ========= OBJECTS ============= //
  final OrderService _orderService = OrderService();

  // ========= CONTROLLERS ========= //
  CartController cartController = Get.find<CartController>();
  TextEditingController instructionController = TextEditingController();
  // ========= VARIABLES ========= //
  List<String> savedAddresses = ['Navi Mumbai'];
  RxList<CartItem> productsList = <CartItem>[].obs;
  RxDouble total = 0.0.obs;
  RxDouble itemtotal = 0.0.obs;
  RxDouble gst = 0.0.obs;
  RxBool isExpaned = false.obs;
  double deliveryCharge = 34.00;
  double platFormFee = 7.00;
  RxString message = ''.obs;

  // ========== STATES ========== //

  void getHomeProduct(Product product, int quantity, String selectedSize) {
    String sizeID = "";
    for (var sizes in product.sizes!) {
      if (selectedSize == SizeItem.mapSize(sizes.size!.name!)) {
        sizeID = sizes.size!.id!;
      }
    }
    CartItem homeProduct = CartItem(
        item: ProductForCart.fromJson({
          "productId": product.id,
          "name": product.name,
          "productPrice": product.price,
          "mainImage": product.mainImage,
          "color": product.colors!.first.color!.id,
          "size": sizeID,
          "sizeValue": selectedSize,
          "description": product.description,
          "quantity": quantity, // Add quantity field
        }),
        createdAt: "",
        id: "",
        updatedAt: "");
    getAllProductItem([homeProduct]);
  }

  void getAllProductItem(List<CartItem> cartList) {
    productsList.assignAll(cartList);
    instructionController.clear();
    getTotalPrice();
  }

  // ========== UI FUNCTIONS ========== //
  void getExpanded() {
    isExpaned.value = !isExpaned.value;
  }

  void deleteItem(CartItem product) {
    if (product.id! != "") {
      cartController.removeItemFromCart(product.id!);
    }
    productsList.remove(product);
    getTotalPrice();
  }

  void deleteAllItem() {
    if (productsList.length == 1 && productsList.first.id != null) {
      cartController.removeItemFromCart(productsList.first.id!);
    } else if (productsList.length > 1) {
      cartController.removeAllItemFromCart();
    }
    productsList.clear();
    getTotalPrice();
  }

  void getTotalPrice() {
    double totalSum = 0.0;
    for (var product in productsList) {
      double itemPrice = product.item!.productPrice!.toDouble();
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
      item.productId = product.item?.productId;
      item.quantity = product.item?.quantity;
      item.price = product.item?.productPrice!;
      item.color = product.item?.color!;
      item.size = product.item?.size!;
      productItem.add(item);
    }

    // get user details
    final userDetailsData = PreferenceManager.getString(
      PreferenceManager.userDetails,
    );
    var userDetailsMap = <String, dynamic>{};
    if (userDetailsData != null) {
      userDetailsMap = json.decode(userDetailsData.trim());
    }
    final userDetails = User.fromJson(userDetailsMap);

    // get user address details
    final userAddressDetails =
        PreferenceManager.getString(PreferenceManager.userAddressDetails);
    var userAddressDetailsMap = <String, dynamic>{};
    if (userAddressDetails != null) {
      userAddressDetailsMap = json.decode(userAddressDetails.trim());
    }
    final addressDetails = AddUserAddress.fromJson(userAddressDetailsMap);
    final shippingInfo = ShippingInfo(
      name: userDetails.name,
      city: addressDetails.city,
      pincode: int.parse(addressDetails.pincode ?? '0'),
      address: addressDetails.address,
    );

    CreateOrder createOrder = CreateOrder(
      userId: PreferenceManager.getString(PreferenceManager.userId) ?? "",
      items: productItem,
      totalAmount: total.value.toInt(),
      shippingInfo: shippingInfo,
      deliveryType: 'STANDARD',
      deliveryInstructions: instructionController.text,
      paymentInfo: PaymentInfo(
        method: "CARD",
        paidAmount: total.value.toInt(),
        paymentDate: "2025-01-20",
        serviceProvider: "razorpay",
      ),
      discountCode: "CASA20",
    );

    final createOrderResponse = await _orderService.createOrder(
      createOrderRequestModel: createOrder,
    );

    // call razorpay payment gateway
    if (createOrderResponse != null &&
        (createOrderResponse
                    .createOrder?.paymentOrderDetails?.razorpayOrderId ??
                '')
            .isNotEmpty &&
        (createOrderResponse.createOrder?.paymentOrderDetails?.amount ?? 0) >
            0) {
      final amount =
          (createOrderResponse.createOrder?.paymentOrderDetails?.amount ?? 0) *
              100;
      await callPaymentGateway(
        razorPayOrderId: createOrderResponse
                .createOrder?.paymentOrderDetails?.razorpayOrderId ??
            '',
        amount: amount.toInt(),
      );
    }

    logg.d('create order $createOrderResponse');
  }

  Future<void> callPaymentGateway({
    required String razorPayOrderId,
    required int amount,
  }) async {
    Payment.of(
      amount: amount, // Amount
      orderId: razorPayOrderId, // Order ID of Razorpay
      handlePaymentSuccess: (final PaymentSuccessResponse? response) {
        _handlePaymentSuccess(response);
      }, // Success Handler
      handlePaymentError: (final PaymentFailureResponse? response) {
        //showToast(message: response?.message ?? '');
        message(response?.message ?? '');
      }, // Error Handler
      handleExternalWallet: (final ExternalWalletResponse? response) {
        //showToast(message: 'External Wallet - ${response?.walletName ?? ''}');
        message('External Wallet - ${response?.walletName ?? ''}');
      }, // External wallet Handler
    );
  }

  Future<void> _handlePaymentSuccess(
    final PaymentSuccessResponse? response,
  ) async {
    // verify Payment
    final verifyPaymentResponse = await _orderService.verifyPayment(
      paymentId: response?.paymentId ?? '',
      orderId: response?.orderId ?? '',
      signature: response?.signature ?? '',
    );

    if (verifyPaymentResponse != null &&
        verifyPaymentResponse.verifyPayment?.success == true &&
        (verifyPaymentResponse.errorMessage ?? '').isEmpty) {
      //showToast(message: 'Payment is successful.');
      message('Order placed successfully');
    } else {
      //showToast(message: verifyPaymentResponse?.errorMessage ?? '');
      message(
        verifyPaymentResponse?.errorMessage ??
            verifyPaymentResponse?.verifyPayment?.message,
      );
    }
  }
}
