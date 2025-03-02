import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryAddressController extends GetxController {
  // ========= CONTROLLERS ========= //
  final TextEditingController streetAddress = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController zipCode = TextEditingController();

  // ========= VARIABLES ========= //
  RxString message = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isDeliveryAddressSaved = false.obs;

  void clearAllControllers() {
    streetAddress.clear();
    city.clear();
    state.clear();
    zipCode.clear();
    isLoading(false);
    isDeliveryAddressSaved(false);
    message('');
  }

  @override
  void onReady() {
    clearAllControllers();
    super.onReady();
  }

  // ========== FUNCTIONS ========== //
  Future<void> saveDeliveryAddressDetails() async {
    if (streetAddress.text.isEmpty) {
      message('Enter street address');
    } else if (city.text.isEmpty) {
      message('Enter city');
    } else if (state.text.isEmpty) {
      message('Enter state');
    } else if (zipCode.text.isEmpty) {
      message('Enter zip-code');
    } else {
      isLoading(true);
      isDeliveryAddressSaved(true);
      message('Delivery address details saved successfully');
      isLoading(false);
    }
  }
}
