import 'package:casaflutter/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // ========= CONTROLLERS ========= //
  final TextEditingController email = TextEditingController();
  final TextEditingController otp1 = TextEditingController();
  final TextEditingController otp2 = TextEditingController();
  final TextEditingController otp3 = TextEditingController();
  final TextEditingController otp4 = TextEditingController();

  // ========= VARIABLES ========= //
  RxBool isOtpSent = false.obs;
  RxBool isOtpVerified = false.obs;
  RxBool isOtpObscured = true.obs;
  RxString message = ''.obs;

  // ========== UI FUNCTIONS ========== //

  void clearAllControllers() {
    email.clear();
    otp1.clear();
    otp2.clear();
    otp3.clear();
    otp4.clear();
    isOtpSent(false);
    isOtpVerified(false);
    isOtpObscured(true);
    message('');
  }

  @override
  void onReady() {
    clearAllControllers();
    super.onReady();
  }

  // ========== APIs FUNCTIONS ========== //
  Future<void> sentOtpCall() async {
    if (email.text.isEmpty) {
      message('Enter email address');
      isOtpSent(false);
    } else if (Validators.isTouchedEmailValidator!(email.text) != null) {
      message('Email address is not valid');
      isOtpSent(false);
    } else {
      message('Otp sent successfully');
      isOtpSent(true);
    }
  }

  void showOtp() {
    if (isOtpObscured()) {
      isOtpObscured(false);
    } else {
      isOtpObscured(true);
    }
  }

  Future<void> verifyOtpCall() async {
    if (otp1.text.isEmpty ||
        otp2.text.isEmpty ||
        otp3.text.isEmpty ||
        otp4.text.isEmpty) {
      message('Please enter correct otp');
      isOtpVerified(false);
    } else {
      message('Otp verified successfully');
      isOtpVerified(true);
    }
  }
}
