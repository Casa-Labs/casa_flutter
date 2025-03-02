import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalDetailsController extends GetxController {
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
      isPersonalDetailsSaved(true);
      message('Personal details saved successfully');
      isLoading(false);
    }
  }
}
