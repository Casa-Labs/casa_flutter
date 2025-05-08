import 'dart:convert';

import 'package:casaflutter/src/location/model/get_user_response_model.dart';
import 'package:casaflutter/src/location/model/service/location_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/preference_manager.dart';
import '../../auth/model/auth_models.dart';

class LocationController extends GetxController {
  // ========= OBJECTS ============= //
  final LocationService _locationService = LocationService();

  // ========= CONTROLLERS ========= //
  final TextEditingController streetAddress = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController zipCode = TextEditingController();
  final TextEditingController landmark = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController tag = TextEditingController();

  // ========= VARIABLES ========= //
  RxString message = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isDeliveryAddressSaved = false.obs;
  RxBool isDetailsValid = false.obs;
  // to store addressId if navigated from address list screen
  String? addressId;

  // ========== STATES ========== //

  @override
  void dispose() {
    streetAddress.clear();
    city.clear();
    state.clear();
    zipCode.clear();
    landmark.clear();
    country.clear();
    tag.clear();
    isDetailsValid(false);
    super.dispose();
  }

  // ========== FUNCTIONS ========== //

  void fetchAddress({
    required Addresses? addresses,
  }) {
    addressId = addresses?.id;
    streetAddress.text = addresses?.address ?? '';
    landmark.text = addresses?.landmark ?? '';
    city.text = addresses?.city ?? '';
    state.text = addresses?.state ?? '';
    zipCode.text = addresses?.pinCode ?? '';
    country.text = addresses?.country ?? '';
    tag.text = addresses?.tag ?? '';
  }

  void checkForValidations() {
    isDetailsValid(false);
    if (tag.text.isEmpty) {
      message('Enter tag');
    } else if (streetAddress.text.isEmpty) {
      message('Enter street address');
    } else if (landmark.text.isEmpty) {
      message('Enter landmark');
    } else if (city.text.isEmpty) {
      message('Enter city');
    } else if (state.text.isEmpty) {
      message('Enter state');
    } else if (zipCode.text.isEmpty) {
      message('Enter pin-code');
    } else if (country.text.isEmpty) {
      message('Enter Country');
    } else {
      isDetailsValid(true);
    }
  }

  Future<void> updateAddress() async {
    isLoading(true);

    final updateAddressResponse = await _locationService.updateUserAddress(
      id: addressId ?? '',
      address: streetAddress.text,
      city: city.text,
      state: state.text,
      pinCode: zipCode.text,
      country: country.text,
      landmark: landmark.text,
      tag: tag.text,
    );

    if (updateAddressResponse != null) {
      isDeliveryAddressSaved(true);
      message('Address details updated successfully');
      isLoading(false);
    } else {
      message('Something went wrong...');
      isLoading(false);
    }
  }

  Future<void> addNewAddress() async {
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
      final deliveryAddressResponse = await _locationService.addUserAddress(
        userId: userDetails.id ?? '',
        address: streetAddress.text,
        city: city.text,
        state: state.text,
        pinCode: zipCode.text,
        country: country.text,
        landmark: landmark.text,
        tag: tag.text,
      );
      if (deliveryAddressResponse!.addUserAddress != null) {
        isDeliveryAddressSaved(true);
        message('Address added successfully');
        isLoading(false);
      } else {
        isDeliveryAddressSaved(false);
        message('Something went wrong...');
        isLoading(false);
      }
    } else {
      isLoading(false);
    }
  }
}
