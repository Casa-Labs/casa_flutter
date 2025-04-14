import 'package:casaflutterapp/src/auth/model/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final String email;
  ChangePasswordController({
    required this.email,
  });

  // ========= OBJECTS ============= //
  final AuthService _authService = AuthService();

  // ========= CONTROLLERS ========= //
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  // ========= VARIABLES ========= //
  RxBool isPasswordChanged = false.obs;
  RxBool isNewPasswordObscured = true.obs;
  RxBool isConfirmPasswordObscured = true.obs;
  RxString message = ''.obs;
  RxBool isPasswordChangeInProgress = false.obs;

  // ========== UI FUNCTIONS ========== //

  void clearAllControllers() {
    newPassword.clear();
    confirmPassword.clear();
    message('');
    isPasswordChanged(false);
    isNewPasswordObscured(true);
    isConfirmPasswordObscured(true);
    isPasswordChangeInProgress(false);
  }

  @override
  void onReady() {
    clearAllControllers();
    super.onReady();
  }

// ========== APIs FUNCTIONS ========== //
  Future<void> changePassword() async {
    if (newPassword.text.isEmpty) {
      message('Please enter new password');
      isPasswordChanged(false);
    } else if (newPassword.text.isNotEmpty && newPassword.text.length < 8) {
      message('New password length should be greater than 8 character');
      isPasswordChanged(false);
    } else if (confirmPassword.text.isEmpty) {
      message('Please enter confirm password');
      isPasswordChanged(false);
    } else if (confirmPassword.text.isNotEmpty &&
        confirmPassword.text.length < 8) {
      message('Confirm password length should be greater than 8 character');
      isPasswordChanged(false);
    } else if (newPassword.text != confirmPassword.text) {
      message('New password and confirm password are not same');
      isPasswordChanged(false);
    } else {
      isPasswordChangeInProgress(true);

      final updatePasswordAfterVerificationResponse =
          await _authService.updatePasswordAfterVerification(
        email: email,
        newPassword: newPassword.text,
      );

      if (updatePasswordAfterVerificationResponse != null) {
        isPasswordChangeInProgress(false);
        message('Password updated successfully');
        isPasswordChanged(true);
      } else {
        isPasswordChangeInProgress(false);
        message('Password not updated');
        isPasswordChanged(false);
      }
    }
  }

  void showNewPassword() {
    if (isNewPasswordObscured()) {
      isNewPasswordObscured(false);
    } else {
      isNewPasswordObscured(true);
    }
  }

  void showConfirmPassword() {
    if (isConfirmPasswordObscured()) {
      isConfirmPasswordObscured(false);
    } else {
      isConfirmPasswordObscured(true);
    }
  }
}
