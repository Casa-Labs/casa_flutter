import 'package:casaflutter/src/auth/model/service/auth_service.dart';
import 'package:casaflutter/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // ========= OBJECTS ============= //
  final AuthService _authService = AuthService();

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
  RxBool isOtpSendingInProgress = false.obs;
  RxBool isOtpVerificationInProgress = false.obs;
  RxBool isEmailValid = false.obs;

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
    isOtpSendingInProgress(false);
    isOtpVerificationInProgress(false);
    isEmailValid(false);
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
      isOtpSendingInProgress(true);
      final requestPasswordResetResponse =
          await _authService.requestPasswordReset(
        email: email.text,
      );

      if (requestPasswordResetResponse != null) {
        isOtpSendingInProgress(false);
        message('Otp sent successfully');
        isOtpSent(true);
      } else {
        isOtpSendingInProgress(false);
        message('Invalid user');
        isOtpSent(false);
      }
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
      isOtpVerificationInProgress(true);
      final verifyOTPAndUpdatePasswordResponse =
          await _authService.verifyOTPForPasswordUpdate(
        email: email.text,
        otp: '${otp1.text}${otp2.text}${otp3.text}${otp4.text}',
      );

      if (verifyOTPAndUpdatePasswordResponse != null) {
        isOtpVerificationInProgress(false);
        message('Otp verified successfully');
        isOtpVerified(true);
      } else {
        isOtpVerificationInProgress(false);
        message('Invalid otp');
        isOtpVerified(false);
      }
    }
  }
}
