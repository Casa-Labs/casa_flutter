import 'dart:async';
import 'dart:convert';

import 'package:casaflutter/src/common/payment/razorpay.dart';
import 'package:casaflutter/src/common/widgets/show_toast.dart';
import 'package:casaflutter/src/location/model/get_user_response_model.dart';
import 'package:casaflutter/src/location/model/service/location_service.dart';
import 'package:casaflutter/src/order/model/service/order_service.dart';
import 'package:casaflutter/src/order/model/verify_payment_response_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../utils/bool.dart';
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
  final LocationService _locationService = LocationService();

  // ========= CONTROLLERS ========= //
  CartController cartController = Get.find<CartController>();
  TextEditingController instructionController = TextEditingController();
  // ========= VARIABLES ========= //
  List<String> savedAddresses = ['Navi Mumbai'];
  RxList<CartItem> productsList = <CartItem>[].obs;
  RxDouble total = 0.0.obs;
  RxDouble itemtotal = 0.0.obs;
  RxDouble tax = 0.0.obs;
  RxDouble baseAmount = 0.0.obs;
  RxDouble gst = 0.0.obs;
  RxBool isExpaned = false.obs;
  double deliveryCharge = 0.00;
  double platFormFee = 0.00;
  RxString message = ''.obs;
  RxBool isBlinking = false.obs;
  Timer? _blinkingTimer;
  RxBool isDeliveryAddressAdded = false.obs;

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
          "size": sizeID,
          "sizes": product.sizes?.map((e) => e.toJson()).toList(),
          "color": product.colors!.first.color!.id,
          "store": product.store!.toJson(),
          "mainImage": product.mainImage,
          "description": product.description,
          "sizeValue": selectedSize,
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
    tax.value = double.parse((itemtotal.value * 18 / 118).toStringAsFixed(2));
    baseAmount.value =
        double.parse((itemtotal.value - tax.value).toStringAsFixed(2));
    total.value = double.parse(
        (itemtotal.value + deliveryCharge + platFormFee).toStringAsFixed(2));
  }

  // ========== APIs FUNCTIONS ========== //
  Future<void> checkForAddress() async {
    // get user details
    final userDetailsData = PreferenceManager.getString(
      PreferenceManager.userDetails,
    );
    var userDetailsMap = <String, dynamic>{};
    if (userDetailsData != null) {
      userDetailsMap = json.decode(userDetailsData.trim());
    }
    final userDetails = User.fromJson(userDetailsMap);
    if (userDetails.id != null) {
      final getUserResponse = await _locationService.getUser(
        userId: userDetails.id ?? '',
      );
      if (getUserResponse != null &&
          (getUserResponse.getUser?.addresses ?? []).isNotEmpty) {
        isDeliveryAddressAdded(true);
      } else {
        isDeliveryAddressAdded(false);
        message('Please add delivery address, then continue...');
      }
      // get user address details
      /*  final userAddressDetails =
          PreferenceManager.getString(PreferenceManager.userAddressDetails);
      if ((userAddressDetails ?? '').isEmpty) {
        isDeliveryAddressAdded(false);
        message('Please add delivery address, then continue...');
      } else {
        isDeliveryAddressAdded(true);
      }*/
    }
  }

  Future<void> createOrder({
    required Addresses address,
    required VoidCallback onPaymentSuccess,
  }) async {
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

    final shippingInfo = ShippingInfo(
      name: userDetails.name,
      city: address.city,
      pincode: address.pinCode ?? '0',
      address: address.address,
    );

    CreateOrderRequest createOrder = CreateOrderRequest(
      input: CreateOrderInput(
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
        discountCode: null, // currently not implemented on backend - 30/08/2025
      ),
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
        onPaymentSuccess: onPaymentSuccess,
      );
    } else {
      Boolean.isPaymentLoading.value = false;
    }

    logg.d('create order $createOrderResponse');
  }

  Future<void> callPaymentGateway({
    required String razorPayOrderId,
    required int amount,
    required VoidCallback onPaymentSuccess,
  }) async {
    Payment.of(
      amount: amount, // Amount
      orderId: razorPayOrderId, // Order ID of Razorpay
      handlePaymentSuccess: (final PaymentSuccessResponse? response) async {
        final verifyPaymentResponse = await _handlePaymentSuccess(response);
        if (verifyPaymentResponse != null &&
            verifyPaymentResponse.verifyPayment?.success == true &&
            (verifyPaymentResponse.errorMessage ?? '').isEmpty) {
          showToast(
            message: 'Order placed successfully',
          );
          deleteAllItem();
          onPaymentSuccess();
        } else {
          final errorMessage = verifyPaymentResponse?.errorMessage ??
              verifyPaymentResponse?.verifyPayment?.message;
          showToast(message: errorMessage ?? '');
          Boolean.isPaymentLoading.value = false;
        }
      }, // Success Handler
      handlePaymentError: (final PaymentFailureResponse? response) {
        showToast(message: response?.message ?? '');
        Boolean.isPaymentLoading.value = false;
      }, // Error Handler
      handleExternalWallet: (final ExternalWalletResponse? response) {
        showToast(message: 'External Wallet - ${response?.walletName ?? ''}');
        Boolean.isPaymentLoading.value = false;
      }, // External wallet Handler
    );
  }

  Future<VerifyPaymentResponseModel?> _handlePaymentSuccess(
    final PaymentSuccessResponse? response,
  ) async {
    // verify Payment
    final verifyPaymentResponse = await _orderService.verifyPayment(
      paymentId: response?.paymentId ?? '',
      orderId: response?.orderId ?? '',
      signature: response?.signature ?? '',
    );

    return verifyPaymentResponse;
  }

  void startBlinking() {
    if (_blinkingTimer != null && _blinkingTimer!.isActive) return;
    _blinkingTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (productsList.isEmpty) {
        timer.cancel();
        isBlinking.value = false;
      } else {
        isBlinking.value = !isBlinking.value;
      }
    });
  }
}
