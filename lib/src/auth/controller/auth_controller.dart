import 'package:casa_flutter/utils/extensions.dart';
import 'package:casa_flutter/utils/preference_manager.dart';
import 'package:casa_flutter/utils/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../model/auth_models.dart';
import '../model/service/auth_service.dart';

class AuthController extends GetxController {
  // ========= OBJECTS ============= //
  final AuthService _authService = AuthService();

  // ========= CONTROLLERS ========= //
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController registeredEmail = TextEditingController();
  final TextEditingController registeredPassword = TextEditingController();
  final TextEditingController registeredRenterPassword =
      TextEditingController();
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  // ========= VARIABLES ========= //
  RxBool checkboxValue = false.obs;
  RxBool isLoggedIn = false.obs;
  RxBool isPasswordObscured = true.obs;
  RxBool isRegisteredPasswordObscured = true.obs;
  RxBool isRegisteredRenterPasswordObscured = true.obs;
  RxBool isOldPasswordObscured = true.obs;
  RxBool isNewPasswordObscured = true.obs;
  RxBool isConfirmPasswordObscured = true.obs;
  RxString message = ''.obs;

  // ========== STATES ========== //

  // ========== UI FUNCTIONS ========== //

  void clearAllControllers() {
    email.clear();
    password.clear();
    registeredEmail.clear();
    registeredPassword.clear();
    registeredRenterPassword.clear();
    oldPassword.clear();
    newPassword.clear();
    confirmPassword.clear();
    isLoggedIn(false);
    message('');
    isPasswordObscured(true);
    isRegisteredPasswordObscured(true);
    isRegisteredRenterPasswordObscured(true);
    isOldPasswordObscured(true);
    isNewPasswordObscured(true);
    isConfirmPasswordObscured(true);
    checkboxValue(false);
  }

  @override
  void onReady() {
    clearAllControllers();
    super.onReady();
  }

  // ========== APIs FUNCTIONS ========== //
  Future<void> loginUserCall() async {
    if (email.text.isEmpty) {
      message('Enter email address');
      isLoggedIn(false);
    } else if (Validators.isTouchedEmailValidator!(email.text) != null) {
      message('Email address is not valid');
      isLoggedIn(false);
    } else if (password.text.isEmpty) {
      message('Enter password');
      isLoggedIn(false);
    } else {
      LoginRequestModel loginRequestModel = LoginRequestModel(
        username: email.text,
        password: password.text,
      );

      final loginResponse = await _authService.loginUser(
        loginRequestModel: loginRequestModel,
      );

      if (loginResponse?.login != null) {
        // set token to storage
        await PreferenceManager.setData(
          PreferenceManager.token,
          loginResponse?.login?.token,
        );
        // set user details
        await PreferenceManager.setData(
          PreferenceManager.userDetails,
          loginResponse?.login?.user?.toJsonString(),
        );
        message('User logged in successfully');
        isLoggedIn(true);
      }
    }
  }

  void showPassword() {
    if (isPasswordObscured()) {
      isPasswordObscured(false);
    } else {
      isPasswordObscured(true);
    }
  }

  Future<void> registerUserCall() async {
    if (registeredEmail.text.isEmpty) {
      message('Enter email address');
      isLoggedIn(false);
    } else if (Validators.isTouchedEmailValidator!(registeredEmail.text) !=
        null) {
      message('Email address is not valid');
      isLoggedIn(false);
    } else if (registeredPassword.text.isEmpty) {
      message('Enter password');
      isLoggedIn(false);
    } else if (registeredPassword.text.length < 8) {
      message('Register password length cannot be less than 8 character');
      isLoggedIn(false);
    } else if (registeredRenterPassword.text.isEmpty) {
      message('Re-enter password');
      isLoggedIn(false);
    } else if (registeredRenterPassword.text.length < 8) {
      message('Re-enter password length cannot be less than 8 character');
      isLoggedIn(false);
    } else if (registeredPassword.text != registeredRenterPassword.text) {
      message('Entered password and Re-entered password are not same');
      isLoggedIn(false);
    } else {
      LoginRequestModel loginRequestModel = LoginRequestModel(
        username: registeredEmail.text,
        password: registeredPassword.text,
      );

      final loginResponse = await _authService.registerUser(
        loginRequestModel: loginRequestModel,
      );

      if (loginResponse?.register != null) {
        // set token to storage
        await PreferenceManager.setData(
          PreferenceManager.token,
          loginResponse?.register?.token,
        );
        // set user details
        await PreferenceManager.setData(
          PreferenceManager.userDetails,
          loginResponse?.register?.user?.toJsonString(),
        );
        message('User registered successfully');
        isLoggedIn(true);
      }
    }
  }

  void showRegisteredPassword() {
    if (isRegisteredPasswordObscured()) {
      isRegisteredPasswordObscured(false);
    } else {
      isRegisteredPasswordObscured(true);
    }
  }

  void showRegisteredRenterPassword() {
    if (isRegisteredRenterPasswordObscured()) {
      isRegisteredRenterPasswordObscured(false);
    } else {
      isRegisteredRenterPasswordObscured(true);
    }
  }

  Future<void> changePassword() async {
    if (oldPassword.text.isEmpty) {
      message('Please enter old password');
      isLoggedIn(false);
    } else if (oldPassword.text.isNotEmpty && oldPassword.text.length < 8) {
      message('Old password length should be greater than 8 character');
      isLoggedIn(false);
    } else if (newPassword.text.isEmpty) {
      message('Please enter new password');
      isLoggedIn(false);
    } else if (newPassword.text.isNotEmpty && newPassword.text.length < 8) {
      message('New password length should be greater than 8 character');
      isLoggedIn(false);
    } else if (confirmPassword.text.isEmpty) {
      message('Please enter confirm password');
      isLoggedIn(false);
    } else if (confirmPassword.text.isNotEmpty &&
        confirmPassword.text.length < 8) {
      message('Confirm password length should be greater than 8 character');
      isLoggedIn(false);
    } else if (newPassword.text != confirmPassword.text) {
      message('New password and confirm password are not same');
      isLoggedIn(false);
    } else if (oldPassword.text == newPassword.text) {
      message('Old password and new password cannot be same');
      isLoggedIn(false);
    } else {
      ChangePasswordRequestModel changePasswordRequestModel =
          ChangePasswordRequestModel(
        oldPassword: oldPassword.text,
        newPassword: newPassword.text,
      );

      final changePasswordResponse = await _authService.changePassword(
        changePasswordRequestModel: changePasswordRequestModel,
      );

      if (changePasswordResponse != null &&
          (changePasswordResponse.id ?? '').isNotEmpty) {
        message('Password changes successfully');
        isLoggedIn(false);
      }
    }
  }

  void showOldPassword() {
    if (isOldPasswordObscured()) {
      isOldPasswordObscured(false);
    } else {
      isOldPasswordObscured(true);
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
