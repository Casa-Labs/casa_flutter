import 'dart:convert';

import 'package:casaflutterapp/src/auth/model/auth_models.dart';
import 'package:casaflutterapp/src/auth/model/service/auth_service.dart';
import 'package:casaflutterapp/utils/extensions.dart';
import 'package:casaflutterapp/utils/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryAddressController extends GetxController {
  // ========= OBJECTS ============= //
  final AuthService _authService = AuthService();

  // ========= CONTROLLERS ========= //
  final TextEditingController streetAddress = TextEditingController();
  final TextEditingController landMark = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController zipCode = TextEditingController();
  final TextEditingController country = TextEditingController();

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
    } else if (country.text.isEmpty) {
      message('Enter country');
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
          landMark: landMark.text,
          city: city.text,
          state: state.text,
          pinCode: zipCode.text,
          country: country.text,
        );
        if (deliveryAddressResponse != null) {
          PreferenceManager.setData(
            PreferenceManager.userAddressDetails,
            deliveryAddressResponse.addUserAddress?.toJsonString(),
          );
          var userAddress = deliveryAddressResponse.addUserAddress;
          String fullAddress =
              "${userAddress!.address}, ${userAddress.landmark}, ${userAddress.city}, ${userAddress.state}, ${userAddress.pincode}, ${userAddress.country}";
          PreferenceManager.setData(PreferenceManager.keyAddress, fullAddress);
          isLoading(false);
          isDeliveryAddressSaved(true);
          message('Delivery address details saved successfully');
        } else {
          isLoading(false);
        }
      } else {
        isLoading(false);
      }
    }
  }
}
