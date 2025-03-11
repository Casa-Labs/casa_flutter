import 'dart:convert';

import 'package:casa_flutter/src/auth/model/auth_models.dart';
import 'package:casa_flutter/src/auth/model/service/auth_service.dart';
import 'package:casa_flutter/utils/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryAddressController extends GetxController {
  // ========= OBJECTS ============= //
  final AuthService _authService = AuthService();

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
        final deliveryAddressResponse = await _authService.addUserAddress(
          userId: userDetails.id ?? '',
          address: streetAddress.text,
          city: city.text,
          state: state.text,
          pinCode: zipCode.text,
          country: 'India',
        );
        if (deliveryAddressResponse != null) {
          isDeliveryAddressSaved(true);
          message('Delivery address details saved successfully');
          isLoading(false);
        } else {
          isLoading(false);
        }
      } else {
        isLoading(false);
      }
    }
  }
}
