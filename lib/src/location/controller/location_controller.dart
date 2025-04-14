import 'dart:convert';

import 'package:casaflutterapp/src/location/model/service/location_service.dart';
import 'package:casaflutterapp/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/preference_manager.dart';
import '../../auth/model/auth_models.dart';
import '../../common/widgets/show_toast.dart';

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

  // ========== STATES ========== //

  @override
  void onInit() {
    String fullAddress = PreferenceManager.getString(PreferenceManager.keyAddress) ?? "";
    if(fullAddress.isNotEmpty){
      dataSet();
    }
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    streetAddress.clear();
    city.clear();
    state.clear();
    zipCode.clear();
    landmark.clear();
    country.clear();
    super.dispose();
  }

  // ========= VARIABLES ========= //
  RxString message = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isDeliveryAddressSaved = false.obs;

  // ========== FUNCTIONS ========== //

  dataSet(){
    String fullAddress = PreferenceManager.getString(PreferenceManager.keyAddress) ?? "";
    List<String> parts = fullAddress.split(", ");

    // Assigning values from the list
    String address = parts[0];
    String landmarkValue = parts[1];
    String cityValue = parts[2];
    String stateValue = parts[3];
    String pincode = parts[4];
    String countryValue = parts[5];
    streetAddress.text = address;
    landmark.text = landmarkValue;
    city.text = cityValue;
    state.text = stateValue;
    zipCode.text = pincode;
    country.text = countryValue;
  }

  Future<void> saveDeliveryAddressDetails() async {
    if (streetAddress.text.isEmpty) {
      showToast(message: 'Enter street address');
    }else if (landmark.text.isEmpty) {
      showToast(message: 'Enter landmark');
    }  else if (city.text.isEmpty) {
      showToast(message: 'Enter city');
    } else if (state.text.isEmpty) {
      showToast(message: 'Enter state');
    } else if (zipCode.text.isEmpty) {
      showToast(message: 'Enter pin-code');
    } else if (country.text.isEmpty) {
      showToast(message: 'Enter Country');
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
        final deliveryAddressResponse = await _locationService.addUserAddress(
          userId: userDetails.id ?? '',
          address: streetAddress.text,
          city: city.text,
          state: state.text,
          pinCode: zipCode.text,
          country: country.text,
          landmark: landmark.text,
        );
        if (deliveryAddressResponse!.addUserAddress != null) {
          var userAddress = deliveryAddressResponse.addUserAddress;
          PreferenceManager.setData(
            PreferenceManager.userAddressDetails,
            userAddress?.toJsonString(),
          );
          String fullAddress = "${userAddress!.address}, ${userAddress.landmark}, ${userAddress.city}, ${userAddress.state}, ${userAddress.pincode}, ${userAddress.country}";
          PreferenceManager.setData(PreferenceManager.keyAddress, fullAddress);
          isDeliveryAddressSaved(true);
          router.pop();
          showToast(message: 'Delivery address details saved successfully');
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
