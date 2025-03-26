import 'dart:convert';

import 'package:casaflutterapp/src/auth/model/auth_models.dart';
import 'package:casaflutterapp/src/auth/model/service/auth_service.dart';
import 'package:casaflutterapp/utils/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalDetailsController extends GetxController {
  // ========= OBJECTS ============= //
  final AuthService _authService = AuthService();

  // ========= CONTROLLERS ========= //
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  // ========= VARIABLES ========= //
  RxString message = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isPersonalDetailsSaved = false.obs;

  void clearAllControllers() {
    firstName.clear();
    lastName.clear();
    phoneNumber.clear();
    isLoading(false);
    isPersonalDetailsSaved(false);
    message('');
  }

  @override
  void onReady() {
    clearAllControllers();
    super.onReady();
  }

  // ========== FUNCTIONS ========== //
  Future<void> savePersonalDetails() async {
    if (firstName.text.isEmpty) {
      message('Enter first name');
    } else if (lastName.text.isEmpty) {
      message('Enter last name');
    } else if (phoneNumber.text.isEmpty) {
      message('Enter phone number');
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
        final userDetailsResponse = await _authService.updateUserDetails(
          userId: userDetails.id ?? '',
          name: '${firstName.text} ${lastName.text}',
          email: userDetails.email ?? '',
          phone: phoneNumber.text,
        );
        if (userDetailsResponse != null) {
          isPersonalDetailsSaved(true);
          message('Personal details saved successfully');
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
