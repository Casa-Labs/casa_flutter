import 'package:casa_flutter/src/auth/model/auth_models.dart';
import 'package:casa_flutter/src/auth/model/service/auth_service.dart';
import 'package:casa_flutter/utils/extensions.dart';
import 'package:casa_flutter/utils/preference_manager.dart';
import 'package:casa_flutter/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  // ========= OBJECTS ============= //
  final AuthService _authService = AuthService();

  // ========= CONTROLLERS ========= //
  final TextEditingController registeredEmail = TextEditingController();
  final TextEditingController registeredPassword = TextEditingController();
  final TextEditingController registeredRenterPassword =
      TextEditingController();
  final TextEditingController otp1 = TextEditingController();
  final TextEditingController otp2 = TextEditingController();
  final TextEditingController otp3 = TextEditingController();
  final TextEditingController otp4 = TextEditingController();

  // ========= VARIABLES ========= //
  RxBool checkboxValue = false.obs;
  RxBool isUserRegistered = false.obs;
  RxBool isRegisteredPasswordObscured = true.obs;
  RxBool isRegisteredRenterPasswordObscured = true.obs;
  RxString message = ''.obs;
  RxBool isOtpSent = false.obs;
  RxBool isOtpObscured = true.obs;
  RxBool isOtpVerified = false.obs;
  RxBool isEmailValid = false.obs;

// ========== UI FUNCTIONS ========== //

  void clearAllControllers() {
    registeredEmail.clear();
    registeredPassword.clear();
    registeredRenterPassword.clear();
    otp1.clear();
    otp2.clear();
    otp3.clear();
    otp4.clear();
    message('');
    isRegisteredPasswordObscured(true);
    isRegisteredRenterPasswordObscured(true);
    isUserRegistered(false);
    checkboxValue(false);
    isOtpSent(false);
    isOtpObscured(true);
    isOtpVerified(false);
    isEmailValid(false);
  }

  @override
  void onReady() {
    clearAllControllers();
    super.onReady();
  }

  Future<void> registerUserCall() async {
    if (registeredEmail.text.isEmpty) {
      message('Enter email address');
      isUserRegistered(false);
    } else if (Validators.isTouchedEmailValidator!(registeredEmail.text) !=
        null) {
      message('Email address is not valid');
      isUserRegistered(false);
    } else if (registeredPassword.text.isEmpty) {
      message('Enter password');
      isUserRegistered(false);
    } else if (registeredPassword.text.length < 8) {
      message('Register password length cannot be less than 8 character');
      isUserRegistered(false);
    } else if (registeredRenterPassword.text.isEmpty) {
      message('Re-enter password');
      isUserRegistered(false);
    } else if (registeredRenterPassword.text.length < 8) {
      message('Re-enter password length cannot be less than 8 character');
      isUserRegistered(false);
    } else if (registeredPassword.text != registeredRenterPassword.text) {
      message('Entered password and Re-entered password are not same');
      isUserRegistered(false);
    } else if (!isOtpVerified()) {
      message('Verify otp');
      isUserRegistered(false);
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
        // set only user id
        await PreferenceManager.setData(
          PreferenceManager.userId,
          loginResponse?.register?.user?.id.toString(),
        );
        message('User registered successfully');
        isUserRegistered(true);
      }
    }
  }

  void checkEmailValidation() {
    if (registeredEmail.text.isNotEmpty &&
        Validators.isTouchedEmailValidator!(registeredEmail.text) != null) {
      isEmailValid(false);
    } else {
      isEmailValid(true);
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

  void showOtp() {
    if (isOtpObscured()) {
      isOtpObscured(false);
    } else {
      isOtpObscured(true);
    }
  }

  Future<void> sendOtp() async {
    message('Otp sent to entered email id');
    isOtpSent(true);
  }

  Future<void> verifyOtpCall() async {
    if (otp1.text.isNotEmpty &&
        otp2.text.isNotEmpty &&
        otp3.text.isNotEmpty &&
        otp4.text.isNotEmpty) {
      message('Otp verified successfully');
      isOtpVerified(true);
    }
  }
}
